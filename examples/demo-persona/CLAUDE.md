# Demo workspace: fictional job seeker (for recordings)

This workspace demonstrates the jobsearch-harness skills with a **fictional persona, Alex Rivera**. Everything here is invented.

- **Data directory:** use `./jobsearch-data/` (relative to this workspace) **instead of `~/.jobsearch/`** everywhere a skill mentions it.
- **Never read or write `~/.jobsearch/`**, and never show the real user's personal data.
- **Email and time tracking are mocked.** Use the `demo-gmail` server for anything email-related (job alerts, application replies, recruiter outreach) and `demo-tyme` for sprint tasks and time. They serve fictional fixture data. **Never use the real `gmail` or `tyme` servers** here; they connect to real accounts and are denied in `.claude/settings.json`. Indeed searches are fine, since they return public job listings.
- Sample postings for tailoring live in `./postings/`.
- Don't commit or push anything from this workspace.
- Keep responses concise; this session is being recorded.
