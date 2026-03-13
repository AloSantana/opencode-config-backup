#!/bin/bash
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}Installing Android Remote Access Tools...${NC}"
echo ""

echo -e "${BLUE}ADB (Android Debug Bridge):${NC}"

if ! command -v adb &> /dev/null; then
    echo -e "${YELLOW}→ Installing ADB...${NC}"
    sudo apt update
    sudo apt install -y android-tools-adb android-tools-fastboot
    echo -e "${GREEN}✓ ADB installed${NC}"
else
    echo -e "${GREEN}✓ ADB already installed${NC}"
fi

echo ""
echo -e "${BLUE}scrcpy (Screen Mirroring):${NC}"

if ! command -v scrcpy &> /dev/null; then
    echo -e "${YELLOW}→ Installing scrcpy...${NC}"
    sudo apt update
    sudo apt install -y scrcpy
    echo -e "${GREEN}✓ scrcpy installed${NC}"
else
    echo -e "${GREEN}✓ scrcpy already installed${NC}"
fi

echo ""
echo -e "${BLUE}Android Studio Platform Tools:${NC}"

PLATFORM_TOOLS_DIR="$HOME/android-platform-tools"
if [ ! -d "$PLATFORM_TOOLS_DIR" ]; then
    echo -e "${YELLOW}→ Installing Android Platform Tools...${NC}"
    wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip
    unzip -q platform-tools-latest-linux.zip -d "$HOME"
    mv "$HOME/platform-tools" "$PLATFORM_TOOLS_DIR"
    rm platform-tools-latest-linux.zip
    echo -e "${GREEN}✓ Android Platform Tools installed${NC}"
    
    if ! grep -q "android-platform-tools" "$HOME/.bashrc"; then
        echo "export PATH=\"\$PATH:$PLATFORM_TOOLS_DIR\"" >> "$HOME/.bashrc"
        echo -e "${GREEN}✓ Added to PATH${NC}"
    fi
else
    echo -e "${GREEN}✓ Android Platform Tools already installed${NC}"
fi

echo ""
echo -e "${BLUE}Wireless ADB Setup:${NC}"

cat > "$HOME/android-wireless-connect.sh" << 'EOF'
#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <device-ip>"
    echo "Example: $0 192.168.1.100"
    exit 1
fi

DEVICE_IP=$1
ADB_PORT=5555

echo "Connecting to Android device at $DEVICE_IP..."

adb tcpip $ADB_PORT
sleep 2
adb connect $DEVICE_IP:$ADB_PORT

if adb devices | grep -q "$DEVICE_IP"; then
    echo "✓ Connected successfully!"
    echo "You can now disconnect USB cable"
    adb devices
else
    echo "✗ Connection failed"
    exit 1
fi
EOF

chmod +x "$HOME/android-wireless-connect.sh"
echo -e "${GREEN}✓ Created wireless connection script${NC}"

echo ""
echo -e "${BLUE}Vysor Alternative (Web-based):${NC}"

cat > "$HOME/android-web-control.sh" << 'EOF'
#!/bin/bash

echo "Starting ADB reverse proxy for web control..."
adb reverse tcp:8080 tcp:8080

echo "✓ Reverse proxy active"
echo "Access your Android device at: http://localhost:8080"
echo "Press Ctrl+C to stop"

python3 -m http.server 8080
EOF

chmod +x "$HOME/android-web-control.sh"
echo -e "${GREEN}✓ Created web control script${NC}"

echo ""
echo -e "${BLUE}Setting up ADB aliases...${NC}"

SHELL_RC="$HOME/.bashrc"
if [ -n "$ZSH_VERSION" ]; then
    SHELL_RC="$HOME/.zshrc"
fi

if ! grep -q "Android ADB aliases" "$SHELL_RC"; then
    cat >> "$SHELL_RC" << 'EOF'

# Android ADB aliases
alias adb-devices='adb devices -l'
alias adb-connect='~/android-wireless-connect.sh'
alias adb-screen='scrcpy'
alias adb-install='adb install -r'
alias adb-uninstall='adb uninstall'
alias adb-logcat='adb logcat'
alias adb-shell='adb shell'
alias adb-screenshot='adb exec-out screencap -p > screenshot-$(date +%Y%m%d-%H%M%S).png'
alias adb-record='adb shell screenrecord /sdcard/recording.mp4'
alias adb-pull='adb pull'
alias adb-push='adb push'
EOF
    echo -e "${GREEN}✓ ADB aliases configured${NC}"
else
    echo -e "${GREEN}✓ ADB aliases already configured${NC}"
fi

echo ""
echo -e "${GREEN}Android remote access tools installation complete!${NC}"
echo ""
echo -e "${YELLOW}Quick Start:${NC}"
echo "  1. Enable USB debugging on your Android device"
echo "  2. Connect via USB: adb devices"
echo "  3. Connect wirelessly: adb-connect <device-ip>"
echo "  4. Mirror screen: adb-screen (scrcpy)"
echo "  5. Take screenshot: adb-screenshot"
echo ""
echo -e "${YELLOW}Useful Commands:${NC}"
echo "  • List devices: adb-devices"
echo "  • Install APK: adb-install app.apk"
echo "  • View logs: adb-logcat"
echo "  • Shell access: adb-shell"
echo "  • Screen record: adb-record"
echo ""
echo -e "${BLUE}Documentation: See docs/ANDROID_REMOTE_ACCESS.md${NC}"
