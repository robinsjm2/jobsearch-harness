# Demo Persona and Recording Guide

A fictional job seeker, **Alex Rivera**, for recording demos of the job-search skills without exposing anyone's real data. Every company, number, and contact detail here is invented.

## Set up

```bash
brew install asciinema agg
./setup-demo.sh                      # creates ~/Projects/jobsearch-demo
cd ~/Projects/jobsearch-demo
```

The workspace's `CLAUDE.md` points the skills at `./jobsearch-data/` instead of `~/.jobsearch/`, and tells Claude not to use Gmail or Tyme.

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
Shows: targeted Indeed searches, full-posting checks for real remote status and pay, ratings against Alex's criteria, and a saved sweep record. Real public listings will appear; no personal data is involved.

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

## Before publishing a GIF

Step through it frame by frame. Check that only the demo persona appears, with no real names, email, phone, inbox, or account data. Check terminal prompts and window titles too.
