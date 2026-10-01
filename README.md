# Job Search Harness

This repository is a harness for running a job search as two-week sprints with AI agents. Tyme MCP handles tasks and time tracking. Gmail MCP handles job alerts and recruiter outreach. The harness defines the process: agent instructions, templates, and MCP setup. Your personal data (sprint plans, goals, criteria, application tracker) lives in a local directory outside the repo, so it can't be committed by accident.

## Conceptual Model

```
~/Projects/workspaces/jobsearch-harness/   — Process, agent instructions, templates (this repo)
~/.jobsearch/                              — Your sprints, goals, criteria, application tracker (local, never committed)
~/Projects/agent-skills/                   — Reusable AI agent skills (e.g. gmail-job-search)
Tyme                                       — Tasks + status + time tracking
Gmail (via MCP)                            — Job alerts and recruiter outreach
Indeed (via MCP)                           — Searching for new openings
GitHub                                     — Source of truth for code
```

## What This Repo Is

A lightweight, reusable operating model: how agents plan a sprint, scaffold it in Tyme, track it, and review it, plus templates for the files that process uses. It holds the *how*. Your data directory holds the *what*.

## What This Repo Is Not

It is not a software project. It has no build system, test suite, or deployment pipeline. It also holds no personal data.

## Relationships

**Tyme** is the authoritative system for planned work, task status, and time tracking. Tasks live in Tyme. Sprint files in `~/.jobsearch/sprints/` hold the goals and context behind those tasks.

**Gmail MCP** lets agents check job alerts and recruiter outreach. The [gmail-job-search](https://github.com/robinsjm2/agent-skills/blob/main/skills/gmail-job-search/SKILL.md) skill filters those messages against `~/.jobsearch/job-criteria.md` and skips roles already listed in `~/.jobsearch/applications.md`.

**Indeed MCP** (a claude.ai connector) lets agents search for new openings. The [job-search-sweep](https://github.com/robinsjm2/agent-skills/blob/main/skills/job-search-sweep/SKILL.md) skill runs targeted searches, confirms remote status and pay from the full postings, and records each sweep in `~/.jobsearch/notes/sweeps/`.

**Resume tailoring:** the [tailor-resume](https://github.com/robinsjm2/agent-skills/blob/main/skills/tailor-resume/SKILL.md) skill tailors a resume to one posting using only a personal fact bank, renders it to .docx, and records which resume version was used so its rules improve with each outcome.

**agent-skills** holds the canonical skill definitions. `.kiro/skills/` here is a local copy.

**AI agents** (Claude Code, Kiro, etc.) use this repo, especially `AGENTS.md`, as their operating instructions.

## Directory Structure

```
templates/               — Starting points for files in ~/.jobsearch/
  sprint.md              — Two-week sprint plan and review
  quarter-goals.md       — Quarterly goals
  job-criteria.md        — Job search criteria
  applications.md        — Application and recruiter outreach tracker
  resume/                — Templates for the resume fact bank and tailoring lessons
docs/                    — Setup guides (e.g. Gmail MCP)
.kiro/steering/          — job-criteria.md: manual-inclusion steering that points agents at ~/.jobsearch/job-criteria.md
.kiro/skills/            — Local copy of agent skills
.kiro/settings/          — MCP config template (real config lives in ~/.kiro/settings/mcp.json)
AGENTS.md                — Portable operating rules for AI agents
CLAUDE.md                — Claude-specific instructions (defers to AGENTS.md)
```

## Demo Persona

`examples/demo-persona/` contains a fictional job seeker (Alex Rivera) with criteria, a fact bank, a tracker, and a sample posting. Use it to try the skills, or to record demos, without real data. See `examples/demo-persona/DEMO.md`.

## Personal Data Directory

```
~/.jobsearch/
  sprints/               — One file per sprint; completed sprints move to sprints/archive/
  goals/                 — Quarterly goals
  notes/                 — Scratch space for ideas, research, and decisions
  job-criteria.md
  applications.md
  resume/                — fact-bank.md, lessons.md, tailored/
```

Set it up from the templates:

```bash
mkdir -p ~/.jobsearch/sprints/archive ~/.jobsearch/goals ~/.jobsearch/notes
cp templates/job-criteria.md templates/applications.md ~/.jobsearch/
cp templates/quarter-goals.md ~/.jobsearch/goals/YYYY-QN.md
cp templates/sprint.md ~/.jobsearch/sprints/YYYY-MM-DD-sprint-01.md
mkdir -p ~/.jobsearch/resume/tailored
cp templates/resume/*.md ~/.jobsearch/resume/
```

Nothing in `~/.jobsearch/` is versioned or backed up by this repo. Back it up as a **private** git repository of its own (your agent will offer to set this up), or at least with Time Machine. **Never make it public:** it holds your contact details, pay targets, every application and rejection, and the fact that you're job searching. See "Backing Up the Data Directory" in `AGENTS.md`.

## Setup

1. Copy `.kiro/settings/mcp.json.example` to `~/.kiro/settings/mcp.json` and fill in your Tyme and Gmail credentials. See `docs/gmail-mcp-setup.md` for Gmail.
2. Create `~/.jobsearch/` as shown above and fill in `job-criteria.md`.
3. Decide how to back up `~/.jobsearch/`: a private git repo (recommended) or a local backup. Never a public repo.
4. Ask your agent to plan the first sprint.
