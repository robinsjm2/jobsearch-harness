#!/usr/bin/env bash
# Title/end card for demo recordings. Usage: card.sh "<skill name>" [start|end]
clear
o=$'\033[1;38;5;209m'; b=$'\033[1m'; d=$'\033[2m'; r=$'\033[0m'
printf '\n\n'
if [ "${2:-start}" = start ]; then
  printf '   %s%s · live demo%s\n\n' "$o" "$1" "$r"
else
  printf '   %sEnd of demo: %s%s\n\n' "$o" "$1" "$r"
fi
printf '   %sSkills and harness by Jonathan Robinson%s · github.com/robinsjm2\n' "$b" "$r"
printf '   %sgithub.com/robinsjm2/agent-skills · github.com/robinsjm2/jobsearch-harness%s\n\n' "$d" "$r"
printf '   The job seeker, "Demo Candidate", is a %sfictional profile%s. All of its data is invented;\n' "$b" "$r"
printf '   job listings come from live, public Indeed search results.\n\n'
