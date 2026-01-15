# Proposal 003: Scalable Journal Architecture + End-of-Day Routine

**Status:** 🟡 Proposal
**Created:** 2026-01-15
**For:** Chris
**By:** Conny

---

## Problem

**Aktueller Stand:**
- `000-JOURNAL.md` hat bereits **615 Zeilen** (nach 3 Tagen)
- Hochrechnung: ~1.500 Zeilen/Monat, ~18.000 Zeilen/Jahr
- **Nicht skalierbar** für langfristige Nutzung
- Performance-Probleme bei großen Dateien in Obsidian
- Schwierig, historische Einträge zu finden

**Anforderungen:**
1. ✅ Zentrales Steuerwerkzeug beibehalten
2. ✅ Einzelne Dokumente nicht zu lang
3. ✅ End-of-Day Zusammenfassung
4. ✅ Morning Handoff für nächsten Tag
5. ✅ Einfach zu navigieren
6. ✅ Automatisierbar

---

## Vorgeschlagene Lösung: 3-Ebenen-Architektur

```
📊 000-DASHBOARD.md (Zentrale Steuerung, immer aktuell)
    ↓
📅 Journal-YYYY-MM.md (Monatliche Archive)
    ↓
📝 Daily-YYYY-MM-DD.md (Tages-Details, optional)
```

---

## Ebene 1: Dashboard (Zentrale Steuerung)

**Datei:** `000-DASHBOARD.md`

### Inhalt:

```markdown
# Dashboard

**Heute:** 2026-01-15 Mittwoch | KW 03

---

## 🎯 Heute im Fokus

### Prioritäten
1. [ ] Beyond Budget Business Case erstellen
2. [ ] ZETA Symposium Anmeldung (Early Bird endet bald!)
3. [ ] Reise München buchen

### Wichtige Kontexte
- [[Beyond Budget-Krise 2026]] - Action Items in Arbeit
- [[Symposium Lieboch 09-11 März 2026]] - Reise geplant
- [[ISPE Konferenzen]] - 3 Events 2026

---

## 📥 Inbox / Quick Capture

<!-- Heute erfasste Voice Notes werden hier automatisch gelistet -->
- [INFO-20260115-002] Shortcut Feedback für Bunny
- [INFO-20260115-001] Berlin Café-Liste

---

## 📊 Recent Activity (Letzte 7 Tage)

| Datum | Einträge | Highlights |
|-------|----------|------------|
| 2026-01-15 | 2 | Shortcut Feedback, Berlin Cafés |
| 2026-01-14 | 4 | Lieboch Reise, Konferenzen 2026, Tests |
| 2026-01-13 | 1 | Beyond Budget-Krise (kritisch!) |

→ [[Journal-2026-01|Vollständiges Januar Journal]]

---

## 🗓️ Kommende Termine

- **09.-11.03.** ZETA Symposium Lieboch
- **20.-22.04.** ISPE Europe Annual Conference (Kopenhagen)
- **10.-11.12.** ISPE Pharma 4.0 Conference (Berlin)

---

## 🔗 Quick Links

### Archive
- [[Journal-2026-01]] (aktueller Monat)
- [[Journal-2025-12]]
- [[Journal-2025-11]]

### Projekte
- [[Beyond]] · [[DOT]] · [[CVRM Strategy]]
- [[PRE21]] · [[Roche]] · [[Capgemini]]

### Workflows
- [[Voice Notes]] · [[Ingest Folder]] · [[Quick Capture]]

---

## 💡 Daily Handoff

*Wird automatisch am Ende des Arbeitstags generiert*

**Gestern Abgeschlossen:**
- ✅ Reiseplanung Lieboch komplett
- ✅ Konferenz-Übersicht 2026 erfasst
- ✅ Shortcut v2 getestet und dokumentiert

**Offen für Morgen:**
- [ ] Beyond Business Case Draft
- [ ] ZETA Symposium anmelden (beide Personen!)
- [ ] München Hotel buchen

**Wichtige Kontexte:**
- Beyond Budget: 3,6M EUR Finanzierungslücke, 3-6 Monate Überbrückung nötig
- Bernd Schneidinger erwartet Business Case mit Faktor-10-Argument
```

**Vorteile:**
- ✅ Immer überschaubar (~200-300 Zeilen)
- ✅ Schneller Überblick über Status
- ✅ Zentrales Steuerwerkzeug
- ✅ Tägliche Updates automatisiert

---

## Ebene 2: Monatliche Journal-Archive

**Dateien:** `Journal-YYYY-MM.md` (z.B. `Journal-2026-01.md`)

### Struktur:

```markdown
# Journal Januar 2026

**Zeitraum:** 2026-01-01 bis 2026-01-31

---

## Monatszusammenfassung

*Wird am Ende des Monats generiert*

**Highlights:**
- Beyond Budget-Krise identifiziert und Action Items definiert
- Reise Lieboch komplett geplant
- 3 wichtige Konferenzen für 2026 erfasst
- Voice Capture Workflow v2 erfolgreich implementiert

**Statistik:**
- 15 Voice Notes verarbeitet
- 8 Projekte bearbeitet
- 5 wichtige Entscheidungen dokumentiert

---

## 2026-01-15

### [INFO-20260115-002] [Voice Note] Feedback: macOS Shortcut
**Zeit:** 08:58
**Typ:** Feedback für [[Bunny]]

[Vollständiger Inhalt...]

**Backlinks:** [[Bunny]], [[Shortcuts]], [[Voice Notes]]

---

### [INFO-20260115-001] [Voice Note] Berlin Café-Liste
**Zeit:** 07:53
[...]

---

## 2026-01-14

[...]
```

**Archivierungs-Regel:**
- Am **5. des Folgemonats** wird der Vormonat archiviert
- Beispiel: Am 05.02. wird `Journal-2026-01.md` nach `4. Archive/Journal/2026/` verschoben
- Nur aktuelle + 1 Vormonat bleiben in Root

**Vorteile:**
- ✅ Überschaubare Größe pro Monat (~1.500 Zeilen)
- ✅ Chronologisch durchsuchbar
- ✅ Alle Details erhalten
- ✅ Klare Struktur

---

## Ebene 3: Daily Notes (Optional)

**Dateien:** `Daily Notes/YYYY-MM-DD.md`

Nur für Tage mit sehr vielen Einträgen (>10):

```markdown
# 2026-01-15 Mittwoch

## Morning Review
- [ ] Beyond Business Case
- [ ] ZETA anmelden

## Captured Today
- [INFO-20260115-001] Berlin Cafés
- [INFO-20260115-002] Shortcut Feedback

## Evening Summary
**Accomplished:**
- ✅ Shortcut dokumentiert

**Tomorrow:**
- [ ] Business Case starten
```

**Vorteile:**
- ✅ Für intensive Arbeitstage
- ✅ Template-basiert
- ✅ Tagesplanung integriert

---

## End-of-Day Routine: "Daily Handoff"

### Automatisierter Workflow

**Trigger:** "Conny, daily handoff" oder "Conny, Tagesabschluss"

**Conny führt aus:**

#### 1. Heutigen Tag analysieren
```
- Scan Journal-YYYY-MM.md für heutiges Datum
- Zähle Einträge, identifiziere Highlights
- Erkenne offene Tasks aus Voice Notes
- Identifiziere kritische Themen
```

#### 2. Zusammenfassung generieren
```markdown
## Daily Summary: 2026-01-15

**Einträge heute:** 2 Voice Notes
**Fokus-Themen:** Automation, Travel Planning

**Wichtigste Erkenntnisse:**
1. Shortcut v2 funktioniert perfekt mit ISO 8601 + "Umbenanntes Objekt"
2. Berlin Café-Liste für ISPE Conference Dezember vorbereitet

**Kritische Items:**
- ⚠️ Beyond Budget: Business Case noch nicht gestartet
- ⚠️ ZETA Early Bird endet bald (450€ vs. 1.200€)
```

#### 3. Handoff für morgen erstellen
```markdown
## Handoff für 2026-01-16 (Donnerstag)

**Priorität 1: Beyond Business Case**
- Kontext: 3,6M EUR Finanzierungslücke, 3-6 Monate Überbrückung
- Argument: Faktor-10 Kostenersparnis durch kontinuierliche Arbeit
- Output: One-Pager für Bernd Schneidinger ([[Roche]])

**Priorität 2: ZETA Symposium Anmeldung**
- Deadline: Early Bird bald abgelaufen
- 450€ vs. 1.200€ pro Person
- 2 Personen anmelden ("hier sollten wir beide hin")

**Priorität 3: München Hotel**
- Rückreise 11.03.: Übernachtung München Flughafen
- Budget: 60-120€
- Empfehlung: Hilton/Novotel am Flughafen

**Wichtige Kontexte:**
- [[Beyond Budget-Krise 2026]]: Alle Action Items dokumentiert
- [[Symposium Lieboch 09-11 März 2026]]: Reise geplant, nur Buchungen fehlen
- [[ISPE Konferenzen]]: 3 Events 2026 vorgemerkt

**Offene Fragen:**
- Beyond: Interne Finanzierung über DOT-Marge möglich?
- ZETA: Wer ist die zweite Person?
```

#### 4. Dashboard aktualisieren
- Handoff in `000-DASHBOARD.md` eintragen
- Recent Activity aktualisieren
- Inbox für morgen vorbereiten

#### 5. Bestätigung ausgeben
```
✅ Daily Handoff erstellt
📊 Dashboard aktualisiert
📅 3 Prioritäten für morgen identifiziert
⚠️ 2 kritische Items markiert

Gute Nacht! Morgen früh lies das Dashboard für deinen Start in den Tag.
```

---

## Morning Routine: "Daily Briefing"

**Trigger:** "Conny, morning briefing" oder "Conny, daily briefing"

**Conny führt aus:**

#### 1. Dashboard präsentieren
```markdown
# Good Morning! Mittwoch, 15. Januar 2026

## 🎯 Deine Top 3 für heute

1. **Beyond Business Case** (KRITISCH)
   Kontext: [[Beyond Budget-Krise 2026]]
   Deadline: Diese Woche

2. **ZETA Symposium anmelden** (URGENT)
   Early Bird endet bald: 450€ vs. 1.200€

3. **München Hotel buchen**
   Für Rückreise 11.03.2026

## 📨 Was gestern passiert ist

- ✅ Shortcut v2 erfolgreich dokumentiert
- ✅ Berlin Café-Liste erstellt
- 📥 2 neue Voice Notes verarbeitet

## ⚠️ Offene kritische Items

- Beyond Budget: Business Case überfällig
- ZETA Early Bird: Zeitdruck

## 🗓️ Nächste Termine

- 09.03. ZETA Symposium (in 53 Tagen)
```

#### 2. Neue Ingests prüfen
```
Checking Ingest Folder...
✅ 0 neue Voice Notes (Folder ist leer)
```

#### 3. Erinnerungen ausgeben
```
📌 Heute wichtig:
- Bernd Schneidinger erwartet Business Case
- Early Bird Deadline beachten
```

---

## Migrations-Plan

### Phase 1: Setup (heute)
1. ✅ `000-DASHBOARD.md` erstellen
2. ✅ Aktuelles `000-JOURNAL.md` umbenennen zu `Journal-2026-01.md`
3. ✅ Ordner `4. Archive/Journal/2026/` anlegen
4. ✅ Template für Daily Handoff erstellen

### Phase 2: Routine etablieren (diese Woche)
1. Täglich: "Conny, daily handoff" am Abend
2. Täglich: "Conny, morning briefing" am Morgen
3. Dashboard manuell prüfen und anpassen
4. Feedback sammeln

### Phase 3: Automatisierung (nächste Woche)
1. Bunny: Keyboard Maestro Trigger für End-of-Day (automatisch um 18:00?)
2. Conny: Automatische Dashboard-Updates nach Ingest-Processing
3. Conny: Monatliche Archivierung automatisieren

### Phase 4: Optimierung (laufend)
1. Dashboard-Layout nach Nutzung anpassen
2. Handoff-Format verfeinern
3. Morning Briefing erweitern (Wetter, Kalender-Integration?)

---

## File Structure Übersicht

```
Chris Notes/
├── 000-DASHBOARD.md              # ⭐ Zentrale Steuerung (200-300 Zeilen)
├── Journal-2026-01.md             # Aktueller Monat (~1.500 Zeilen)
├── Journal-2025-12.md             # Vormonat (Backup, wird archiviert)
│
├── Daily Notes/                   # Optional
│   ├── 2026-01-15.md
│   └── 2026-01-14.md
│
├── 4. Archive/
│   └── Journal/
│       ├── 2026/
│       │   ├── Journal-2026-01.md (ab 05.02.)
│       └── 2025/
│           ├── Journal-2025-12.md
│           ├── Journal-2025-11.md
│           └── ...
│
├── Templates/
│   ├── Daily-Handoff.md
│   ├── Morning-Briefing.md
│   └── Daily-Note.md
```

---

## Vorteile der Lösung

### ✅ Für dich
1. **Zentrales Dashboard** bleibt überschaubar (200-300 Zeilen)
2. **Schneller Einstieg** jeden Morgen (Morning Briefing)
3. **Klarer Tagesabschluss** (Daily Handoff)
4. **Nichts geht verloren** (Vollständiges Archiv)
5. **Bessere Navigation** (Monatsweise statt 18.000 Zeilen)
6. **Performance** (Kleine Dateien = schnelles Obsidian)

### ✅ Für Conny
1. **Strukturierte Daten** (Leichter zu analysieren)
2. **Automatisierbar** (Klare Routinen)
3. **Kontextfenster-freundlich** (Dashboard statt komplettes Journal)
4. **Bessere Zusammenfassungen** (Monatliche Highlights)

### ✅ Für das System
1. **Skalierbar** (Funktioniert für 1 Jahr, 10 Jahre, 50 Jahre)
2. **Wartbar** (Klare Archivierungs-Regeln)
3. **Erweiterbar** (Daily Notes optional hinzufügbar)
4. **Obsidian-kompatibel** (Wikilinks, Backlinks funktionieren)

---

## Alternative Ansätze (nicht empfohlen)

### ❌ Alternative A: Wöchentliche Archive
**Problem:** Zu viele Dateien (52/Jahr), schwieriger zu navigieren

### ❌ Alternative B: Nur Daily Notes
**Problem:** Kein chronologischer Überblick, 365 Dateien/Jahr

### ❌ Alternative C: Quartalsweise Archive
**Problem:** Immer noch 4.500 Zeilen/Quartal, zu groß

### ❌ Alternative D: Alles in einer Datei
**Problem:** Aktueller Stand - nicht skalierbar

---

## Entscheidung benötigt

**Fragen an dich:**

1. **Dashboard-Inhalt:** Passt der vorgeschlagene Inhalt für `000-DASHBOARD.md`?
2. **End-of-Day Timing:** Wann möchtest du den "Daily Handoff"?
   - Automatisch um 18:00?
   - Manuell wenn du "Feierabend" sagst?
3. **Morning Briefing:** Willst du das automatisch beim ersten Terminal-Start des Tages?
4. **Daily Notes:** Brauchst du die optionale 3. Ebene oder reichen Dashboard + Monats-Journal?
5. **Archivierung:** 5. des Folgemonats OK, oder lieber 1. des Folgemonats?

---

## Nächste Schritte

**Wenn du zustimmst:**

1. Ich erstelle sofort `000-DASHBOARD.md` für dich
2. Ich benenne `000-JOURNAL.md` → `Journal-2026-01.md`
3. Ich lege Ordner-Struktur an
4. Ich erstelle Templates
5. Wir machen heute Abend den ersten "Daily Handoff" als Test

**Danach:** Du testest 1 Woche und gibst Feedback.

---

**Entscheidung:** Soll ich mit der Migration starten?

---

*Proposal by Conny - 2026-01-15*
