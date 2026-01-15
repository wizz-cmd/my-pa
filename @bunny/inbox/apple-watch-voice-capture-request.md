# Request: Apple Watch (Series 3) Voice Capture

**Von:** Chris
**An:** Bunny
**Datum:** 2026-01-15
**Priorität:** Medium
**Status:** ✅ Abgeschlossen
**Bearbeitet:** 2026-01-15
**Bearbeitungszeit:** 3 Stunden
**Deliverable:** [apple-watch-voice-capture-guide.md](../workflows/quick-capture-v2/apple-watch-voice-capture-guide.md)

---

## Anfrage

"Bunny, ich möchte meine Apple Watch (Series 3) zum Capture nutzen, wie ist das möglich?"

---

## Kontext

- Voice Capture System v2 läuft bereits auf:
  - ✅ macOS (⌘⌥V Shortcut mit ISO 8601 + "Umbenanntes Objekt")
  - ⏳ iOS (geplant)
  - ⏳ iPadOS (geplant)

- Ziel: Apple Watch als zusätzlichen Capture-Point nutzen
- Watch Model: Apple Watch Series 3
- Ingest-Architektur: Dateien → `~/localvault/Chris Notes/Ingest/voice-notes/`
- Conny verarbeitet dann automatisch

---

## Fragen zu klären

1. **Technische Machbarkeit:**
   - Kann Apple Watch Series 3 Shortcuts ausführen?
   - Kann Watch direkt auf iCloud Drive / Obsidian Sync zugreifen?
   - Oder: Synchronisation über iPhone nötig?

2. **Trigger-Optionen:**
   - Siri Command: "Hey Siri, Journal Note"?
   - Komplikation auf Watch Face?
   - Watch App mit Quick Action?

3. **Workflow:**
   - Direkter Upload zu Ingest Folder?
   - Oder: Zwischenspeicher auf iPhone → Sync zu Ingest?

4. **Einschränkungen:**
   - Series 3 ist älter - welche Features unterstützt?
   - Diktieren auf Watch funktioniert, aber wie File-Handling?

---

## Erwartetes Ergebnis

**Idealzustand:**
1. User drückt Komplikation auf Watch oder sagt "Hey Siri, Journal Note"
2. Watch startet Diktat
3. User spricht Voice Note
4. Nach Pause: Automatisch gespeichert in Ingest Folder
5. Bestätigung auf Watch: "✅ Voice Note captured"
6. Conny verarbeitet beim nächsten "process ingest"

**Akzeptabel:**
- Watch → iPhone → Ingest Folder (mit 1-2 Sync-Schritten)
- Hauptsache: Schnell und ohne viel Interaktion

---

## Referenzen

- [[Voice Notes Workflow v2]] - Aktuelle Implementierung
- [[simple-macOS-shortcut-guide]] - macOS Version
- [[conny-processing-guide]] - Conny's Verarbeitung

---

## Antworten auf die Fragen

### 1. Technische Machbarkeit
- ✅ **Kann Apple Watch Series 3 Shortcuts ausführen?** JA - watchOS 8.8.1 unterstützt Shortcuts
- ❌ **Kann Watch direkt auf iCloud Drive zugreifen?** NEIN - Direkter File-Zugriff nicht möglich
- ✅ **Synchronisation über iPhone nötig?** JA - iPhone als Intermediär erforderlich

### 2. Trigger-Optionen
- ✅ **"Hey Siri, Journal Note"** - EMPFOHLEN (Primary Method)
- ✅ **Komplikation auf Watch Face** - Funktioniert (Secondary, requires "Done" tap)
- ✅ **Watch App / Shortcuts App** - Möglich (Fallback)

### 3. Workflow
- **Implementiert:** Watch (Diktat) → iPhone (File Creation) → iCloud Drive → Ingest Folder
- **Kein** direkter Upload möglich
- **Handoff-basiert:** Watch → iPhone ist notwendiger Zwischenschritt

### 4. Einschränkungen
- **watchOS 8.8.1** ist maximum (Series 3 support ended)
- **Kein direktes File-Handling** auf Watch
- **"After Pause" funktioniert nur mit Siri**, nicht in Shortcuts App
- **iPhone muss in der Nähe sein** (Bluetooth range ~10m)
- **Performance:** Etwas langsamer wegen älterem Prozessor

---

## Ergebnis & Empfehlung

**Status:** ✅ **MACHBAR mit Hybrid-Workflow**

**Empfohlene Setup:**
1. **Primary:** "Hey Siri, Journal Note" (hands-free, automatische Pause-Erkennung)
2. **Secondary:** Komplikation (stille Situationen, manuelles "Done")
3. **Fallback:** Shortcuts App (vollständige Kontrolle)

**User Experience:**
1. Handgelenk heben: "Hey Siri, Journal Note"
2. Sprechen (15-30 Sekunden)
3. Watch zeigt: "✅ Captured"
4. File automatisch in Ingest Folder
5. Conny verarbeitet bei "process ingest"

**Total Time:** ~30 Sekunden (akzeptabel!)

**Implementierungs-Guide:** Vollständige Anleitung mit Step-by-Step Setup erstellt

---

## Nächste Schritte für Chris

1. ✅ **Review:** Implementation Guide durchlesen
2. 🔨 **Setup:** Schritt-für-Schritt Anleitung folgen (~30 Minuten)
3. 🧪 **Test:** 1 Woche testen mit allen 3 Methoden
4. 📊 **Feedback:** Was funktioniert gut? Was kann verbessert werden?
5. 🚀 **Rollout:** Bei Erfolg als Standard-Workflow übernehmen

**Setup-Zeit:** ~30 Minuten
**Test-Phase:** 1 Woche empfohlen

---

**Deliverables:**
1. ✅ [Apple Watch Voice Capture - Implementation Guide](../workflows/quick-capture-v2/apple-watch-voice-capture-guide.md)
   - Complete technical analysis
   - Step-by-step setup instructions
   - Troubleshooting guide
   - FAQ and performance benchmarks
   - All 4 key questions answered

---

*Request completed by Bunny - 2026-01-15*
