#!/bin/bash
# ============================================================
# Un hommage à Bâton de pluies — local launcher for macOS
# Starts a localhost-only HTTP server in this folder, opens
# the HTML in Chrome as a chromeless app window, and cleans
# up the server when Chrome quits.
# ============================================================

set -e

# Resolve the directory this script lives in (so it works no
# matter where you double-click it from). Follows symlinks.
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Auto-detect the HTML file in this folder. Lets you keep multiple
# versions without editing this script — it picks the first match alphabetically.
HTML_FILE=$(ls un-hommage-a-baton-de-pluies*.html 2>/dev/null | head -n 1)
if [ -z "$HTML_FILE" ]; then
  osascript -e 'display alert "Un hommage à Bâton de pluies" message "No un-hommage-a-baton-de-pluies*.html file found in:\n'"$SCRIPT_DIR"'"'
  exit 1
fi

# Pick a free port starting at 8765 (avoids clashing with anything else).
PORT=8765
while lsof -i ":$PORT" >/dev/null 2>&1; do
  PORT=$((PORT + 1))
done

URL="http://localhost:$PORT/$HTML_FILE"

# Start Python's built-in server bound to localhost only.
# --bind 127.0.0.1 means: only your own machine can connect.
# Other devices on your Wi-Fi (or anywhere else) cannot reach it.
python3 -m http.server "$PORT" --bind 127.0.0.1 >/dev/null 2>&1 &
SERVER_PID=$!

# Make sure the server is killed when this script exits, no matter how.
cleanup() {
  if kill -0 "$SERVER_PID" 2>/dev/null; then
    kill "$SERVER_PID" 2>/dev/null || true
  fi
}
trap cleanup EXIT INT TERM

# Give the server a beat to come up.
sleep 0.4

# Try to find Chrome. Prefer Chrome (camera works most reliably);
# fall back to Brave/Edge/Arc/Safari if Chrome isn't installed.
CHROME=""
for CANDIDATE in \
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser" \
  "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" \
  "/Applications/Arc.app/Contents/MacOS/Arc"
do
  if [ -x "$CANDIDATE" ]; then
    CHROME="$CANDIDATE"
    break
  fi
done

if [ -n "$CHROME" ]; then
  # Open in app-mode: a clean window with no tabs, address bar, or extensions UI.
  # --user-data-dir keeps this app's state (cookies, camera permission grant)
  # separate from your normal Chrome profile, so your everyday browsing isn't
  # affected and the camera permission persists across launches.
  USER_DATA="$HOME/Library/Application Support/HommageBatonDePluies/chrome-profile"
  mkdir -p "$USER_DATA"
  "$CHROME" \
    --app="$URL" \
    --user-data-dir="$USER_DATA" \
    --no-first-run \
    --no-default-browser-check
else
  # No Chromium-family browser found — fall back to default browser.
  # Camera will still work in Safari but you'll see normal browser chrome.
  open "$URL"
  # Without Chrome we don't get a process to wait on, so wait for Ctrl+C
  # or for the user to close the script's Terminal window.
  echo "Un hommage à Bâton de pluies running at $URL"
  echo "Press Ctrl+C in this window to stop the server."
  wait "$SERVER_PID"
fi

# When Chrome's --app window closes, the script reaches here and the
# trap above shuts down the server cleanly. No lingering processes.
