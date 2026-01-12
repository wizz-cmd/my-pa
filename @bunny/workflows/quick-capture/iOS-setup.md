# Voice Note Journal - iOS/iPadOS Setup

**Workflow:** Quick Capture via Voice Note
**Triggers:** Siri Voice Command + Share Sheet
**Platform:** iOS & iPadOS

---

## Method: iOS Shortcut

### Prerequisites

1. **Shortcuts App** (built-in iOS/iPadOS)
2. **Obsidian App** installed
3. **Obsidian Sync** enabled and working
4. **Microphone Permission** for Shortcuts

---

## Installation Steps

### Step 1: Create the Shortcut

1. Open **Shortcuts** app on iPhone/iPad
2. Tap **"+"** (New Shortcut)
3. Tap **"Add Action"**

### Step 2: Add Actions (in order)

#### Action 1: Dictate Text
- Search: **"Dictate Text"**
- Tap to add
- Settings:
  - Language: **German & English**
  - Stop Listening: **After Pause**
  - Show When Run: ✅ (so you see when recording)

#### Action 2: Set Variable
- Search: **"Set Variable"**
- Variable Name: **"TranscribedText"**
- Input: Dictated Text

#### Action 3: Text Action - Format Entry
- Search: **"Text"**
- Tap the text field, then tap **Variables** → insert:

```
### [INFO-DATECOMPACT-ID] [Voice Note]
**Zeit:** DATETIME
**Typ:** Information

TranscribedText

---
```

We'll replace the placeholders in next actions.

#### Action 4: Get Current Date
- Search: **"Current Date"**
- Format: **Custom** → `yyyy-MM-dd HH:mm`
- Set Variable: **"FormattedDate"**

#### Action 5: Get Current Date (Compact)
- Search: **"Current Date"** (add again)
- Format: **Custom** → `yyyyMMdd`
- Set Variable: **"DateCompact"**

#### Action 6: Text - Create Entry
- Search: **"Text"**
- Build the entry with variables:

```text
### [INFO-DateCompact-XXX] [Voice Note]
**Zeit:** FormattedDate
**Typ:** Information

TranscribedText

---
```

*(Note: ID generation is simplified to XXX on iOS - you can manually fix or we can add more complex logic later)*

#### Action 7: Replace Text (Auto-linking)
- Search: **"Replace Text"**
- Find: `PRE21` (Regular Expression: off)
- Replace With: `[[PRE21]]`
- Repeat this action for each entity:
  - `DOT` → `[[DOT]]`
  - `Beyond` → `[[Beyond]]`
  - `CVRM` → `[[CVRM]]`
  - `CGM` → `[[CGM]]`
  - `Roche` → `[[Roche]]`
  - `Capgemini` → `[[Capgemini]]`
  - `Mailand` → `[[Mailand]]`

*(This is tedious but necessary for iOS - alternative: use single "Replace Text with Regular Expression" if you're comfortable)*

#### Action 8: Append to File
- Search: **"Append to File"**
- Service: **iCloud Drive**
- File Path: Navigate to your Obsidian vault folder
  - `Obsidian/Chris Notes/000-JOURNAL.md`
  - OR wherever your vault syncs to iCloud
- Create if Doesn't Exist: ✅
- Text: Result from previous actions

#### Action 9: Show Notification
- Search: **"Show Notification"**
- Title: **"Journal Entry Created ✅"**
- Body: **"Voice note added to journal"**
- Play Sound: ✅

### Step 3: Configure Shortcut Settings

1. Tap the shortcut name at top
2. Rename to: **"Journal Voice Note"**
3. Tap **"i"** icon (settings)
4. Configure:
   - **Show in Share Sheet:** ✅ ON
   - **Accepts:** Text, URLs (optional)
   - **Add to Siri:** ✅ ON
     - Phrase: **"Add journal note"** or **"Voice journal"**

### Step 4: Test

#### Test via Siri:
- Say: **"Hey Siri, Add journal note"**
- Speak your note when prompted
- Check notification
- Open Obsidian → Check `000-JOURNAL.md`

#### Test via Share Sheet:
- Open Safari or any app
- Tap Share button
- Scroll to **"Journal Voice Note"**
- Speak and verify

---

## iOS Shortcut Alternative: Simplified Version

If the above is too complex, here's a simpler version:

### Simple iOS Shortcut (5 Actions)

1. **Dictate Text** (German & English, After Pause)
2. **Text:**
   ```
   ### [INFO-TIMESTAMP] [Voice Note]
   **Zeit:** CURRENT_TIME
   **Typ:** Information

   DICTATED_TEXT

   ---
   ```
3. **Get Current Date** → Custom format: `yyyyMMdd-HHmm`
4. **Append to File** → `000-JOURNAL.md`
5. **Show Notification** → "Journal Entry Created"

This version uses timestamp instead of sequential ID, which is simpler but less consistent with your current journal format.

---

## Features

✅ Voice recording via Dictate
✅ Siri integration ("Hey Siri, Add journal note")
✅ Share Sheet access (from any app)
✅ Automatic transcription (German/English)
✅ Basic auto-linking of entities
✅ Append to journal
✅ Works offline (dictation only)
✅ Syncs via Obsidian Sync

⚠️ **Limitation:** Sequential ID generation ([INFO-20260112-013]) is complex on iOS. Current version uses simplified ID or placeholder "XXX" that you can fix manually in Obsidian.

---

## Troubleshooting

### Issue: "Can't find 000-JOURNAL.md"
**Solution:**
1. Verify Obsidian Sync is active
2. Open Obsidian app → let it sync
3. Check vault folder in iCloud Drive
4. Update file path in shortcut Action 8

### Issue: "Dictation not working"
**Solution:** Settings → Privacy → Microphone → Enable for Shortcuts

### Issue: "Not syncing to Obsidian"
**Solution:**
1. Ensure Obsidian Sync subscription is active
2. Check sync status in Obsidian app
3. Alternative: Use "Open in Obsidian" action instead of direct file append

### Issue: "Auto-linking not working"
**Solution:** Each Replace Text action must be separate (iOS limitation)

---

## Advanced: Using Obsidian URI Scheme (Alternative Method)

Instead of direct file append, use Obsidian's URL scheme:

### Obsidian URI Action:
```
obsidian://vault/Chris%20Notes/000-JOURNAL.md?append=
[Your formatted entry here]
```

**Advantage:** Works better with Obsidian Sync
**Disadvantage:** Requires Obsidian app to be installed and opened

---

## Widget Setup (Optional)

### Add to Home Screen:
1. Long press Home Screen
2. Tap **"+"** (Add Widget)
3. Search **"Shortcuts"**
4. Select widget size
5. Choose **"Journal Voice Note"** shortcut
6. Tap anywhere on home screen to capture voice note

---

## Usage Examples

**Via Siri:**
> "Hey Siri, Add journal note"
> [Siri: "What would you like to add?"]
> "PRE21 Entrümpelung heute abgeschlossen, Kühlschrank entfernt."

**Via Share Sheet:**
> In Safari, reading article about CVRM
> Tap Share → "Journal Voice Note"
> "Interessanter Artikel über CVRM Trends, relevant für Beyond Roadmap."

**Via Widget:**
> Tap widget on home screen
> "Meeting mit frog Milano, CVRM Strategy Alignment besprochen."

All entries sync automatically via Obsidian Sync to your Mac and other devices.

---

## Next Steps

1. Test the shortcut
2. Customize auto-linking entities (add more)
3. Consider upgrading to Whisper API for better transcription (Phase 2)
4. Add smart backlink generation with LLM (Phase 2)

---

**Related:** [macOS Setup](./macOS-setup.md) | [Technical Details](./technical-details.md)

*Bunny - 2026-01-12*
