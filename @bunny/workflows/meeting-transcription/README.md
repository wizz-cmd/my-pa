# Meeting Transcription Workflow

Automatische Verarbeitung von Meeting-Aufnahmen (Plaud Note) mit Speaker Recognition und Obsidian-Integration.

## Übersicht

```
Audio File → Plaud API → Obsidian Meeting Note + Journal + Actions
```

## Voraussetzungen

- Plaud.ai Account mit API-Zugang
- Plaud API Key in `.env` oder macOS Keychain
- jq installiert (`brew install jq`)

## Dateien

| Datei | Beschreibung |
|-------|--------------|
| `process-meeting.sh` | Hauptscript für Meeting-Verarbeitung |
| `plaud-api.sh` | Plaud API Wrapper |
| `speaker-mapping.json` | Bekannte Speaker-Zuordnungen |

## Verwendung

### Automatisch (Ingest Folder)
```bash
# Audio in Ingest/meetings/ ablegen
# Conny verarbeitet bei: "Conny, process meetings"
```

### Manuell
```bash
./process-meeting.sh /path/to/meeting.m4a "Meeting Titel"
```

## Conny-Befehle

| Befehl | Funktion |
|--------|----------|
| `Conny, process meetings` | Alle Audio-Dateien in Ingest/meetings/ verarbeiten |
| `Conny, transcribe [file]` | Einzelne Datei verarbeiten |

## Output

1. **Meeting Note:** `3. Meetings/YYYY/MM/MEETING-YYYYMMDD-NNN - Titel.md`
2. **Journal Entry:** Summary in `Journal-YYYY-MM.md`
3. **Action Items:** Automatisch in `5. Actions/_active/`

## Konfiguration

### API Key Setup
```bash
# Option 1: .env Datei
echo "PLAUD_API_KEY=your_key_here" > .env

# Option 2: macOS Keychain
security add-generic-password -a "plaud-api" -s "plaud-api-key" -w "your_key_here"
```

### Speaker Profiles
Siehe: `~/localvault/Chris Notes/2. Resources/Speaker-Profiles.md`

---

*Erstellt: 2026-01-22 von Bunny*
