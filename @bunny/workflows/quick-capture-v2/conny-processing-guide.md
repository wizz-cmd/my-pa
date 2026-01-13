# Conny Ingest Processing Guide

**For:** Conny (Claude Code Assistant)
**Purpose:** Process voice notes from Ingest folder into Journal
**Version:** 2.0 - Ingest Architecture

---

## Overview

**You (Conny) are responsible for processing voice notes from the Ingest folder.**

This replaces the complex shell script from v1. You now have full control and can use AI/NLP for intelligent processing.

---

## When to Process

### Manual Trigger
User says: "Conny, process ingest folder" or "Conny, process voice notes"

### Automatic (Future)
- Check `Ingest/voice-notes/` every 10-30 minutes
- Or: Triggered when Obsidian opens
- Or: User-configurable schedule

---

## Processing Steps

### 1. Scan for New Ingests

```bash
ls ~/localvault/Chris\ Notes/Ingest/voice-notes/*.md
```

For each `.md` file found:

### 2. Read File Content

Example file: `voice-20260112-231500.md`
```markdown
---
type: voice-note
timestamp: 2026-01-12T23:15:00
device: Mac
---

PRE21 Fortschritt heute, OS Innenausbau macht guten Fortschritt,
Roche DOT Timeline Risk muss nächste Woche besprochen werden
```

### 3. Parse Metadata

Extract from YAML frontmatter:
- `type`: voice-note
- `timestamp`: 2026-01-12T23:15:00
- `device`: Mac

### 4. Analyze Content (Your AI Powers!)

**Entity Detection:**
- Identify entities: PRE21, Roche, DOT, OS Innenausbau
- Determine entity types:
  - PRE21 → Project
  - Roche → Company
  - DOT → Project
  - OS Innenausbau → Vendor/Company

**Context Analysis:**
- "Fortschritt" → Progress update
- "Timeline Risk" → Issue/concern
- "muss besprochen werden" → Action required

**Smart Linking:**
- PRE21 → `[[PRE21]]`
- Roche → `[[Roche]]`
- DOT → `[[DOT]]`
- Timeline Risk + Roche + DOT → might suggest `[[Roche DOT Timeline]]` if such note exists

**Backlinks Generation:**
- Direct mentions: `[[PRE21]]`, `[[Roche]]`, `[[DOT]]`
- Inferred: `[[PRE21 Verkauf - Vorbereitung]]` (if context matches)
- Related: `[[OS Innenausbau]]` (vendor)

### 5. Generate Unique ID

**Logic:**
1. Extract date from `timestamp`: `2026-01-12` → `20260112`
2. Find highest existing ID for that date in `000-JOURNAL.md`:
   - Search for: `[INFO-20260112-XXX]`
   - Find highest: e.g., `[INFO-20260112-013]`
3. Increment: `013 + 1 = 014`
4. New ID: `[INFO-20260112-014]`

### 6. Format Journal Entry

```markdown
### [INFO-20260112-014] [Voice Note]
**Zeit:** 2026-01-12 23:15
**Typ:** Information
**Device:** Mac

[[PRE21]] Fortschritt heute, OS Innenausbau macht guten Fortschritt,
[[Roche]] [[DOT]] Timeline Risk muss nächste Woche besprochen werden

**Backlinks:** [[PRE21]], [[Roche]], [[DOT]], [[OS Innenausbau]]

---
```

### 7. Append to Journal

- Find today's date section in `000-JOURNAL.md`: `## 2026-01-12`
- Append entry after the date header
- If no section exists, create it

### 8. Move Processed File

**From:** `~/localvault/Chris Notes/Ingest/voice-notes/voice-20260112-231500.md`

**To:** `~/localvault/Chris Notes/Ingest/processed/2026-01/voice-20260112-231500.md`

Update file with processing metadata:
```markdown
---
type: voice-note
timestamp: 2026-01-12T23:15:00
device: Mac
processed: true
processed_at: 2026-01-12T23:18:00
journal_id: INFO-20260112-014
entities_detected: [PRE21, Roche, DOT, OS Innenausbau]
---

[original content]

---
## Processing Notes
- Linked to [[PRE21]] (confidence: 0.95)
- Linked to [[Roche]] (confidence: 0.92)
- Linked to [[DOT]] (confidence: 0.98)
- Detected entity: OS Innenausbau (context: vendor)
- Added to journal as [INFO-20260112-014]
- Processing time: 1.5s
```

### 9. Notify User

"✅ Processed 1 voice note → [INFO-20260112-014]"

Or if multiple:
"✅ Processed 5 voice notes → Added entries [INFO-20260112-014] through [INFO-20260112-018]"

---

## Advanced Features

### Cross-Reference Detection

If you detect related notes during processing:
- "This mentions DOT Timeline Risk. You have 3 other notes about this."
- "Want me to create a MOC for DOT Timeline Issues?"

### Priority/Urgency

Detect keywords:
- "urgent", "ASAP", "quickly" → Flag as urgent
- "muss", "sollte", "wichtig" → Flag as important
- Suggest: "This voice note seems urgent - want me to create a task?"

### Entry Type Classification

Analyze content and suggest type:
- Mentions "Meeting", "Call" → Type: Meeting Note
- Mentions "TODO", "muss", "sollte" → Type: Task
- Mentions "Entscheidung", "decided" → Type: Decision
- Default → Type: Information

### Smart Suggestions

After processing, you can suggest:
- "I linked this to PRE21. Want me to update the project status dashboard?"
- "You mentioned Roche DOT Timeline Risk. Should I create a follow-up task?"
- "3 voice notes today mention Beyond - want a summary?"

---

## Error Handling

### If Processing Fails

1. **Don't delete** the ingest file
2. **Log error** in processing notes
3. **Notify user:** "⚠️ Failed to process voice-20260112-231500.md - [reason]"
4. **Provide options:**
   - "Retry processing"
   - "Show me the raw file"
   - "Skip this one"

### Common Errors

**Error: Can't find journal file**
→ Create new section: `## 2026-01-12` in `000-JOURNAL.md`

**Error: Duplicate ID**
→ Re-scan and generate next available ID

**Error: Can't parse YAML**
→ Process content anyway, use filename for timestamp

**Error: Obsidian Sync conflict**
→ Wait 10 seconds, retry

---

## Batch Processing

**Command:** "Conny, batch process all ingests"

**Steps:**
1. Count files in `Ingest/voice-notes/`
2. Notify: "Found 7 unprocessed voice notes. Processing..."
3. Process each file sequentially
4. Generate summary:
   ```
   ✅ Processed 7 voice notes:
   - 3 about PRE21
   - 2 about Roche DOT
   - 1 about Mailand Trip
   - 1 about Beyond

   Created entries [INFO-20260112-014] through [INFO-20260112-020]

   Suggestions:
   - PRE21 mentioned 3 times today - want a status summary?
   - DOT Timeline Risk mentioned - create a tracking note?
   ```

---

## Testing

### Test Case 1: Simple Voice Note

**Input file:**
```markdown
---
type: voice-note
timestamp: 2026-01-12T23:15:00
device: Mac
---

Test voice note processing
```

**Expected output in Journal:**
```markdown
### [INFO-20260112-014] [Voice Note]
**Zeit:** 2026-01-12 23:15
**Typ:** Information
**Device:** Mac

Test voice note processing

---
```

### Test Case 2: With Entities

**Input:**
```markdown
---
type: voice-note
timestamp: 2026-01-12T23:20:00
device: iPhone
---

PRE21 Entrümpelung abgeschlossen, Roche Meeting nächste Woche
```

**Expected:**
```markdown
### [INFO-20260112-015] [Voice Note]
**Zeit:** 2026-01-12 23:20
**Typ:** Information
**Device:** iPhone

[[PRE21]] Entrümpelung abgeschlossen, [[Roche]] Meeting nächste Woche

**Backlinks:** [[PRE21]], [[Roche]]

---
```

### Test Case 3: Multiple Notes

Process 3 files, verify:
- Sequential IDs (014, 015, 016)
- All moved to `processed/`
- All in correct date section
- No duplicates

---

## Commands for Conny

**Process ingests:**
```
"Conny, process ingest folder"
"Conny, process voice notes"
"Conny, check for new ingests"
```

**Batch operations:**
```
"Conny, batch process all ingests"
"Conny, process all pending voice notes"
```

**Status check:**
```
"Conny, how many unprocessed ingests?"
"Conny, show me pending voice notes"
```

**Manual intervention:**
```
"Conny, show me the raw ingest file voice-20260112-231500"
"Conny, reprocess voice-20260112-231500"
"Conny, skip voice-20260112-231500"
```

---

## Future Enhancements

### Auto-Processing

Monitor `Ingest/voice-notes/` directory:
- Use file system watcher
- Process new files within 30 seconds
- No user command needed

### Smart Scheduling

- Morning: Process overnight voice notes
- Evening: Daily summary of all ingests
- Weekly: "You had 45 voice notes this week, here are the themes..."

### Integration with Other Tools

- Calendar: "Voice note mentions 'meeting' → Check calendar for context"
- Tasks: "Voice note mentions 'TODO' → Create task in your system"
- Contacts: "Voice note mentions 'Thorsten' → Link to [[Thorsten Rall]]"

---

**You're in charge now, Conny! Make those ingests useful!** 🤖✨

*Bunny - 2026-01-12*
