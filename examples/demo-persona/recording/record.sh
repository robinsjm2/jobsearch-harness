#!/usr/bin/env bash
# Record a demo clip with VHS and convert it to a GIF.
# Usage: ./record.sh sweep|status
# Requires: brew install vhs   (installs ttyd and ffmpeg)
# One-time: run `claude` interactively in /Users/Shared/jobsearch-demo once and
# accept the trust prompt; the tapes assume the folder is already trusted.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
clip="${1:?usage: record.sh sweep|status}"
demo=/Users/Shared/jobsearch-demo   # neutral path: no username on screen
case "$clip" in
  sweep)  out=job-search-sweep; speed=1.4 ;;
  status) out=application-status; speed=1.2 ;;
  *) echo "unknown clip: $clip" >&2; exit 1 ;;
esac
rm -rf "$demo"
"$here/../setup-demo.sh" "$demo" >/dev/null
cd "$here"
vhs "$clip.tape"
ffmpeg -v error -y -i "$clip.mp4" -filter_complex \
  "[0:v]setpts=PTS/$speed,fps=10,scale=1100:-1:flags=lanczos,split[a][b];[a]palettegen=max_colors=96[p];[b][p]paletteuse=dither=bayer:bayer_scale=4" \
  -loop 0 "$out.gif"
echo "Wrote $here/$out.gif. Check it frame by frame before publishing."
