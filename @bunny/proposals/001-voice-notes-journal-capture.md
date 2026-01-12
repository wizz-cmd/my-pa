# Proposal: Voice Notes → Journal Entry Quick Capture

**Proposal ID:** 001
**Datum:** 2026-01-12
**Status:** Approved for Implementation
**Bunny:** Workflow Automation

---

## Problem Statement

Aktuell müssen Journal-Einträge manuell in Obsidian erstellt werden:
1. Obsidian öffnen
2. `000-JOURNAL.md` navigieren
3. Datum finden oder neuen Abschnitt erstellen
4. Eintrag tippen

**Bottlenecks:**
- Nicht möglich unterwegs (Auto, Spaziergang)
- Zeitaufwendig auf Mobile Devices (Tippen)
- Kontextswechsel unterbricht Flow
- Ideen gehen verloren bis zum nächsten Obsidian-Zugriff

---

## Proposed Solution

**Voice Notes Quick Capture** - Cross-Device Workflow für schnelle Journal-Einträge via Sprachaufnahme.

### User Experience

**Auf iPhone/iPad:**
1. Share Sheet → "Journal Voice Note"
2. Oder: Shortcut Widget/Action Button
3. Sprachaufnahme starten (automatisch)
4. Sprechen (z.B. "Heute PRE21 Besichtigung, OS Innenausbau macht guten Fortschritt")
5. Recording stoppt automatisch oder manuell
6. Transkription erfolgt
7. Eintrag wird in `000-JOURNAL.md` hinzugefügt
8. Bestätigung: "Journal Entry created"

**Auf Mac:**
1. Keyboard Shortcut (z.B. `⌘⌥V`)
2. Sprachaufnahme startet (Menübar Indikator)
3. Sprechen
4. Enter oder Pause → Recording stoppt
5. Transkription
6. Eintrag wird hinzugefügt
7. Notification: "Journal Entry created"

### Technical Architecture

#### Option A: iCloud Sync + File Append (Einfach, keine API)

**Vorteile:**
- Keine API Keys erforderlich
- Funktioniert offline (Transkription via Apple Dictation)
- Native Apple Integration
- Schnell zu implementieren

**Nachteile:**
- Apple Dictation Qualität variabler als Whisper
- Nur auf Apple Devices

**Flow:**
1. Voice Recording (iOS Voice Memos API / macOS AVFoundation)
2. Transkription via Apple Speech Recognition
3. Formatierung (Template: Datum, Uhrzeit, Text)
4. Append to `000-JOURNAL.md` via File System
5. iCloud sync propagiert Änderungen

#### Option B: Whisper API + Advanced Features (Bessere Qualität)

**Vorteile:**
- Bessere Transkriptionsqualität (OpenAI Whisper)
- Mehrsprachig (Deutsch/Englisch automatisch erkannt)
- Erweiterbar (z.B. AI-basierte Tagging-Vorschläge)

**Nachteile:**
- API Key erforderlich (Kosten: ~$0.006/Minute)
- Benötigt Internet
- Komplexer zu implementieren

**Flow:**
1. Voice Recording
2. Upload zu Whisper API
3. Transkription zurück
4. Optional: LLM-basierte Enhancement (Formatierung, Tags)
5. Append to Journal

---

## Recommended Approach: Hybrid

**Phase 1 (Jetzt):** Option A - Apple Native
- Schnell implementierbar
- Keine Kosten
- Funktioniert sofort

**Phase 2 (Optional):** Whisper Upgrade
- Falls Apple Dictation Quality nicht ausreicht
- Einfach austauschbar

---

## Implementation Plan

### 1. iOS/iPadOS Shortcut

**File:** `@bunny/workflows/quick-capture/Journal Voice Note.shortcut`

**Features:**
- Voice recording mit automatischem Stop (Pause-Erkennung)
- Apple Speech Recognition Transkription
- Formatierung:
  ```markdown
  ### [INFO-YYYYMMDD-XXX] [Voice Note]
  **Zeit:** YYYY-MM-DD HH:MM
  **Typ:** Information

  [Transkribierter Text]

  ---
  ```
- Unique ID generieren (nächste Nummer des Tages)
- Append to `000-JOURNAL.md` via Working Copy oder iCloud
- Notification bei Erfolg/Fehler

**Installation:**
- iCloud Link bereitstellen
- Oder: Manual Import in Shortcuts App

### 2. macOS Shortcut

**File:** `@bunny/workflows/quick-capture/Journal Voice Note (macOS).shortcut`

**Features:**
- Keyboard Shortcut Trigger (`⌘⌥V`)
- Menübar Indikator während Recording
- Speech Recognition
- Gleiche Formatierung wie iOS
- Direct File Append (Obsidian Vault Path)
- Notification

**Alternative:** Keyboard Maestro Macro
- Falls mehr Kontrolle gewünscht
- Bessere Hotkey Integration
- Status in Menübar

### 3. Obsidian Integration

**Plugin Option (Advanced):**
- Falls Shortcuts nicht ausreichen
- Custom Obsidian Plugin mit:
  - Quick Capture Button in Mobile App
  - Voice Recording direkt in Obsidian
  - Bessere Integration mit bestehenden Notes

---

## Technical Details

### Journal Entry Format

```markdown
### [INFO-YYYYMMDD-XXX] [Voice Note]
**Zeit:** 2026-01-12 14:35
**Typ:** Information

[Transkribierter Text hier]

**Backlinks:** [Automatisch generiert basierend auf Keywords]

---
```

### Unique ID Generation

**Logik:**
1. Lese aktuellste ID des heutigen Datums aus `000-JOURNAL.md`
2. Inkrement +1
3. Falls kein Eintrag heute: Start bei 001

**Beispiel:**
- Letzter Eintrag heute: `[INFO-20260112-011]`
- Neuer Eintrag: `[INFO-20260112-012]`

### File Append Strategie

**macOS:**
```bash
echo "\n\n$ENTRY_TEXT" >> "$VAULT_PATH/000-JOURNAL.md"
```

**iOS:**
- Working Copy App (Git Integration)
- Oder: iCloud File Provider API via Shortcuts
- Oder: Obsidian Local REST API (wenn running)

---

## Value Proposition

**Time Saved:**
- Aktuell: ~2-3 Minuten pro manuellem Journal Entry
- Mit Workflow: ~15-30 Sekunden (nur sprechen)
- **Zeitersparnis: ~80-90%**

**Quality Improvement:**
- Keine verlorenen Ideen unterwegs
- Mehr Journal Entries (weniger Friction)
- Bessere Dokumentation von spontanen Erkenntnissen

**Use Cases:**
- Im Auto: "PRE21 Update - Klimagerät erfolgreich entfernt"
- Beim Spaziergang: "Idee für CVRM Roadmap - GLP-1 Integration Phase"
- Nach Meeting: "Roche DOT Timeline Risk muss addressiert werden"
- Abends: "Heute 3 wichtige Entscheidungen getroffen..."

---

## Effort Estimate

**Phase 1 (Apple Native):**
- iOS/iPadOS Shortcut: ~2-3 Stunden
- macOS Shortcut: ~1-2 Stunden
- Testing & Refinement: ~1 Stunde
- Documentation: ~1 Stunde
- **Total: 5-7 Stunden**

**Phase 2 (Whisper Upgrade):**
- Whisper API Integration: ~2 Stunden
- AI Enhancement (optional): ~2-3 Stunden
- **Total: 4-5 Stunden**

---

## Risks & Mitigation

**Risk 1: Apple Dictation Quality**
- **Mitigation:** Test extensively, upgrade to Whisper if needed

**Risk 2: File Append Conflicts (iCloud Sync)**
- **Mitigation:** Use append-only strategy, handle merge conflicts gracefully

**Risk 3: Unique ID Collision**
- **Mitigation:** Use timestamp-based IDs als fallback

**Risk 4: Obsidian not synced immediately**
- **Mitigation:** Manual sync trigger in Shortcut, oder notification to sync

---

## Next Steps

1. ✅ Proposal approval (by Chris)
2. Develop iOS/iPadOS Shortcut
3. Develop macOS Shortcut
4. Test on all devices
5. Write user documentation
6. Deploy and iterate based on feedback

---

## Questions for Chris

1. **Vault Access on iOS:** ✅ **Obsidian Sync**
2. **Preferred Trigger iOS:** ✅ **Siri Voice Command UND Share Sheet** (beide)
3. **Preferred Trigger macOS:** ✅ **Command + Option + V** (`⌘⌥V`)
4. **Whisper API:** ✅ **Phase 1 mit Apple Dictation testen, dann entscheiden**
5. **Auto-Tagging:** ✅ **Ja, automatisch Links generieren**

---

**Status:** ✅ Approved - Implementation starting now!
**Implementation Date:** 2026-01-12

**Backlinks:** [[BUNNY.md]], [[Quick Capture Workflows]], [[Obsidian Automation]]

*Bunny - 2026-01-12*
