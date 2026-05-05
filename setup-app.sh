#!/bin/bash
# ============================================================
# One-time setup: turns launch-baton-de-pluies.sh into a real
# .app bundle you can put in Applications or Dock.
# Run this once. After that, you just double-click the .app.
# ============================================================

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

APP_NAME="Un hommage à Bâton de pluies"
APP_DIR="$SCRIPT_DIR/$APP_NAME.app"

# Make sure the launcher exists and is executable
if [ ! -f "$SCRIPT_DIR/launch-baton-de-pluies.sh" ]; then
  echo "Error: launch-baton-de-pluies.sh not found in $SCRIPT_DIR"
  exit 1
fi
chmod +x "$SCRIPT_DIR/launch-baton-de-pluies.sh"

# Build the .app bundle structure (this is just a folder with a specific layout)
echo "Creating $APP_NAME.app..."
rm -rf "$APP_DIR"
mkdir -p "$APP_DIR/Contents/MacOS"
mkdir -p "$APP_DIR/Contents/Resources"

# Info.plist tells macOS this is an app and what to launch
cat > "$APP_DIR/Contents/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleName</key>
  <string>Un hommage à Bâton de pluies</string>
  <key>CFBundleDisplayName</key>
  <string>Un hommage à Bâton de pluies</string>
  <key>CFBundleIdentifier</key>
  <string>com.annbjer.hommage-baton-de-pluies</string>
  <key>CFBundleVersion</key>
  <string>1.0</string>
  <key>CFBundleExecutable</key>
  <string>launcher</string>
  <key>CFBundlePackageType</key>
  <string>APPL</string>
  <key>LSMinimumSystemVersion</key>
  <string>10.13</string>
  <key>NSHighResolutionCapable</key>
  <true/>
  <key>LSUIElement</key>
  <false/>
</dict>
</plist>
EOF

# The launcher inside the .app: just calls our shell script with the right
# working directory. Using $0's location lets us find the script even when
# the .app has been moved (as long as the .sh stays next to the .app).
cat > "$APP_DIR/Contents/MacOS/launcher" <<'EOF'
#!/bin/bash
# This sits inside the .app bundle at .app/Contents/MacOS/launcher.
# We need to find the folder containing the .app itself (i.e. the
# folder containing launch-baton-de-pluies.sh).
#
# Path layout:
#   /path/to/project/Bâton de pluies.app/Contents/MacOS/launcher  <- $0
#   /path/to/project/launch-baton-de-pluies.sh                    <- target
#
# So from $0 we go up: launcher -> MacOS -> Contents -> .app, then
# the .app's parent folder is the project folder.
SELF_DIR="$(cd "$(dirname "$0")" && pwd)"
APP_PATH="${SELF_DIR%/Contents/MacOS}"
PARENT="$(dirname "$APP_PATH")"
exec "$PARENT/launch-baton-de-pluies.sh"
EOF
chmod +x "$APP_DIR/Contents/MacOS/launcher"

echo ""
echo "✓ Done."
echo ""
echo "Created: $APP_DIR"
echo ""
echo "To use it:"
echo "  • Double-click \"$APP_NAME.app\" to launch."
echo "  • Optionally drag it to /Applications, your Dock, or alias to Desktop."
echo "  • IMPORTANT: keep the .app in the same folder as the .sh and .html files."
echo "    If you want to move it elsewhere, move the whole folder together."
echo ""
echo "First launch: macOS may ask 'are you sure you want to open this app?'"
echo "Click Open. After that, it'll launch silently like any other app."
