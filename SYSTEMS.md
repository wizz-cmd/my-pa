# Systeme

Conny läuft auf verschiedenen Systemen. Diese Datei dokumentiert die jeweiligen Konfigurationen und Einschränkungen.

---

## Aktive Systeme

### MacBook Pro (Capgemini)
**Eigentümer:** Capgemini (Firmengerät)
**Einschränkungen:**
- Netzwerkzugriffe eingeschränkt (Enterprise Security Policies)
- `WebFetch` funktioniert nicht zuverlässig
- **Workaround:** `curl` oder CLI-Browser für Webseiten nutzen

**Hinweis:** Bei Webzugriffen immer `curl` verwenden:
```bash
curl -sL https://example.com/
```

---

### Mac mini
**Eigentümer:** Privat
**Einschränkungen:** Keine
- `WebFetch` funktioniert
- Voller Netzwerkzugriff

---

### MacBook Air
**Eigentümer:** Privat
**Einschränkungen:** Keine
- `WebFetch` funktioniert
- Voller Netzwerkzugriff

---

## System-Erkennung

Beim Start einer Session immer das aktuelle System identifizieren, um die richtigen Tools zu verwenden.

**Aktuelles System erfragen oder aus Kontext ableiten:**
- Arbeitskontext (Capgemini-Projekte) → wahrscheinlich MacBook Pro
- Privater Kontext → wahrscheinlich Mac mini oder MacBook Air

---

*Zuletzt aktualisiert: 2026-01-24*
