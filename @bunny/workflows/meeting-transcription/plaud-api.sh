#!/bin/bash
# plaud-api.sh - Plaud API Wrapper für Meeting Transcription
# Erstellt: 2026-01-22 von Bunny

set -e

# ============================================================
# KONFIGURATION
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/.env"

# API Endpoint (Plaud Developer Platform)
PLAUD_API_BASE="https://api.plaud.ai/v1"

# ============================================================
# API KEY LADEN
# ============================================================

get_api_key() {
    # Option 1: Environment Variable
    if [[ -n "${PLAUD_API_KEY}" ]]; then
        echo "${PLAUD_API_KEY}"
        return 0
    fi

    # Option 2: .env Datei
    if [[ -f "${ENV_FILE}" ]]; then
        source "${ENV_FILE}"
        if [[ -n "${PLAUD_API_KEY}" ]]; then
            echo "${PLAUD_API_KEY}"
            return 0
        fi
    fi

    # Option 3: macOS Keychain
    if command -v security &> /dev/null; then
        local key=$(security find-generic-password -a "plaud-api" -s "plaud-api-key" -w 2>/dev/null || true)
        if [[ -n "${key}" ]]; then
            echo "${key}"
            return 0
        fi
    fi

    echo "ERROR: Plaud API Key nicht gefunden" >&2
    echo "Setze PLAUD_API_KEY in .env oder macOS Keychain" >&2
    return 1
}

# ============================================================
# API FUNKTIONEN
# ============================================================

# Audio-Datei hochladen und transkribieren
transcribe_audio() {
    local audio_file="$1"
    local language="${2:-auto}"  # auto, de, en

    if [[ ! -f "${audio_file}" ]]; then
        echo "ERROR: Audio-Datei nicht gefunden: ${audio_file}" >&2
        return 1
    fi

    local api_key=$(get_api_key)

    echo "Uploading to Plaud API..." >&2

    # API Call für Transcription mit Speaker Diarization
    curl -s -X POST "${PLAUD_API_BASE}/transcribe" \
        -H "Authorization: Bearer ${api_key}" \
        -H "Content-Type: multipart/form-data" \
        -F "file=@${audio_file}" \
        -F "language=${language}" \
        -F "diarization=true" \
        -F "summarize=true" \
        -F "extract_actions=true"
}

# Transkription-Status prüfen (für async processing)
check_status() {
    local job_id="$1"
    local api_key=$(get_api_key)

    curl -s -X GET "${PLAUD_API_BASE}/transcribe/${job_id}" \
        -H "Authorization: Bearer ${api_key}"
}

# Ergebnis abrufen
get_result() {
    local job_id="$1"
    local api_key=$(get_api_key)

    curl -s -X GET "${PLAUD_API_BASE}/transcribe/${job_id}/result" \
        -H "Authorization: Bearer ${api_key}"
}

# ============================================================
# MAIN
# ============================================================

case "${1}" in
    transcribe)
        transcribe_audio "${2}" "${3}"
        ;;
    status)
        check_status "${2}"
        ;;
    result)
        get_result "${2}"
        ;;
    *)
        echo "Usage: $0 {transcribe|status|result} [args]"
        echo ""
        echo "Commands:"
        echo "  transcribe <audio_file> [language]  - Transcribe audio file"
        echo "  status <job_id>                     - Check transcription status"
        echo "  result <job_id>                     - Get transcription result"
        exit 1
        ;;
esac
