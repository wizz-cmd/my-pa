# Proposal: Ingest Folder Architecture (Revised Quick Capture)

**Proposal ID:** 002
**Datum:** 2026-01-12
**Status:** Approved for Implementation
**Supersedes:** Proposal 001 (partial)
**Requested by:** Chris

---

## Problem Statement

**Proposal 001 Implementation Issues:**
- Shell script has complex logic (ID generation, auto-linking, file manipulation)
- Limited by Shortcuts capabilities (can't do sophisticated NLP)
- Auto-linking is static regex-based
- Hard to extend for other input sources
- Race conditions possible with concurrent entries
- Debugging is difficult (Shell script errors on mobile)

---

## Proposed Solution

**Ingest → Process → Archive Pattern**

### Architecture

```
Input Sources → Simple Shortcuts → Ingest Folder → Conny Processing → Journal
```

### Components

#### 1. Ingest Folder Structure

```
~/localvault/Chris Notes/Ingest/
├── voice-notes/           # Voice dictation from Shortcuts
├── email-clips/           # (Future) Email forwards
├── web-clips/             # (Future) Safari/browser clips
├── screenshots/           # (Future) Annotated screenshots
└── quick-captures/        # (Future) Text-only quick notes
```

#### 2. Simple Shortcuts (Mac/iOS/iPad)

**Only responsibilities:**
1. Capture voice input (Dictate Text)
2. Create timestamped `.md` file in `Ingest/voice-notes/`
3. Done! (No processing, no logic)

**File naming:** `voice-YYYYMMDD-HHMMSS.md`

**File content:**
```markdown
---
type: voice-note
timestamp: 2026-01-12T23:15:00
device: iPhone
---

[Raw transcribed text here]
```

That's it! No auto-linking, no ID generation, no journal manipulation.

#### 3. Conny Processing

**Triggered:** Proactively or on-demand
**Scans:** `Ingest/` folders for new files

**Processing steps:**
1. **Read** ingest file
2. **Parse** metadata (YAML frontmatter)
3. **Analyze** content with full NLP/AI capabilities:
   - Entity recognition (PRE21, Roche, etc.)
   - Smart auto-linking (context-aware)
   - Related notes suggestions
   - Sentiment/priority detection (optional)
4. **Generate** unique sequential ID
5. **Format** as proper journal entry
6. **Append** to `000-JOURNAL.md`
7. **Move** processed file to `Ingest/processed/YYYY-MM/`
8. **Notify** user of completion

---

## Benefits

### For User (Chris)

✅ **Simpler Shortcuts:** Just record and save - no complex logic to debug
✅ **More Reliable:** Fewer moving parts = fewer failure points
✅ **Better Linking:** Conny can use AI for context-aware linking
✅ **Extensible:** Easy to add new input sources (email, web, etc.)
✅ **Transparent:** Can see raw ingested files before processing
✅ **Recoverable:** If processing fails, raw data is preserved

### For System

✅ **Separation of Concerns:** Capture ≠ Processing
✅ **Centralized Logic:** All intelligence in one place (Conny)
✅ **Atomic Processing:** No race conditions
✅ **Error Handling:** Conny can retry, flag issues, ask for clarification
✅ **Batch Processing:** Can process multiple ingests at once
✅ **Audit Trail:** Processed files archived for reference

---

## Implementation

### Phase 1: Voice Notes Ingest

#### Step 1: Create Ingest Folder Structure

```bash
mkdir -p "$HOME/localvault/Chris Notes/Ingest/voice-notes"
mkdir -p "$HOME/localvault/Chris Notes/Ingest/processed"
```

#### Step 2: Ultra-Simple Shortcuts

**macOS Shortcut (⌘⌥V):**
1. Dictate Text (German & English, After Pause)
2. Text action:
```yaml
---
type: voice-note
timestamp: [Current Date - ISO8601]
device: Mac
---

[Dictated Text]
```
3. Save File:
   - Path: `~/localvault/Chris Notes/Ingest/voice-notes/`
   - Name: `voice-[Date-YYYYMMDD]-[Time-HHMMSS].md`
4. Show Notification: "Voice note captured 🎤"

**iOS/iPad Shortcut (Siri + Share Sheet):**
Same as above, but device: iPhone/iPad

#### Step 3: Conny Processing Command

**New command for Conny:**
```
"Conny, process ingest folder"
```

Or proactive: Conny checks every X minutes or when user opens Obsidian.

**Processing script:**
- Scan `Ingest/voice-notes/` for `.md` files
- For each file:
  - Read content
  - Parse YAML frontmatter
  - Use LLM/NLP for entity detection and linking
  - Generate unique ID
  - Format journal entry
  - Append to `000-JOURNAL.md`
  - Move to `Ingest/processed/YYYY-MM/filename.md`

---

## Enhanced Processing Capabilities

With Conny handling processing, we can add:

### 1. Intelligent Entity Linking

**Before (Static):**
- "PRE21" → `[[PRE21]]` (always)

**After (Context-aware):**
- "PRE21 Fortschritt" → `[[PRE21]]` (property entity)
- "Ich war bei PRE21" → `[[PRE21]]` (location entity)
- "PRE21 Projekt abgeschlossen" → `[[PRE21]]` + `[[Immobilieneinkauf]]` (infer project category)

### 2. Smart Backlink Generation

Not just mentioned entities, but:
- **Related projects:** Voice note about "Renovierung" → adds `[[PRE21 Verkauf - Vorbereitung]]`
- **Related people:** Mention "Thorsten" → `[[Thorsten Rall]]`
- **Related concepts:** "Timeline Risk" → `[[DOT]]` (if context is Roche)

### 3. Entry Type Classification

Analyze content and set appropriate type:
- **Meeting note** (mentions "Meeting", "Call", "Discussion")
- **Task** (mentions "TODO", "Need to", "Should")
- **Decision** (mentions "Decided", "Going with", "Chose")
- **Information** (default)

### 4. Priority/Urgency Detection

Optionally detect:
- **Urgent** ("ASAP", "urgent", "quickly")
- **Important** ("critical", "must", "essential")
- **Follow-up needed** ("later", "next week", "remind me")

### 5. Cross-Reference Suggestions

Conny can suggest:
- "This voice note mentions DOT Timeline, there are 3 other recent notes about this. Want me to create a MOC?"
- "You mentioned Mailand Trip - I can link this to your travel planning note."

---

## Migration from Proposal 001

### What to Keep

✅ Triggers (⌘⌥V, Siri, Share Sheet)
✅ User experience (fast, cross-device)
✅ Documentation structure

### What Changes

🔄 Shortcuts: Much simpler (no shell script)
🔄 Processing: Moved to Conny
🔄 Auto-linking: From static to intelligent
➕ Ingest folder: New component
➕ Processed archive: Audit trail

### Migration Steps

1. Update shortcuts to use ingest folder
2. Remove shell script complexity
3. Add Conny processing logic
4. Test with existing workflow
5. Archive old approach

---

## Future Extensions

### Other Ingest Sources (Easy to Add)

**Email to Journal:**
- Forward email to special address
- Lands in `Ingest/email-clips/`
- Conny processes: extracts relevant info, links to contacts

**Web Clipper:**
- Safari Share Sheet → "Clip to Ingest"
- Saves URL + excerpt to `Ingest/web-clips/`
- Conny processes: summarizes, creates reference note

**Screenshot Notes:**
- Screenshot with Apple Pencil annotation
- Saves to `Ingest/screenshots/`
- Conny processes: OCR, extract text, create note with image

**Quick Text Captures:**
- Shortcut: "Quick Note" (text input)
- Saves to `Ingest/quick-captures/`
- Conny processes: format and categorize

### Batch Operations

"Conny, process all ingest and generate daily summary"
→ Processes all pending ingests
→ Creates summary of today's captures
→ Suggests cross-links

### Smart Notifications

"You have 5 unprocessed voice notes. Want me to process them?"
→ User confirms
→ Conny processes and reports: "Added 5 journal entries, created 2 new entity notes, suggested 3 cross-links"

---

## Implementation Timeline

### Phase 1: Core (Today)
1. Create ingest folder structure
2. Update macOS shortcut to simple version
3. Implement Conny processing logic
4. Test end-to-end
**Estimate:** 2-3 hours

### Phase 2: Polish (This week)
1. Update iOS shortcuts
2. Add proactive processing (auto-detect new ingests)
3. Enhance entity linking with AI
4. Add error handling and notifications
**Estimate:** 2-3 hours

### Phase 3: Extensions (Next week)
1. Add other ingest sources (email, web)
2. Implement batch operations
3. Create dashboard for ingest status
4. Build smart suggestions
**Estimate:** 4-6 hours

---

## Technical Details

### Ingest File Format

```markdown
---
type: voice-note | email-clip | web-clip | screenshot | quick-capture
timestamp: 2026-01-12T23:15:00+01:00
device: Mac | iPhone | iPad
source: Siri | Shortcut | Email | Web | Manual
raw: true
processed: false
---

[Raw content here]

<!-- Metadata for processing -->
- length: 45 seconds
- language: de-DE (detected)
- quality: high (confidence score)
```

### Processing Output

After processing, file is moved to `Ingest/processed/YYYY-MM/` with:

```markdown
---
type: voice-note
timestamp: 2026-01-12T23:15:00+01:00
device: Mac
processed: true
processed_at: 2026-01-12T23:18:00+01:00
journal_id: INFO-20260112-014
entities_detected: [PRE21, Roche, CGM]
backlinks_created: [[PRE21]], [[Roche]], [[CGM]]
---

[Original content]

---
## Processing Notes
- Linked to [[PRE21]] (confidence: 0.95)
- Linked to [[Roche]] (confidence: 0.89)
- Detected entity: CGM (context: medical device)
- Added to journal as [INFO-20260112-014]
- Processing time: 1.2s
```

---

## Risks & Mitigation

**Risk 1: Conny not available when ingest happens**
→ **Mitigation:** Ingests queue up, processed when Conny is next active

**Risk 2: Processing fails**
→ **Mitigation:** Original ingest file preserved, can retry or manual fallback

**Risk 3: Too many unprocessed ingests**
→ **Mitigation:** Conny notifies: "You have 20+ unprocessed notes, want me to batch process?"

**Risk 4: Obsidian Sync conflicts**
→ **Mitigation:** Ingest files are small, conflicts unlikely; processing is atomic

---

## Success Metrics

**Compared to Proposal 001:**
- Shortcut complexity: 80% reduction (5 actions → 1 action)
- Processing reliability: 95%+ (centralized error handling)
- Linking accuracy: 50%+ improvement (AI vs regex)
- Extensibility: 10x (easy to add new sources)
- User satisfaction: Higher (simpler, more reliable)

---

## Approval & Next Steps

**Status:** ✅ Approved by Chris (verbal)

**Immediate Actions:**
1. Create ingest folder structure
2. Implement simple macOS shortcut
3. Add Conny processing logic
4. Test with real voice notes
5. Update documentation

**Go/No-Go:** Test Phase 1 for 1 day, then decide on Phase 2

---

**This is the better architecture. Let's build it!** 🐰⚡

**Backlinks:** [[BUNNY.md]], [[Proposal 001]], [[Quick Capture]], [[Obsidian Automation]], [[Conny Processing]]

*Bunny - 2026-01-12*
