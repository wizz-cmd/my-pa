# Voice Note Journal - macOS Setup

**Workflow:** Quick Capture via Voice Note
**Trigger:** ⌘⌥V (Command + Option + V)
**Platform:** macOS

---

## Method: macOS Shortcut

### Prerequisites

1. **Shortcuts App** (built-in macOS Monterey+)
2. **Microphone Permission** for Shortcuts
3. **Obsidian Vault** accessible at: `~/localvault/Chris Notes`

---

## Installation Steps

### Step 1: Create the Shortcut

1. Open **Shortcuts** app on Mac
2. Click **"+"** (New Shortcut)
3. Name it: **"Journal Voice Note"**

### Step 2: Add Actions (in order)

#### Action 1: Dictate Text
- Search for: **"Dictate Text"**
- Settings:
  - Language: **German & English** (auto-detect)
  - Stop Listening: **After Pause**

#### Action 2: Set Variable
- Search for: **"Set Variable"**
- Variable Name: **"TranscribedText"**
- Input: Result from Dictate Text

#### Action 3: Run Shell Script
- Search for: **"Run Shell Script"**
- Input: **TranscribedText** variable
- Pass Input: **as arguments**
- Script:
```bash
/Users/chris/my-pa/@bunny/workflows/quick-capture/scripts/append-journal-entry.sh "$1"
```

#### Action 4: Show Notification
- Search for: **"Show Notification"**
- Title: **"Journal Entry Created"**
- Body: Result from Run Shell Script
- Play Sound: ✅

### Step 3: Configure Keyboard Shortcut

1. Right-click on the shortcut
2. Select **"Add Keyboard Shortcut"**
3. Press: **⌘⌥V**
4. Click **"Add"**

### Step 4: Test

1. Press **⌘⌥V** anywhere on your Mac
2. Speak when prompted (e.g., "PRE21 Update: OS Innenausbau macht Fortschritt")
3. Wait for notification
4. Check `000-JOURNAL.md` in Obsidian

---

## Alternative: Keyboard Maestro (Advanced)

If you prefer more control and better visual feedback:

### Advantages
- Visual recording indicator in menu bar
- More flexible hotkey configuration
- Better error handling
- Can show recording time

### Installation

1. Download Keyboard Maestro macro: `@bunny/workflows/quick-capture/Journal Voice Note.kmmacros`
2. Double-click to import
3. Configure hotkey: ⌘⌥V
4. Done!

*(Keyboard Maestro macro will be provided if requested)*

---

## Features

✅ Voice recording with pause detection
✅ Automatic transcription (German/English)
✅ Unique ID generation (e.g., [INFO-20260112-013])
✅ Auto-linking of entities (PRE21, Roche, CGM, etc.)
✅ Automatic backlinks generation
✅ Append to today's journal section
✅ Desktop notification on success

---

## Troubleshooting

### Issue: "Permission Denied"
**Solution:**
```bash
chmod +x /Users/chris/my-pa/@bunny/workflows/quick-capture/scripts/append-journal-entry.sh
```

### Issue: "Microphone not working"
**Solution:** System Settings → Privacy & Security → Microphone → Enable for Shortcuts

### Issue: "Script not found"
**Solution:** Verify path in Step 2, Action 3 points to correct script location

### Issue: "Journal entry not appearing"
**Solution:**
1. Check Obsidian Sync is active
2. Manually trigger sync in Obsidian
3. Verify `000-JOURNAL.md` exists at correct path

---

## Usage Examples

**Quick Meeting Note:**
> Press ⌘⌥V → "Meeting mit Thorsten Rall. DOT Timeline Risk besprochen, MSA Verhandlungen starten nächste Woche."

**Travel Update:**
> Press ⌘⌥V → "Mailand Reise gebucht, Crowne Plaza Milan City, IHG Platinum Status wird genutzt."

**Project Status:**
> Press ⌘⌥V → "PRE21 Fortschritt 61 Prozent, OS Innenausbau beauftragt für 2400 Euro netto."

All will be automatically:
- Transcribed
- Formatted with unique ID
- Auto-linked ([[PRE21]], [[DOT]], [[Mailand]])
- Added to today's journal section
- Synced via Obsidian Sync

---

**Next:** [iOS Setup](./iOS-setup.md)

*Bunny - 2026-01-12*
