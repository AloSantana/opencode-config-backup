# Android Remote Access Setup Guide

**Last Updated:** 2026-03-13

Complete guide for setting up Android device remote access, screen mirroring, and wireless debugging.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Installation](#installation)
3. [USB Connection Setup](#usb-connection-setup)
4. [Wireless ADB Setup](#wireless-adb-setup)
5. [Screen Mirroring with scrcpy](#screen-mirroring-with-scrcpy)
6. [Common Commands](#common-commands)
7. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Android Device Requirements

- Android 5.0 (Lollipop) or higher
- USB debugging enabled
- Developer options unlocked

### Enable Developer Options

1. Go to **Settings** → **About Phone**
2. Tap **Build Number** 7 times
3. Go back to **Settings** → **Developer Options**
4. Enable **USB Debugging**
5. (Optional) Enable **Wireless Debugging** for Android 11+

---

## Installation

### Automated Installation

```bash
cd /path/to/opencode-config-backup
./install/install-android.sh
```

### Manual Installation

#### Install ADB

```bash
sudo apt update
sudo apt install -y android-tools-adb android-tools-fastboot
```

#### Install scrcpy (Screen Mirroring)

```bash
sudo apt install -y scrcpy
```

#### Install Android Platform Tools

```bash
wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip
unzip platform-tools-latest-linux.zip -d ~/
echo 'export PATH="$PATH:$HOME/platform-tools"' >> ~/.bashrc
source ~/.bashrc
```

---

## USB Connection Setup

### 1. Connect Device

```bash
# Connect Android device via USB
adb devices
```

Expected output:
```
List of devices attached
ABC123XYZ    device
```

### 2. Authorize Computer

- On first connection, your Android device will show a prompt
- Check "Always allow from this computer"
- Tap "Allow"

### 3. Verify Connection

```bash
adb devices -l
```

---

## Wireless ADB Setup

### Method 1: Android 11+ (Native Wireless Debugging)

#### On Android Device:
1. Go to **Developer Options**
2. Enable **Wireless Debugging**
3. Tap **Wireless Debugging** → **Pair device with pairing code**
4. Note the IP address and pairing code

#### On Computer:
```bash
# Pair device (one-time setup)
adb pair <ip>:<port>
# Enter pairing code when prompted

# Connect to device
adb connect <ip>:5555

# Verify connection
adb devices
```

### Method 2: Android 5-10 (USB Required First)

#### Using the Helper Script:
```bash
# Connect via USB first
adb devices

# Run wireless connection script
~/android-wireless-connect.sh <device-ip>

# Example:
~/android-wireless-connect.sh 192.168.1.100
```

#### Manual Method:
```bash
# Connect via USB first
adb devices

# Enable TCP/IP mode
adb tcpip 5555

# Find device IP (on Android: Settings → About → Status → IP address)
# Or use: adb shell ip addr show wlan0

# Connect wirelessly
adb connect <device-ip>:5555

# Disconnect USB cable
# Verify wireless connection
adb devices
```

### Find Device IP Address

```bash
# Method 1: Via ADB (USB connected)
adb shell ip addr show wlan0 | grep inet

# Method 2: On Android device
# Settings → About Phone → Status → IP Address
```

---

## Screen Mirroring with scrcpy

### Basic Usage

```bash
# Mirror screen (default quality)
scrcpy

# High quality, lower latency
scrcpy --bit-rate=8M --max-fps=60

# Specific device (if multiple connected)
scrcpy --serial=ABC123XYZ

# Wireless mirroring
scrcpy --tcpip=<device-ip>:5555
```

### Advanced Options

```bash
# Fullscreen mode
scrcpy --fullscreen

# Window size
scrcpy --window-width=800 --window-height=600

# Disable device control (view only)
scrcpy --no-control

# Turn off device screen while mirroring
scrcpy --turn-screen-off

# Stay awake while charging
scrcpy --stay-awake

# Record screen
scrcpy --record=recording.mp4

# Crop screen (remove black bars)
scrcpy --crop=1224:1440:0:0
```

### Keyboard Shortcuts (while scrcpy is running)

| Shortcut | Action |
|----------|--------|
| `Ctrl+f` | Toggle fullscreen |
| `Ctrl+g` | Resize window to 1:1 |
| `Ctrl+x` | Resize window to remove black borders |
| `Ctrl+h` | Click on HOME |
| `Ctrl+b` | Click on BACK |
| `Ctrl+s` | Click on APP_SWITCH |
| `Ctrl+m` | Click on MENU |
| `Ctrl+↑` | Volume up |
| `Ctrl+↓` | Volume down |
| `Ctrl+p` | Power button |
| `Ctrl+o` | Turn device screen off |
| `Ctrl+Shift+o` | Turn device screen on |
| `Ctrl+r` | Rotate screen |
| `Ctrl+n` | Expand notification panel |
| `Ctrl+Shift+n` | Collapse notification panel |
| `Ctrl+c` | Copy device clipboard to computer |
| `Ctrl+v` | Paste computer clipboard to device |

---

## Common Commands

### Device Management

```bash
# List connected devices
adb devices
adb devices -l  # Detailed list

# Get device info
adb shell getprop ro.product.model
adb shell getprop ro.build.version.release

# Reboot device
adb reboot
adb reboot bootloader
adb reboot recovery
```

### File Transfer

```bash
# Push file to device
adb push local-file.txt /sdcard/

# Pull file from device
adb pull /sdcard/file.txt ./

# Push entire directory
adb push ./folder /sdcard/folder
```

### App Management

```bash
# Install APK
adb install app.apk
adb install -r app.apk  # Reinstall keeping data

# Uninstall app
adb uninstall com.example.app

# List installed packages
adb shell pm list packages
adb shell pm list packages -3  # Third-party only

# Clear app data
adb shell pm clear com.example.app

# Launch app
adb shell am start -n com.example.app/.MainActivity
```

### Screenshots & Recording

```bash
# Take screenshot
adb exec-out screencap -p > screenshot.png

# Record screen (Ctrl+C to stop)
adb shell screenrecord /sdcard/recording.mp4

# Pull recording
adb pull /sdcard/recording.mp4
```

### Logs & Debugging

```bash
# View logcat
adb logcat

# Filter by tag
adb logcat -s TAG_NAME

# Clear logcat
adb logcat -c

# Save logcat to file
adb logcat > logcat.txt
```

### Shell Access

```bash
# Open shell
adb shell

# Run single command
adb shell ls /sdcard/

# Run as root (if device is rooted)
adb root
adb shell
```

---

## Troubleshooting

### Device Not Detected

```bash
# Restart ADB server
adb kill-server
adb start-server

# Check USB connection
lsusb

# Verify udev rules (Linux)
sudo nano /etc/udev/rules.d/51-android.rules
# Add: SUBSYSTEM=="usb", ATTR{idVendor}=="<vendor-id>", MODE="0666", GROUP="plugdev"
sudo udevadm control --reload-rules
```

### Unauthorized Device

1. Revoke USB debugging authorizations on Android
2. Disconnect and reconnect USB
3. Accept authorization prompt again

### Wireless Connection Drops

```bash
# Reconnect
adb connect <device-ip>:5555

# If fails, restart from USB:
adb usb
adb tcpip 5555
adb connect <device-ip>:5555
```

### scrcpy Issues

```bash
# Update scrcpy
sudo apt update
sudo apt install --only-upgrade scrcpy

# Check device compatibility
scrcpy --version
adb shell dumpsys display | grep mCurrentDisplayDevice

# Lower quality for better performance
scrcpy --bit-rate=2M --max-size=1024
```

### Permission Denied Errors

```bash
# Add user to plugdev group
sudo usermod -aG plugdev $USER

# Logout and login again
```

---

## Aliases Reference

After installation, these aliases are available:

```bash
adb-devices      # List all connected devices
adb-connect      # Connect wirelessly (helper script)
adb-screen       # Launch scrcpy screen mirror
adb-install      # Install APK with reinstall flag
adb-uninstall    # Uninstall app
adb-logcat       # View device logs
adb-shell        # Open device shell
adb-screenshot   # Take screenshot with timestamp
adb-record       # Record screen video
adb-pull         # Pull file from device
adb-push         # Push file to device
```

---

## Additional Resources

- [Official ADB Documentation](https://developer.android.com/studio/command-line/adb)
- [scrcpy GitHub](https://github.com/Genymobile/scrcpy)
- [Android Developer Options Guide](https://developer.android.com/studio/debug/dev-options)

---

**Generated:** 2026-03-13  
**Maintained by:** OpenCode Community
