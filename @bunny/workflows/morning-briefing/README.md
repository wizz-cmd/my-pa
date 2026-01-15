# Morning Briefing - Auto-Start beim Terminal Launch

**Status:** 📋 Für Bunny - Implementierung ausstehend
**Erstellt:** 2026-01-15
**Priorität:** Mittel

---

## Ziel

Wenn Chris das Terminal öffnet (erster Start des Tages), soll automatisch "Conny, morning briefing" ausgeführt werden.

---

## Anforderungen

1. **Nur einmal pro Tag** - Nicht bei jedem Terminal-Start
2. **Automatisch** - Ohne manuellen Input
3. **Nicht-blockierend** - Terminal bleibt nutzbar
4. **Konfigurierbar** - User kann es ein/ausschalten

---

## Lösungsansätze

### Option A: Shell Hook (.zshrc / .bashrc)

**Datei:** `~/.zshrc` oder `~/.bash_profile`

```bash
# Morning Briefing Auto-Start
MORNING_BRIEFING_DATE_FILE="$HOME/.cache/conny-morning-briefing-date"
TODAY=$(date +%Y-%m-%d)

if [ ! -f "$MORNING_BRIEFING_DATE_FILE" ] || [ "$(cat $MORNING_BRIEFING_DATE_FILE 2>/dev/null)" != "$TODAY" ]; then
    echo "$TODAY" > "$MORNING_BRIEFING_DATE_FILE"
    echo "🌅 Good Morning! Starte Morning Briefing..."
    sleep 1
    echo "Conny, morning briefing"
fi
```

**Vorteile:**
- ✅ Einfach zu implementieren
- ✅ Funktioniert in jedem Terminal

**Nachteile:**
- ❌ Benötigt manuelle .zshrc Änderung
- ❌ Läuft bei jedem neuen Terminal-Fenster (wenn an einem Tag mehrere geöffnet werden)

---

### Option B: LaunchAgent (macOS)

**Datei:** `~/Library/LaunchAgents/com.conny.morning-briefing.plist`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.conny.morning-briefing</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/osascript</string>
        <string>-e</string>
        <string>tell application "Terminal" to do script "claude 'Conny, morning briefing'"</string>
    </array>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>8</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>
    <key>RunAtLoad</key>
    <false/>
</dict>
</plist>
```

Load mit:
```bash
launchctl load ~/Library/LaunchAgents/com.conny.morning-briefing.plist
```

**Vorteile:**
- ✅ Präzises Timing (z.B. 8:00 Uhr)
- ✅ Unabhängig von Terminal-Starts
- ✅ macOS-nativ

**Nachteile:**
- ❌ Komplexer zu konfigurieren
- ❌ Öffnet neues Terminal-Fenster

---

### Option C: Claude Code Hook

**Datei:** `~/.claude/hooks/on-first-message.sh`

```bash
#!/bin/bash

# Check if this is the first message of the day
MORNING_BRIEFING_DATE_FILE="$HOME/.cache/conny-morning-briefing-date"
TODAY=$(date +%Y-%m-%d)

if [ ! -f "$MORNING_BRIEFING_DATE_FILE" ] || [ "$(cat $MORNING_BRIEFING_DATE_FILE 2>/dev/null)" != "$TODAY" ]; then
    echo "$TODAY" > "$MORNING_BRIEFING_DATE_FILE"

    # Trigger morning briefing
    cat << 'EOF'
🌅 Good Morning!

Heute ist $(date +"%A, %d. %B %Y")

Dein Morning Briefing wird geladen...
EOF

    # This will be shown before the user's first message
    exit 0
fi
```

**Vorteile:**
- ✅ Integriert in Claude Code
- ✅ Nur beim ersten Claude-Aufruf des Tages

**Nachteile:**
- ❌ Funktioniert nur wenn Claude Code genutzt wird
- ❌ Hook-System muss möglicherweise erst implementiert werden

---

### Option D: Keyboard Maestro Macro (Empfohlen!)

**Trigger:** "First Terminal Launch of Day"

**Macro:**
1. Check if file `~/.cache/conny-morning-briefing-date` exists
2. Read content
3. If content != today's date:
   - Write today's date to file
   - Wait 2 seconds (Terminal fully loaded)
   - Type: "claude 'Conny, morning briefing'"
   - Press Enter

**Vorteile:**
- ✅ Sehr flexibel
- ✅ GUI-basiert, einfach zu konfigurieren
- ✅ Kann an/aus geschaltet werden
- ✅ Zuverlässig

**Nachteile:**
- ❌ Benötigt Keyboard Maestro
- ❌ User muss Macro einrichten

---

## Empfehlung

**Kurzfristig (heute):** Option A (Shell Hook)
- Schnell implementierbar
- Funktioniert sofort

**Mittelfristig (nächste Woche):** Option D (Keyboard Maestro)
- Professionellere Lösung
- Mehr Kontrolle
- Bunny kann vollständiges Setup erstellen

---

## Implementierung Shell Hook (Option A)

### Datei anlegen:

```bash
# Erstelle Cache-Verzeichnis
mkdir -p ~/.cache

# Füge Hook zu .zshrc hinzu
cat >> ~/.zshrc << 'EOF'

# ===== Conny Morning Briefing Auto-Start =====
MORNING_BRIEFING_DATE_FILE="$HOME/.cache/conny-morning-briefing-date"
TODAY=$(date +%Y-%m-%d)

if [ ! -f "$MORNING_BRIEFING_DATE_FILE" ] || [ "$(cat $MORNING_BRIEFING_DATE_FILE 2>/dev/null)" != "$TODAY" ]; then
    echo "$TODAY" > "$MORNING_BRIEFING_DATE_FILE"

    echo ""
    echo "🌅 Good Morning! $(date +"%A, %d. %B %Y")"
    echo ""
    echo "📊 Starte Morning Briefing..."
    echo ""

    # Automatisch Conny aufrufen
    # Uncomment when ready:
    # claude "Conny, morning briefing"
fi
EOF

# Neu laden
source ~/.zshrc
```

### Test:

```bash
# Lösche Datum-Cache
rm ~/.cache/conny-morning-briefing-date

# Öffne neues Terminal
# → Sollte Morning Briefing Message zeigen
```

---

## Deaktivieren

```bash
# Kommentiere Zeile in .zshrc aus:
# claude "Conny, morning briefing"
```

---

## Nächste Schritte

1. **Bunny:** Entscheide welche Option implementiert werden soll
2. **Bunny:** Erstelle Implementierungs-Guide für User
3. **Conny:** Implementiere `morning briefing` Befehl mit Template
4. **Test:** 1 Woche Testphase
5. **Bunny:** Ggf. auf Keyboard Maestro migrieren

---

**Task für Bunny:** Implementierung des Morning Briefing Auto-Start
**Deadline:** Nächste Woche
**Priority:** Medium
