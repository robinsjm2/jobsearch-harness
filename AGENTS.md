# Job Search Harness — Agent Instructions

This repository defines how AI agents help run two-week job search and engineering sprints, using Tyme MCP for tasks and time.

## Operating Model

- Work is organized into two-week sprints.
- Tyme is the authoritative system for planned work, task status, and time tracking.
- GitHub is the authoritative source for software project code.
- Markdown files in the personal data directory capture sprint goals, decisions, and retrospectives.

## Personal Data Directory

This repository holds only the generic process and templates. Personal data lives outside it, in `~/.jobsearch/`:

```
~/.jobsearch/
  sprints/            — One file per sprint (YYYY-MM-DD-sprint-NN.md); completed sprints move to sprints/archive/
  goals/              — Quarterly goals (YYYY-QN.md)
  notes/              — Scratch space for ideas, research, and decisions
  job-criteria.md     — Job search criteria
  applications.md     — Application and recruiter outreach tracker
  resume/
    fact-bank.md      — Verified facts; the only source for tailored resumes
    lessons.md        — Tailoring rules learned from feedback and outcomes
    tailored/         — Tailored resumes (Markdown + .docx), one per application
```

- The current sprint is the most recent file in `~/.jobsearch/sprints/` (not in `archive/`).
- Create new files from `templates/` in this repository.
- Never copy personal data into this repository.
- Tailored resumes use only facts from `resume/fact-bank.md`; never invent or embellish experience.

## Backing Up the Data Directory

### During setup

When creating `~/.jobsearch/` (or the first time you find it isn't a git repository), ask the user whether to back it up as a **private** git repository. Don't set it up without asking. Explain the trade-off:

- **Without a backup:** everything lives on one machine with no history. A lost or wiped laptop loses the tracker, the resume fact bank, and every sprint review. Accidental overwrites can't be undone.
- **Why it must be private, never public:** the directory holds data the user wouldn't want indexed or seen by an employer or recruiter:
  - Contact details (email, phone) and location in tailored resumes
  - Compensation floor and target pay in the job criteria
  - Every company applied to, and every rejection and the stage it happened at
  - That the user is job searching at all, which their current employer could see
  - Private notes about companies, recruiters, and interviews

  A public repo is indexed and copied quickly, and deleting it later doesn't undo that.
- **Recommended:** a private repository on the user's own GitHub account (e.g. `jobsearch-data`), named and created only with their approval. A local-only backup (e.g. Time Machine) is an acceptable alternative if the user prefers not to put this data on GitHub.

Before the first push, confirm the remote is private (e.g. `gh repo view --json visibility`). Never push this directory to a public repository, and never add it as a remote, submodule, or subfolder of this harness repo.

### Each session

If `~/.jobsearch/` is a git repository, commit and push changes at the end of each session in which its files changed, with a short message saying what changed (e.g. "Add Toast application; update Vanta stage"). Never commit confidential information the user has said must not be recorded.

## Agent Responsibilities

At the beginning of a sprint:

1. Review the sprint goal and objectives.
2. If no sprint file exists yet, create one from `templates/sprint.md` with the user.
3. Decompose objectives into meaningful actionable tasks.
4. Use Tyme MCP to scaffold the sprint backlog.
5. Keep tasks generally between 30 and 120 minutes.
6. Avoid creating unnecessary microtasks.
7. Keep the total workload realistic.

During the sprint:

1. Use Tyme to understand current progress.
2. Help prioritize remaining work.
3. Update Tyme when appropriate.
4. Do not silently change sprint objectives.
5. Distinguish planned work from newly discovered work.

At the end of the sprint:

1. Review completed and incomplete Tyme work.
2. Compare planned versus actual work.
3. Summarize accomplishments.
4. Identify unfinished work and why it remained unfinished.
5. Capture lessons for the next sprint in the sprint file's review section.
6. Move the finished sprint file to `~/.jobsearch/sprints/archive/`.

## Principles

- Optimize for meaningful outcomes, not task count.
- Avoid over-planning.
- Don't create process for the sake of process.
- Keep the human in control of priorities.
- Prefer working software and tangible progress over documentation.
- Don't recreate unnecessary corporate infrastructure.
- Don't introduce tools merely because they are available.
