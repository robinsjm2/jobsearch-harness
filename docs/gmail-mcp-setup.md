# How I Wired My AI Agent Into Gmail for Job Search

*Part of a series on building a personal job search and engineering sprint system.*

---

I've been building a lightweight personal sprint workspace that lets me manage my job search and engineering work using AI agents, Tyme for time tracking, and GitHub as the source of truth for code. One of the things I wanted early on was the ability to ask my agent — naturally, in conversation — to check my email for relevant job postings and recruiter outreach, filtered against my own criteria. No more manually scanning five different job alert digests every morning.

This post covers how I set that up: connecting Gmail to Kiro (my AI development environment) via MCP, building a reusable skill for filtering job-related email, and making the whole thing portable so others can plug in their own filters and use the same pattern.

---

## What is MCP and why does it matter here?

MCP (Model Context Protocol) is an open standard that lets AI agents interact with external tools and data sources through a consistent interface. Instead of copying and pasting content into a chat window, the agent can call tools directly — reading your inbox, querying a time tracker, searching a database — and reason about the results in context.

For job searching, this means instead of manually checking three job alert emails, I can ask: *"Were there any relevant postings this week?"* and get a filtered, evaluated answer back in seconds.

---

## The pieces

The setup involves four components:

1. **Gmail MCP server** — gives the agent read access to your inbox
2. **Job criteria file** — your personal filter rules, kept outside the repo
3. **Gmail job search skill** — teaches the agent how to use Gmail for job search
4. **Kiro MCP config** — wires it all together (never committed to git)

---

## Step 1: Set up Gmail API credentials in Google Cloud

Google's first-party Gmail MCP server requires joining their Developer Preview program, which has a waitlist. Instead, I used a community MCP server (`vinayak-mehta/gmail-mcp`) that works today with standard OAuth credentials.

### Create a Google Cloud project

Go to [console.cloud.google.com](https://console.cloud.google.com) and create a new project. Call it something like `personal-mcp`. Note your Project ID.

### Enable the Gmail API

Navigate to **APIs & Services → Library**, search for **Gmail API**, and enable it.

### Create OAuth credentials

Go to **APIs & Services → Credentials → Create Credentials → OAuth client ID**.

- Application type: **Desktop application**
- Give it a name like "Personal Gmail MCP"
- Click Create, then **download the JSON file**

Store it somewhere safe outside any repository. I keep mine at `~/.kiro/gmail-credentials.json`.

### Set up the OAuth consent screen

If you haven't configured it yet, Google will prompt you. A few things to know:

- Set the audience to **External** if you're using a personal Gmail account
- Add yourself as a **test user** under the consent screen settings — this is easy to miss and will cause an `access_denied` error if you skip it
- Add the scope `https://www.googleapis.com/auth/gmail.readonly`

### Run the one-time auth command

With `uv` installed, run this in your terminal:

```bash
uvx --from git+https://github.com/vinayak-mehta/gmail-mcp \
    --with "mcp<2" gmail-mcp auth \
    --creds-path ~/.kiro/gmail-credentials.json \
    --token-path ~/.kiro/gmail-token.json
```

A browser window will open. Sign in with your Gmail account and grant permissions. This writes a `gmail-token.json` file. You won't need to repeat this step unless the token expires or you revoke access.

> **Note on the `--with "mcp<2"` flag:** The community package was written against MCP v1. Without this flag, it fails with a `ModuleNotFoundError` about `fastmcp`. Pinning `mcp<2` fixes it.

---

## Step 2: Add Gmail to your Kiro MCP config

Kiro's MCP configuration lives at `~/.kiro/settings/mcp.json` — a user-level file that never goes into source control. Add the Gmail entry:

```json
{
  "mcpServers": {
    "gmail": {
      "command": "uvx",
      "args": [
        "--from",
        "git+https://github.com/vinayak-mehta/gmail-mcp",
        "--with",
        "mcp<2",
        "gmail-mcp"
      ],
      "env": {
        "GMAIL_CREDS_PATH": "/Users/you/.kiro/gmail-credentials.json",
        "GMAIL_TOKEN_PATH": "/Users/you/.kiro/gmail-token.json"
      },
      "disabled": false,
      "autoApprove": []
    }
  }
}
```

Replace the paths with wherever you saved your files. Reconnect the MCP server in Kiro's MCP panel and test with a quick message list to confirm it's working.

---

## Step 3: Create your job criteria file

This is the plug-in point — the part that makes the pattern personal and portable. Your criteria live in `~/.jobsearch/job-criteria.md`, outside any repository, so they never end up on GitHub. Start from the template:

```bash
mkdir -p ~/.jobsearch
cp templates/job-criteria.md ~/.jobsearch/job-criteria.md
```

The file defines:
- What role types you're targeting
- Seniority level and IC vs. management preference
- Remote requirements
- Technical strengths and relevant experience
- Industries to prioritize or avoid
- Compensation floor
- Hard excludes — automatic disqualifiers

Anyone who clones the repo writes their own criteria file, and the agent filters against their preferences instead of mine.

The repo contains a small steering file, `.kiro/steering/job-criteria.md`, set to `inclusion: manual`. It contains no criteria. It just tells the agent to load `~/.jobsearch/job-criteria.md`. The manual-inclusion setting means it only loads when you reference it in a conversation:

```markdown
---
inclusion: manual
---

# Job Search Criteria

The user's personal job criteria are stored outside this repository, in `~/.jobsearch/job-criteria.md`.
...
```

When you want the agent to use it, reference it in chat:

```
#job-criteria check my email for job alerts from the last 3 days
```

---

## Step 4: Create the Gmail job search skill

Skills in Kiro live in `.kiro/skills/` and define reusable agent behaviors. The Gmail job search skill tells the agent:

- When to activate (what phrases trigger it)
- How to search Gmail for job alerts and recruiter outreach
- How to evaluate results against your criteria file
- How to format and present the output

The key design decision here was to keep the skill generic and the criteria personal. The skill knows *how* to do the job; the criteria file tells it *what* to look for. That separation is what makes the whole thing portable.

The skill covers two main workflows:

**Job alert emails** — searches for messages from LinkedIn Jobs, Indeed, Glassdoor, ZipRecruiter, and other job boards, extracts individual postings, evaluates each against your criteria, and presents only Strong or Possible matches with a brief explanation of fit.

**Recruiter and company outreach** — searches for direct messages about opportunities, application status replies, and interview requests, categorizes each, and flags what needs a response.

---

## What it looks like in practice

Once everything is wired up, checking your job email is a single prompt:

> `#job-criteria` — check my email for job alerts from the last 3 days

The agent loads your criteria, searches Gmail, filters the results, and returns something like:

```
**Senior Platform Engineer — Acme Cloud Co.**
- Location/Remote: Remote
- Compensation: $160k–$185k
- Source: LinkedIn Jobs
- Fit: Strong match
- Why: AWS-heavy role with serverless and CDK focus. TypeScript required.
  No meaningful gaps given your background.

**Senior Backend Engineer — Some Startup**
- Location/Remote: Hybrid (NYC, 2 days/week)
- Compensation: Not disclosed
- Source: Indeed
- Fit: Possible match
- Why: Strong technical alignment on Python and distributed systems.
  Hybrid requirement is a secondary concern; compensation unknown.

---
Found 2 relevant job alerts and 1 recruiter message. 14 items excluded by criteria.
```

---

## Making it portable for others

The repo structure that makes this reusable:

```
.kiro/
  skills/
    gmail-job-search.md        ← committed, generic
  steering/
    job-criteria.md            ← committed, generic pointer to ~/.jobsearch/job-criteria.md
  settings/
    mcp.json.example           ← committed, template only
templates/
  job-criteria.md              ← committed, template for your criteria
  applications.md              ← committed, template for your tracker
.gitignore                     ← covers mcp.json and credential files

~/.jobsearch/                  ← outside the repo, personal
  job-criteria.md
  applications.md
```

The `.gitignore` ensures credentials never accidentally land in version control:

```
.kiro/settings/mcp.json
*.credentials.json
*-credentials.json
*-token.json
```

Anyone who wants to use this pattern:
1. Clones the repo
2. Follows the Gmail credential setup steps above
3. Copies `mcp.json.example` to `~/.kiro/settings/mcp.json` and fills in their paths and tokens
4. Copies the templates into `~/.jobsearch/` and writes their own criteria
5. Done — the skill works immediately against their inbox and criteria

---

## What's next

This is the first piece of a larger personal operating system I'm building in public. The same MCP pattern that reads my email also connects to Tyme for time tracking, letting me ask questions like *"how much time did I spend on job search vs. engineering this week?"* and get real answers backed by actual tracked data.

In the next post I'll cover the Tyme MCP setup and how I use it to run two-week sprints with AI-assisted planning and retrospectives.

---

*The repo that contains all of this is on GitHub. The credentials and personal data stay on my machine.*
