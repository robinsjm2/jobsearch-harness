# Demo Persona and Recording Guide

A fictional job seeker, **Demo Candidate**, for recording demos of the job-search skills without exposing anyone's real data. Every company, number, and contact detail here is invented.

## Set up

```bash
brew install asciinema agg
./setup-demo.sh                      # creates ~/Projects/jobsearch-demo
cd ~/Projects/jobsearch-demo
```

The workspace's `CLAUDE.md` points the skills at `./jobsearch-data/` instead of `~/.jobsearch/`, and tells Claude not to use Gmail or Tyme. Its `.claude/settings.json` enforces that: Gmail, Tyme, `~/.jobsearch`, `git push` and `open` are denied, and the Indeed connector and in-folder file edits are pre-approved so recordings don't stop for permission prompts.

## Record

```bash
asciinema rec --idle-time-limit 2 sweep.cast    # Ctrl-D to stop
agg --speed 1.5 sweep.cast sweep.gif
```

`--idle-time-limit 2` caps pauses while Claude works. Aim for 30–60 seconds per clip. Re-create the workspace between takes (`rm -rf ~/Projects/jobsearch-demo && ./setup-demo.sh`) so each run starts clean.

## Clips

### 1. Find new jobs: `job-search-sweep`

```
claude
> /job-search-sweep
```
Shows: targeted Indeed searches, full-posting checks for real remote status and pay, ratings against the demo candidate's criteria, and a saved sweep record. Real public listings will appear; no personal data is involved.

### 2. Tailor a resume: `tailor-resume`

```
claude
> Tailor my resume for the Ferncrest Health posting in postings/
> yes                                   # after the fit walkthrough
> No Kubernetes or RAG experience.      # answer the gap question
```
Shows: posting analysis, the coverage table, the "should we continue?" check-in, one-at-a-time gap questions, a draft built only from the fact bank, and a rendered .docx.

### 3. Log the application

```
> I applied to Ferncrest Health
```
Shows: the tracker row with Status/Stage, and the lessons outcome log.

### 4. Application status check: `gmail-job-search` (mocked)

```
> Any updates on my applications? Check my email and update my tracker, including anything that's missing.
```
Shows follow-ups on tracked applications: Tidewater Labs invites the candidate to a technical interview (Stage moves to Technical interview, flagged Action required with its deadline), and Quillstone confirms receipt. It also shows a rejection from Harborlight Media, which isn't in the tracker, being detected as an untracked application and added, plus new recruiter outreach rated against the criteria. The tracker file is updated with Status and Stage.

### 5. Check email for job alerts: `gmail-job-search` (mocked)

```
> Check my email for job alerts and replies on my applications
```
Shows: a job alert filtered against the demo candidate's criteria (on-site, manager and below-floor roles dropped), a follow-up on an existing application (Tidewater technical interview, Action required), a confirmation, a form rejection (counted, tracker updated), and new recruiter outreach. All of it comes from the `demo-gmail` mock (`mocks/fixtures/emails.json`).

### 6. Sprint check: Tyme (mocked)

```
> What's left in my sprint, and how much time did I log this week?
```
Uses the `demo-tyme` mock (`mocks/fixtures/tyme.json`). Updates stay in memory and reset each session.

## Mocked services

`mocks/` contains two small MCP servers, `demo-gmail` and `demo-tyme`, with the same tool names and signatures as the real Gmail and Tyme servers, backed by fictional JSON fixtures. `.mcp.json` registers them for this workspace only. The real servers are denied in `.claude/settings.json`, so a demo can't reach real accounts. Edit the fixtures to stage different scenarios.

## Before publishing a GIF

Step through it frame by frame. Check that only the demo persona appears, with no real names, email, phone, inbox, or account data. Check terminal prompts and window titles too.
