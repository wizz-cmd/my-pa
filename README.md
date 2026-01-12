# my-pa - Personal Assistant System

**AI-powered personal and executive assistant system combining Claude Code and Gemini CLI with Obsidian knowledge management.**

---

## Overview

`my-pa` is a sophisticated personal assistant ecosystem designed to support Chris in managing complex organizational, strategic, and administrative tasks. The system combines two specialized AI assistants with a central Obsidian knowledge base to provide seamless, context-aware assistance across multiple domains.

The repository serves as the coordination hub for assistant configurations, task delegation workflows, and research outputs. It integrates with Chris's Obsidian vault (`~/localvault/Chris Notes`) to maintain continuity, preserve context, and build institutional knowledge over time.

This is not just a collection of scripts - it's an intelligent support system that learns from past decisions, maintains detailed project histories, and provides proactive assistance across professional and personal matters.

---

## System Architecture

### 🤖 Conny - Personal & Executive Assistant
**Platform:** Claude Code (Sonnet 4.5)
**Role:** Primary assistant for organizational, strategic, and executive tasks

**Core Responsibilities:**
- **Organizational & Administrative Tasks:** Scheduling, booking, logistics coordination
- **Strategic Support:** Project planning, decision analysis, progress tracking
- **Private & Lifestyle Support:** Travel planning, personal organization, daily assistance
- **Knowledge Management:** Obsidian vault maintenance, journal entries, entity documentation

**Key Capabilities:**
- Direct read/write access to Obsidian vault
- Creates structured journal entries with unique IDs ([TYPE-DATE-NUMBER])
- Manages entity notes (people, places, projects) with Wikilinks
- Delegates research-intensive tasks to Ronny
- Maintains PARA organization (Projects, Areas, Resources, Archive)

### 🔍 Ronny - Research Assistant
**Platform:** Gemini CLI
**Role:** Back-office administrative assistant for research and information retrieval

**Core Responsibilities:**
- **External Research:** Web searches, data gathering, market analysis
- **Information Retrieval:** Document analysis, data extraction, synthesis
- **Report Generation:** Structured reports, summaries, briefings
- **Contextual Research:** Leverages Obsidian vault (read-only) for informed research

**Output Location:** `@ronny/` directory

### 📚 Obsidian - Knowledge Management Hub
**Location:** `~/localvault/Chris Notes`
**Structure:** PARA method (Projects, Areas, Resources, Archive)

**Core Functions:**
- Central source of truth for all information
- Master journal (`000-JOURNAL.md`) tracking activities, decisions, tasks
- Entity notes for people, places, projects, companies
- Cross-linked notes using Wikilinks and backlinks
- Read/write access for Conny, read-only access for Ronny

---

## Main Functions

### 🌍 Travel Planning & Management
- Research and booking of flights, trains, hotels
- Itinerary creation with preference optimization
- Loyalty program integration (IHG Platinum, Marriott Gold)
- Route optimization and travel documentation

**Example:** Leipzig → Milan → Saarbrücken business trip planning (January 2026) with flight options, hotel booking (Crowne Plaza Milan), and route coordination.

### 🏢 Real Estate & Property Management
- Sale preparation tracking (PRE21 apartment, Saarbrücken)
- Contractor coordination (OS Innenausbau, Ideal Standard, cleaning services)
- Progress monitoring with percentage completion tracking
- Cost management and budget tracking

**Example:** PRE21 sale preparation at 61% completion (11/18 tasks), €2,400 renovation contract, cleaning service coordination.

### 💼 Business & Professional Support
- Client coordination (Capgemini, Bayer)
- Meeting preparation and follow-up
- Business travel logistics
- Professional relationship management

**Example:** Capgemini Milano business meeting coordination with office location, metro routing, and agenda preparation.

### 📖 Knowledge Management with Obsidian
- Structured journal entries with unique IDs
- Entity management (people, places, projects)
- Decision documentation with rationale
- Preference tracking (travel, working style)
- Cross-referenced notes for context preservation

---

## Technology Stack

### AI Assistants
- **Claude Code** (Sonnet 4.5) - Primary assistant, code execution, file operations
- **Gemini CLI** - Research assistant, web access, report generation

### Knowledge Management
- **Obsidian** - Personal knowledge base, PARA method, Markdown-based
- **Git/GitHub** - Version control for assistant configurations

### Integration
- **Wikilinks** - Cross-referencing between notes
- **PARA Method** - Projects, Areas, Resources, Archive organization
- **Unique ID System** - [TYPE-YYYYMMDD-NNN] for tracking entries

---

## File Structure

```
my-pa/
├── README.md              # This file - project documentation
├── CLAUDE.md              # Conny's system instructions and guidelines
├── GEMINI.md              # Ronny's role definition and working principles
└── @ronny/                # Ronny's research outputs and reports
    ├── flight_report_leipzig_milan_luxembourg_jan2026.md
    ├── task_flight_research_milan.md
    └── task_readme_github.md
```

**External Integration:**
- Obsidian Vault: `~/localvault/Chris Notes/`
  - `000-JOURNAL.md` - Master journal
  - `1. Projects/` - Active projects
  - `2. Resources/` - Reference materials
  - `3. Areas/` - Responsibility areas
  - `Work Stuff/` - Professional notes

---

## Working Methodology

### Task Flow
1. **User Request** → Conny receives task
2. **Analysis** → Conny determines if research-intensive
3. **Delegation** (if needed) → Ronny handles external research
4. **Execution** → Conny executes with full context from Obsidian
5. **Documentation** → Results written to Obsidian with journal entry

### Context Preservation
- **Conny** writes to `000-JOURNAL.md` with unique IDs
- **Ronny** reads Obsidian for context before research
- **Both** reference existing notes (Wikilinks, backlinks)
- **All** decisions and tasks are documented with rationale

### Collaboration Pattern
- **Conny:** Strategic thinking, execution, documentation
- **Ronny:** Data gathering, external research, report generation
- **Obsidian:** Single source of truth, context preservation
- **GitHub:** Configuration versioning, continuity across sessions

---

## How It Works

### For Conny (Claude Code)
1. Read `CLAUDE.md` for system instructions
2. Access Obsidian vault at `~/localvault/Chris Notes/`
3. Check `000-JOURNAL.md` for recent context
4. Execute tasks with full read/write access
5. Document outcomes in journal and entity notes
6. Delegate research tasks to Ronny when needed

### For Ronny (Gemini CLI)
1. Read `GEMINI.md` for role definition
2. Receive task brief in `@ronny/task_*.md`
3. Read Obsidian vault (read-only) for context
4. Conduct external research
5. Generate report in `@ronny/` directory
6. Return results to Conny for integration

### For Users
- Interact primarily with Conny via Claude Code
- Provide context, preferences, and requirements
- Review and approve plans before execution
- Receive structured updates via Obsidian journal

---

## Current Projects

### ✈️ Travel Management
- **Milan Business Trip** (21-23 Jan 2026): Leipzig → Milan → Saarbrücken
  - Crowne Plaza Milan City (IHG Platinum)
  - Capgemini meeting at Via Gattamelata 34
  - Flight + train combination routing

### 🏠 Real Estate
- **PRE21 Sale Preparation** (Preußenstraße 21, Saarbrücken)
  - 61% progress (11/18 tasks completed)
  - OS Innenausbau renovation (€2,400 netto)
  - Reinigungsfirma Rasin for final cleaning

### 📊 Business Support
- **Capgemini Coordination:** Milano office meeting planning
- **Professional Travel:** European client visits and logistics

---

## Design Philosophy

### Professional, Not Promotional
- Technical and factual documentation
- Concrete examples over marketing language
- Clear structure and practical information

### Bilingual by Context
- German for personal/local matters (real estate, travel bookings)
- English for technical documentation and code
- Mixed language where contextually appropriate

### Privacy-Conscious
- No sensitive personal information in repository
- No API keys, credentials, or private addresses
- Generic descriptions for confidential projects

---

**System Status:** Active and operational as of January 2026

**Repository:** https://github.com/wizz-cmd/my-pa

---

*Maintained by Conny (Claude Code) and Ronny (Gemini CLI) for Chris*
