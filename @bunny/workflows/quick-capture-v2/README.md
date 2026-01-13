# Quick Capture v2 - Ingest Folder Architecture

**Status:** ✅ Ready for Implementation
**Date:** 2026-01-13
**Architecture:** Ingest → Process → Archive

---

## What Changed from v1?

### v1 (Shell Script Approach)
❌ Complex shell script with auto-linking logic
❌ Limited by Shortcuts capabilities
❌ Hard to debug and extend
❌ Duplicated logic across platforms

### v2 (Ingest Folder Approach)
✅ Ultra-simple Shortcuts (just save file)
✅ Conny handles all intelligent processing
✅ Easy to extend (email, web clips, etc.)
✅ Centralized logic, better error handling

---

## Architecture

```
Voice Input (Mac/iOS/iPad)
         ↓
Simple Shortcut (4 actions!)
         ↓
Ingest Folder
  ~/localvault/Chris Notes/Ingest/voice-notes/
         ↓
Conny Processing
  - Entity detection
  - Smart auto-linking
  - ID generation
  - Journal formatting
         ↓
000-JOURNAL.md
         ↓
Processed Archive
  ~/localvault/Chris Notes/Ingest/processed/YYYY-MM/
```

---

## Setup (10 Minutes Total)

### Step 1: Ingest Folders ✅
Already created:
- `~/localvault/Chris Notes/Ingest/voice-notes/`
- `~/localvault/Chris Notes/Ingest/processed/`

### Step 2: Update macOS Shortcut
Follow: [simple-macOS-shortcut-guide.md](./simple-macOS-shortcut-guide.md)
- **Time:** ~5 minutes
- **Complexity:** 4 actions (super simple!)
- **Trigger:** ⌘⌥V

### Step 3: Update iOS/iPad Shortcuts
*(Coming soon - same simplicity as macOS)*

### Step 4: Ready!
- Press ⌘⌥V → Speak → File saved to Ingest
- Say "Conny, process ingest folder" → Magic happens

---

## How It Works

### Phase 1: Capture (You)

**macOS:** Press ⌘⌥V
**iOS:** Say "Hey Siri, Add journal note"

**Shortcut does:**
1. Records your voice
2. Transcribes to text
3. Saves simple `.md` file:
```markdown
---
type: voice-note
timestamp: 2026-01-13T08:45:00
device: Mac
---

PRE21 Fortschritt, OS Innenausbau läuft gut
```

That's it! No processing, no complexity.

### Phase 2: Process (Conny)

**Trigger:** "Conny, process ingest folder"

**Conny does:**
1. Scans `Ingest/voice-notes/` for new files
2. Reads each file
3. **AI-powered analysis:**
   - Detects entities (PRE21, Roche, etc.)
   - Creates smart Wikilinks
   - Identifies related notes
   - Generates backlinks
4. Generates sequential unique ID
5. Formats journal entry
6. Appends to `000-JOURNAL.md`
7. Moves to `Ingest/processed/YYYY-MM/`
8. Notifies you: "✅ Processed 1 voice note → [INFO-20260113-001]"

---

## Benefits

| Aspect | v1 (Shell Script) | v2 (Ingest Folder) |
|--------|-------------------|---------------------|
| **Shortcut Complexity** | 10+ actions | 4 actions |
| **Auto-Linking** | Static regex | AI-powered |
| **Error Recovery** | Hard | Easy (raw file preserved) |
| **Extensibility** | Difficult | Very easy |
| **Debugging** | Shell script on device | Conny with full access |
| **Cross-Platform** | Different logic each | Same files, same processing |
| **Future Features** | Need shell script updates | Just enhance Conny |

---

## Files

```
quick-capture-v2/
├── README.md                          # This file
├── simple-macOS-shortcut-guide.md     # How to create simple shortcut
├── conny-processing-guide.md          # Processing logic for Conny
└── (Coming soon)
    ├── simple-iOS-shortcut-guide.md   # iOS version
    └── examples/                      # Example ingest files
```

---

## Commands

### Process Ingests

```
"Conny, process ingest folder"
"Conny, process voice notes"
"Conny, check for new ingests"
```

### Status Check

```
"Conny, how many unprocessed ingests?"
"Conny, show me pending voice notes"
```

### Batch Operations

```
"Conny, batch process all ingests"
"Conny, give me a summary of today's voice notes"
```

---

## Example Flow

### 1. You Create Voice Note

```
[You] Press ⌘⌥V
[You] Speak: "PRE21 Entrümpelung komplett, Roche Meeting Freitag"
[Shortcut] ✅ Voice note captured 🎤
```

File created: `Ingest/voice-notes/voice-20260113-084500.md`

### 2. Conny Processes

```
[You] "Conny, process ingest folder"
[Conny] "Found 1 voice note. Processing..."
[Conny] Analyzes content
[Conny] Detects: PRE21, Roche
[Conny] Creates links: [[PRE21]], [[Roche]]
[Conny] Generates ID: [INFO-20260113-001]
[Conny] Appends to journal
[Conny] Moves to processed/
[Conny] ✅ "Processed 1 voice note → [INFO-20260113-001]"
```

### 3. Result in Journal

```markdown
### [INFO-20260113-001] [Voice Note]
**Zeit:** 2026-01-13 08:45
**Typ:** Information
**Device:** Mac

[[PRE21]] Entrümpelung komplett, [[Roche]] Meeting Freitag

**Backlinks:** [[PRE21]], [[Roche]]

---
```

---

## Migration from v1

### What to Do

1. **Keep using v1** if it works (both can coexist)
2. **Test v2** with simple macOS shortcut
3. **Compare** results
4. **Switch** when comfortable
5. **Archive** v1 setup

### Backward Compatibility

- v1 shortcuts write directly to journal
- v2 shortcuts write to ingest folder
- Both can run simultaneously
- No conflicts

---

## Next Steps

### Immediate (Today)
- ✅ Ingest folders created
- ✅ Documentation complete
- ⏳ Update your macOS Shortcut (follow guide)
- ⏳ Test with real voice note
- ⏳ Process with Conny

### Short Term (This Week)
- Create iOS/iPad shortcuts
- Test cross-device workflow
- Add automatic processing (Conny checks periodically)
- Enhance entity detection

### Future (Optional)
- Add other ingest sources (email, web)
- Create dashboard for ingest status
- Implement smart suggestions
- Add batch summaries

---

## Troubleshooting

### Issue: Shortcut can't save file

**Check:** Folder exists
```bash
ls ~/localvault/Chris\ Notes/Ingest/voice-notes/
```

**Fix:** Already created! Should work.

### Issue: Conny doesn't find ingests

**Check:** Files in folder
```bash
ls ~/localvault/Chris\ Notes/Ingest/voice-notes/*.md
```

**Fix:** Create voice note first with ⌘⌥V

### Issue: Processing fails

**Conny will:**
- Preserve original file
- Log error
- Suggest manual intervention

You can always:
- Retry: "Conny, reprocess that file"
- View raw: "Conny, show me the ingest file"
- Skip: "Conny, skip that one"

---

## Why This Is Better

### Separation of Concerns
- **Shortcuts:** Do one thing well (capture)
- **Conny:** Do complex things well (process)

### Flexibility
- Change processing logic without touching shortcuts
- Add new features to Conny instantly
- Multiple input sources, one processor

### Reliability
- Raw data always preserved
- Processing can be retried
- No data loss on errors

### Extensibility
- Email → Ingest → Process
- Web → Ingest → Process
- Screenshot → Ingest → Process
- All use same Conny processing!

---

**This is the better way. Let's use it!** 🚀

*Bunny & Conny - 2026-01-13*
