#!/bin/bash
# process-meeting.sh - Meeting Audio zu Obsidian Workflow
# Erstellt: 2026-01-22 von Bunny

set -e

# ============================================================
# KONFIGURATION
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OBSIDIAN_VAULT="$HOME/localvault/Chris Notes"
INGEST_DIR="${OBSIDIAN_VAULT}/Ingest/meetings"
PROCESSED_DIR="${OBSIDIAN_VAULT}/Ingest/processed/meetings"
MEETINGS_DIR="${OBSIDIAN_VAULT}/3. Meetings"
TEMPLATE_FILE="${OBSIDIAN_VAULT}/Templates/Meeting-Transcript-Template.md"
SPEAKER_PROFILES="${OBSIDIAN_VAULT}/2. Resources/Speaker-Profiles.md"

# ============================================================
# HILFSFUNKTIONEN
# ============================================================

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

error() {
    echo "[ERROR] $1" >&2
    exit 1
}

# Nächste verfügbare Meeting-ID für heute
get_next_meeting_id() {
    local date_str=$(date '+%Y%m%d')
    local count=1

    while [[ -d "${MEETINGS_DIR}/$(date '+%Y/%m')" ]]; do
        local existing=$(find "${MEETINGS_DIR}/$(date '+%Y/%m')" -name "MEETING-${date_str}-*.md" 2>/dev/null | wc -l | tr -d ' ')
        count=$((existing + 1))
        break
    done

    printf "MEETING-%s-%03d" "${date_str}" "${count}"
}

# Speaker-Label zu Person mappen
map_speaker() {
    local speaker_label="$1"
    local speaker_profiles_json="${SCRIPT_DIR}/speaker-mapping.json"

    if [[ -f "${speaker_profiles_json}" ]]; then
        local mapped=$(jq -r --arg label "${speaker_label}" '.mappings[$label] // empty' "${speaker_profiles_json}")
        if [[ -n "${mapped}" ]]; then
            echo "[[${mapped}]]"
            return 0
        fi
    fi

    # Fallback: Speaker Label beibehalten
    echo "${speaker_label}"
}

# ============================================================
# HAUPTVERARBEITUNG
# ============================================================

process_audio_file() {
    local audio_file="$1"
    local meeting_title="${2:-Meeting}"

    if [[ ! -f "${audio_file}" ]]; then
        error "Audio-Datei nicht gefunden: ${audio_file}"
    fi

    log "Verarbeite: ${audio_file}"

    # 1. Plaud API aufrufen
    log "Sende an Plaud API..."
    local api_response=$("${SCRIPT_DIR}/plaud-api.sh" transcribe "${audio_file}")

    if [[ -z "${api_response}" ]]; then
        error "Keine Antwort von Plaud API"
    fi

    # 2. JSON parsen
    local transcript=$(echo "${api_response}" | jq -r '.transcript // empty')
    local summary=$(echo "${api_response}" | jq -r '.summary // empty')
    local speakers=$(echo "${api_response}" | jq -r '.speakers // []')
    local action_items=$(echo "${api_response}" | jq -r '.action_items // []')
    local key_points=$(echo "${api_response}" | jq -r '.key_points // []')
    local duration=$(echo "${api_response}" | jq -r '.duration_seconds // 0')
    local language=$(echo "${api_response}" | jq -r '.language // "auto"')

    if [[ -z "${transcript}" ]]; then
        error "Kein Transkript in API-Antwort"
    fi

    # 3. Meeting-ID und Dateinamen generieren
    local meeting_id=$(get_next_meeting_id)
    local date_str=$(date '+%Y-%m-%d')
    local time_str=$(date '+%H:%M')
    local year_month=$(date '+%Y/%m')
    local archive_month=$(date '+%Y-%m')

    # 4. Output-Verzeichnis erstellen
    mkdir -p "${MEETINGS_DIR}/${year_month}"
    mkdir -p "${PROCESSED_DIR}/${archive_month}"

    # 5. Meeting Note erstellen
    local meeting_file="${MEETINGS_DIR}/${year_month}/${meeting_id} - ${meeting_title}.md"

    log "Erstelle Meeting Note: ${meeting_file}"

    # Participants formatieren
    local participants_md=""
    for speaker in $(echo "${speakers}" | jq -r '.[] | @base64'); do
        local label=$(echo "${speaker}" | base64 -d | jq -r '.label')
        local mapped=$(map_speaker "${label}")
        participants_md="${participants_md}- ${mapped} (${label})\n"
    done

    # Action Items formatieren
    local actions_md=""
    local action_count=1
    for item in $(echo "${action_items}" | jq -r '.[] | @base64'); do
        local desc=$(echo "${item}" | base64 -d | jq -r '.description // .')
        local assignee=$(echo "${item}" | base64 -d | jq -r '.assignee // "TBD"')
        actions_md="${actions_md}- [ ] ${desc} (→ ${assignee})\n"
        action_count=$((action_count + 1))
    done

    # Key Points formatieren
    local keypoints_md=""
    for point in $(echo "${key_points}" | jq -r '.[]'); do
        keypoints_md="${keypoints_md}- ${point}\n"
    done

    # Transkript formatieren (mit Timestamps)
    local transcript_md=$(echo "${transcript}" | jq -r '
        if type == "array" then
            .[] | "### [\(.timestamp // "00:00")] \(.speaker // "Speaker")\n\(.text)\n"
        else
            .
        end
    ')

    # Duration in Minuten
    local duration_min=$((duration / 60))

    # Meeting Note schreiben
    cat > "${meeting_file}" << EOF
---
id: ${meeting_id}
date: ${date_str}
time: ${time_str}
duration: ${duration_min} min
source: Plaud Note
language: ${language}
audio_file: $(basename "${audio_file}")
---

# [${meeting_id}] ${meeting_title}

## Metadata
- **Datum:** ${date_str} ${time_str}
- **Dauer:** ${duration_min} Minuten
- **Quelle:** Plaud Note Recording
- **Sprache:** ${language}

## Teilnehmer
$(echo -e "${participants_md}")

## Zusammenfassung
${summary}

## Wichtige Punkte
$(echo -e "${keypoints_md}")

## Action Items
$(echo -e "${actions_md}")

---

## Vollständiges Transkript

${transcript_md}

---

**Audio:** [[Ingest/processed/meetings/${archive_month}/$(basename "${audio_file}")]]
EOF

    log "Meeting Note erstellt: ${meeting_file}"

    # 6. Audio-Datei archivieren
    mv "${audio_file}" "${PROCESSED_DIR}/${archive_month}/"
    log "Audio archiviert: ${PROCESSED_DIR}/${archive_month}/$(basename "${audio_file}")"

    # 7. Ausgabe für Conny (zur weiteren Verarbeitung)
    echo "---MEETING_PROCESSED---"
    echo "MEETING_ID=${meeting_id}"
    echo "MEETING_FILE=${meeting_file}"
    echo "TITLE=${meeting_title}"
    echo "DATE=${date_str}"
    echo "DURATION=${duration_min}"
    echo "SUMMARY=${summary}"
    echo "ACTION_COUNT=$((action_count - 1))"
    echo "---END---"
}

# ============================================================
# BATCH PROCESSING
# ============================================================

process_all_pending() {
    log "Prüfe Ingest-Ordner: ${INGEST_DIR}"

    local count=0
    for audio_file in "${INGEST_DIR}"/*.{m4a,mp3,wav,M4A,MP3,WAV} 2>/dev/null; do
        if [[ -f "${audio_file}" ]]; then
            local filename=$(basename "${audio_file}" | sed 's/\.[^.]*$//')
            process_audio_file "${audio_file}" "${filename}"
            count=$((count + 1))
        fi
    done

    if [[ ${count} -eq 0 ]]; then
        log "Keine Audio-Dateien zum Verarbeiten gefunden"
    else
        log "Verarbeitet: ${count} Meeting(s)"
    fi
}

# ============================================================
# MAIN
# ============================================================

case "${1}" in
    --file|-f)
        if [[ -z "${2}" ]]; then
            error "Bitte Audio-Datei angeben"
        fi
        process_audio_file "${2}" "${3:-Meeting}"
        ;;
    --all|-a)
        process_all_pending
        ;;
    --help|-h)
        echo "Usage: $0 [OPTIONS]"
        echo ""
        echo "Options:"
        echo "  -f, --file <audio> [title]  Einzelne Datei verarbeiten"
        echo "  -a, --all                   Alle Dateien in Ingest/meetings/ verarbeiten"
        echo "  -h, --help                  Diese Hilfe anzeigen"
        echo ""
        echo "Beispiele:"
        echo "  $0 --file meeting.m4a \"Team Standup\""
        echo "  $0 --all"
        ;;
    *)
        # Default: Alle verarbeiten
        process_all_pending
        ;;
esac
