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

### 🐰 Bunny - Workflow Automation & DevOps Engineer
**Platform:** macOS/iOS/iPadOS Native Tools & Scripts
**Role:** Obsidian workflow optimization and system integration specialist

**Core Responsibilities:**
- **Workflow Automation:** Shortcuts, Keyboard Maestro, Hazel, AppleScript
- **AI Integration:** Voice-to-text, smart linking, auto-tagging, summarization
- **Cross-Device Workflows:** Seamless integration across Mac, iPhone, iPad
- **Process Optimization:** Proactive analysis of Obsidian usage patterns and structure
- **System Integration:** Calendar, email, tasks, files → Obsidian

**Output Location:** `@bunny/` directory

### 📚 Obsidian - Knowledge Management Hub
**Location:** `~/localvault/Chris Notes`
**Structure:** PARA method (Projects, Areas, Resources, Archive)

**Core Functions:**
- Central source of truth for all information
- **Dashboard** (`000-DASHBOARD.md`) - Central cockpit with priorities, recent activity, handoffs
- **Monthly Journals** (`Journal-YYYY-MM.md`) - Detailed chronological entries with automatic archiving
- **Voice Capture System** - Multi-device voice-to-journal with AI-powered processing
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
- **Dashboard-Driven Workflow:** Central `000-DASHBOARD.md` for daily priorities and status
- **Scalable Journal Architecture:** Monthly archives prevent document bloat
- **Voice Capture System v2:** Multi-device (Mac/iPhone/Apple Watch) voice-to-journal
- **AI-Powered Processing:** Automatic entity detection and smart Wikilink generation
- **Daily Routines:** Morning briefings and evening handoffs for productivity
- Structured journal entries with unique IDs ([TYPE-YYYYMMDD-NNN])
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
├── BUNNY.md               # Bunny's role definition and technical capabilities
├── @ronny/                # Ronny's research outputs and reports
│   ├── flight_report_leipzig_milan_luxembourg_jan2026.md
│   ├── task_flight_research_milan.md
│   └── task_readme_github.md
└── @bunny/                # Bunny's workflows, scripts, and automation
    ├── workflows/         # Shortcuts, automations, and integrations
    │   ├── quick-capture-v2/      # Voice capture system (Mac/iOS/Watch)
    │   │   ├── README.md          # v2 architecture overview
    │   │   ├── simple-macOS-shortcut-guide.md
    │   │   ├── apple-watch-voice-capture-guide.md
    │   │   ├── WATCH-SETUP-QUICK-START.md
    │   │   └── conny-processing-guide.md
    │   └── morning-briefing/      # Auto-start morning briefing
    ├── inbox/             # Incoming requests and tasks for Bunny
    ├── templates/         # Obsidian templates
    ├── scripts/           # Shell scripts, AppleScripts
    ├── docs/              # Documentation and guides
    └── proposals/         # Optimization proposals and architecture designs
        ├── 001-voice-notes-journal-capture.md
        ├── 002-ingest-folder-architecture.md
        └── 003-journal-architecture-scalable.md
```

**External Integration:**
- Obsidian Vault: `~/localvault/Chris Notes/`
  - `000-DASHBOARD.md` - Central cockpit and daily command center
  - `Journal-YYYY-MM.md` - Monthly journal archives
  - `Ingest/voice-notes/` - Voice capture ingest folder
  - `Ingest/processed/` - Processed voice notes archive
  - `1. Projects/` - Active projects
  - `2. Resources/` - Reference materials, travel info
  - `3. Areas/` - Responsibility areas
  - `4. Archive/Journal/` - Historical monthly journals
  - `Work Stuff/` - Professional notes
  - `Templates/` - Daily handoff, morning briefing, journal templates

---

## Working Methodology

### Task Flow
1. **User Request** → Conny receives task
2. **Analysis** → Conny determines task type:
   - Research-intensive → Delegate to Ronny
   - Automation/workflow → Delegate to Bunny
   - Strategic/organizational → Conny handles directly
3. **Execution** → Appropriate agent executes with full context
4. **Documentation** → Results written to Obsidian with journal entry
5. **Optimization** → Bunny proactively identifies improvement opportunities

### Context Preservation
- **Conny** writes to `000-JOURNAL.md` with unique IDs
- **Ronny** reads Obsidian for context before research
- **Both** reference existing notes (Wikilinks, backlinks)
- **All** decisions and tasks are documented with rationale

### Collaboration Pattern
- **Conny:** Strategic thinking, execution, coordination, documentation
- **Ronny:** Data gathering, external research, report generation
- **Bunny:** Workflow automation, system integration, process optimization
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

### For Bunny (Automation Engineer)
1. Read `BUNNY.md` for role definition and capabilities
2. Receive workflow request from Conny or Chris
3. Analyze current Obsidian usage (read/write access)
4. Design automation solution
5. Create proposal in `@bunny/proposals/` if significant change
6. Implement workflows, scripts, shortcuts in `@bunny/`
7. Document usage in `@bunny/docs/`
8. Proactively suggest optimizations based on observations

### For Users
- Interact primarily with Conny via Claude Code
- Provide context, preferences, and requirements
- Review and approve plans before execution
- Receive structured updates via Obsidian journal

---

## Recent Innovations (January 2026)

### 🎯 Dashboard-Driven Workflow
**Status:** ✅ Live

Central command center (`000-DASHBOARD.md`) providing:
- Daily priorities and focus areas
- Recent activity overview (7 days)
- Critical items tracking
- Quick access to journals and resources
- Daily handoff integration

**Impact:** Single-page overview replaces scrolling through long journal files

---

### 📚 Scalable Journal Architecture
**Status:** ✅ Deployed

3-tier system replacing single monolithic journal:
- **Dashboard:** Central cockpit (~200-300 lines)
- **Monthly Journals:** `Journal-YYYY-MM.md` (~1,500 lines each)
- **Archive:** Automatic monthly archiving on 5th of following month

**Benefit:** Prevents performance degradation, maintains fast navigation

---

### 🎤 Voice Capture System v2 (Ingest Architecture)
**Status:** ✅ Operational

Multi-device voice-to-journal with AI processing:

**Capture Devices:**
- macOS: ⌘⌥V keyboard shortcut
- Apple Watch Series 3: "Hey Siri, Journal Note"
- iOS/iPad: (Planned)

**Architecture:**
```
Voice Input → Simple Shortcut → Ingest Folder → Conny Processing → Journal
```

**Key Features:**
- Ultra-simple shortcuts (4 actions on Mac)
- AI-powered entity detection and auto-linking
- ISO 8601 timestamps
- Bilingual support (German/English code-switching)
- Raw data preservation for error recovery

**Advantage:** 85-90% time savings vs manual journaling (30 sec vs 2-3 min)

---

### 🌅 Daily Routines
**Status:** ✅ Templates ready, auto-start pending

**Morning Briefing:**
- Automatic on first terminal launch
- Top 3 priorities for today
- Yesterday's summary
- Critical items review
- New voice notes check

**Daily Handoff:**
- Manual trigger: "Conny, daily handoff"
- Today's accomplishments
- Tomorrow's top 3 priorities
- Context preservation
- Open questions tracking

**Benefit:** Clear daily boundaries, reduced cognitive load

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
