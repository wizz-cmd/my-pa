#!/bin/bash
#
# append-journal-entry.sh
# Appends a voice note entry to Obsidian Journal (000-JOURNAL.md)
#
# Usage: ./append-journal-entry.sh "transcribed text"
#
# Author: Bunny (Workflow Automation Agent)
# Date: 2026-01-12

set -e

# Configuration
VAULT_PATH="$HOME/localvault/Chris Notes"
JOURNAL_FILE="$VAULT_PATH/000-JOURNAL.md"
TRANSCRIBED_TEXT="$1"

# Validate input
if [ -z "$TRANSCRIBED_TEXT" ]; then
    echo "Error: No transcribed text provided"
    exit 1
fi

# Check if journal file exists
if [ ! -f "$JOURNAL_FILE" ]; then
    echo "Error: Journal file not found at $JOURNAL_FILE"
    exit 1
fi

# Get current date and time
CURRENT_DATE=$(date +"%Y-%m-%d")
CURRENT_TIME=$(date +"%H:%M")
CURRENT_DATE_COMPACT=$(date +"%Y%m%d")

# Find the next available ID for today
LAST_ID=$(grep -o "\[INFO-${CURRENT_DATE_COMPACT}-[0-9]\{3\}\]" "$JOURNAL_FILE" 2>/dev/null | grep -o "[0-9]\{3\}$" | tail -1 || echo "000")
LAST_ID=$(echo "$LAST_ID" | tr -d '\n' | tr -d '\r' | tr -d ' ')
# Ensure it's exactly 3 digits
if [ -z "$LAST_ID" ] || [ ${#LAST_ID} -ne 3 ]; then
    LAST_ID="000"
fi
NEXT_ID=$(printf "%03d" $((10#$LAST_ID + 1)))

UNIQUE_ID="INFO-${CURRENT_DATE_COMPACT}-${NEXT_ID}"

# Auto-link generation
AUTO_LINKED_TEXT="$TRANSCRIBED_TEXT"

# Entities to auto-link
ENTITIES=(
    "PRE21"
    "DOT"
    "Beyond"
    "CVRM"
    "CGM"
    "Roche"
    "Capgemini"
    "Mailand"
    "Milan"
    "Conny"
    "Ronny"
    "Bunny"
)

# Create Wikilinks
for entity in "${ENTITIES[@]}"; do
    AUTO_LINKED_TEXT=$(echo "$AUTO_LINKED_TEXT" | sed -E "s/\b($entity)\b/[[\1]]/")
done

# Generate backlinks
BACKLINKS=""
for entity in "${ENTITIES[@]}"; do
    if echo "$TRANSCRIBED_TEXT" | grep -qi "\b$entity\b"; then
        if [ -z "$BACKLINKS" ]; then
            BACKLINKS="[[$entity]]"
        else
            BACKLINKS="$BACKLINKS, [[$entity]]"
        fi
    fi
done

# Create temp file for the entry
TEMP_ENTRY=$(mktemp)

cat > "$TEMP_ENTRY" << EOF

### [$UNIQUE_ID] [Voice Note]
**Zeit:** $CURRENT_DATE $CURRENT_TIME
**Typ:** Information

$AUTO_LINKED_TEXT
EOF

if [ -n "$BACKLINKS" ]; then
    echo "" >> "$TEMP_ENTRY"
    echo "**Backlinks:** $BACKLINKS" >> "$TEMP_ENTRY"
fi

echo "" >> "$TEMP_ENTRY"
echo "---" >> "$TEMP_ENTRY"

# Check if today's date section exists
if ! grep -q "## $CURRENT_DATE" "$JOURNAL_FILE"; then
    # Create new date section after line 4 (after "# Journal\n\n---\n")
    sed -i '' "4a\\
\\
## $CURRENT_DATE\\
" "$JOURNAL_FILE"
fi

# Find line number for today's section and append entry after it
LINE_NUM=$(grep -n "^## $CURRENT_DATE" "$JOURNAL_FILE" | head -1 | cut -d: -f1)
NEXT_LINE=$((LINE_NUM))

# Use ed for safer insertion
ed -s "$JOURNAL_FILE" << EDSCRIPT
${NEXT_LINE}a
$(cat "$TEMP_ENTRY")
.
w
q
EDSCRIPT

# Cleanup
rm -f "$TEMP_ENTRY"

# Output success
echo "✅ Journal entry created: [$UNIQUE_ID]"
echo "📝 Entry added to: $JOURNAL_FILE"
echo "$UNIQUE_ID"
