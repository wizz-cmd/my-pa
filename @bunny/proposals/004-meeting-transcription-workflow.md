# Proposal 004: Meeting Transcription Workflow

**Status:** ✅ IMPLEMENTIERT
**Erstellt:** 2026-01-22
**Implementiert:** 2026-01-22

---

## Problem Statement

Meeting-Aufnahmen (Plaud Note) müssen manuell transkribiert und in Obsidian dokumentiert werden. Dabei gehen oft:
- Action Items verloren
- Speaker-Zuordnungen sind unklar
- Keine automatische Verknüpfung mit Projekten/Personen
- Zeitaufwändige manuelle Nachbearbeitung

## Lösung

Automatisierter Workflow, der:
1. Audio-Dateien via Plaud API transkribiert
2. Speaker Diarization (wer sagt was) nutzt
3. AI-extrahierte Action Items automatisch anlegt
4. Vollständige Meeting Notes in Obsidian erstellt
5. Alles mit Wikilinks verknüpft

## Implementierung

### Erstellte Komponenten

| Komponente | Pfad | Beschreibung |
|------------|------|--------------|
| Ingest Folder | `Ingest/meetings/` | Audio-Drop für Verarbeitung |
| Meeting Ordner | `3. Meetings/YYYY/MM/` | Vollständige Meeting Notes |
| Template | `Templates/Meeting-Transcript-Template.md` | Note-Template |
| Speaker Profiles | `2. Resources/Speaker-Profiles.md` | Bekannte Sprecher |
| Workflow | `@bunny/workflows/meeting-transcription/` | Scripts |
| CLAUDE.md | Aktualisiert | Dokumentation |

### Workflow-Architektur

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   Plaud Note    │ ──▶ │  Ingest/meetings│ ──▶ │  Plaud API      │
│   Recording     │     │  (Audio Drop)   │     │  Transcription  │
└─────────────────┘     └─────────────────┘     └────────┬────────┘
                                                         │
              ┌──────────────────────────────────────────┼──────────┐
              ▼                                          ▼          ▼
     ┌─────────────────┐                    ┌──────────────┐  ┌──────────┐
     │  3. Meetings/   │                    │  Journal     │  │ Actions  │
     │  Full Note      │                    │  Summary     │  │ Items    │
     └─────────────────┘                    └──────────────┘  └──────────┘
```

### Befehle

| Befehl | Funktion |
|--------|----------|
| `Conny, process meetings` | Alle Audio in Ingest/meetings/ verarbeiten |
| `Conny, transcribe [file]` | Einzelne Datei verarbeiten |

## Voraussetzungen

- [x] Plaud Note Hardware
- [ ] Plaud.ai Subscription mit API-Zugang
- [ ] API Key konfigurieren in `.env`

## Nächste Schritte

1. **API Key Setup:** Plaud Developer Portal → API Key generieren
2. **Test:** Erstes Meeting transkribieren
3. **Speaker Training:** Häufige Teilnehmer zu Profiles hinzufügen

## User Experience

### Workflow
1. Meeting mit Plaud Note aufnehmen
2. Audio via Plaud App → iCloud → `Ingest/meetings/` exportieren
3. `Conny, process meetings` ausführen
4. Conny erstellt Meeting Note, Journal Entry, Action Items
5. Bei unbekannten Sprechern: Conny fragt nach

### Output Beispiel

**Meeting Note** (`3. Meetings/2026/01/MEETING-20260122-001 - Team Standup.md`):
- Vollständiges Transkript mit Timestamps
- Speaker-Zuordnung mit Wikilinks
- AI-Zusammenfassung
- Automatische Action Items

**Journal Entry**:
- Kurzfassung mit Link zur vollen Note
- Wichtigste Entscheidungen
- Action Item Links

---

*Implementiert von Bunny, 2026-01-22*
