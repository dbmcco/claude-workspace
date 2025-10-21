#!/bin/bash

# PAIA Daily Scanner Automation Setup
# Runs @paia analysis every 4 hours during working hours

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_WORKSPACE_DIR="$(dirname "$SCRIPT_DIR")"

echo "🤖 Setting up PAIA Daily Scanner Automation..."

# Create LaunchAgent directory if it doesn't exist
mkdir -p ~/Library/LaunchAgents

# Create the LaunchAgent plist for 4-hour PAIA scanning
cat > ~/Library/LaunchAgents/com.claude.paia.dailyscanner.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.claude.paia.dailyscanner</string>
    
    <key>Program</key>
    <string>/usr/local/bin/claude</string>
    
    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/bin/claude</string>
        <string>--non-interactive</string>
        <string>--task</string>
        <string>@paia-analyzer specifically scan today's daily note and upcoming daily notes for @paia instructions; @paia-updater execute all action briefs from daily notes scan</string>
    </array>
    
    <key>WorkingDirectory</key>
    <string>/Users/braydon/projects/claude-workspace</string>
    
    <key>StartCalendarInterval</key>
    <array>
        <dict>
            <key>Hour</key>
            <integer>8</integer>
            <key>Minute</key>
            <integer>0</integer>
        </dict>
        <dict>
            <key>Hour</key>
            <integer>12</integer>
            <key>Minute</key>
            <integer>0</integer>
        </dict>
        <dict>
            <key>Hour</key>
            <integer>16</integer>
            <key>Minute</key>
            <integer>0</integer>
        </dict>
        <dict>
            <key>Hour</key>
            <integer>20</integer>
            <key>Minute</key>
            <integer>0</integer>
        </dict>
    </array>
    
    <key>StandardOutPath</key>
    <string>/Users/braydon/Library/Logs/claude-paia-daily-scanner.log</string>
    
    <key>StandardErrorPath</key>
    <string>/Users/braydon/Library/Logs/claude-paia-daily-scanner-error.log</string>
    
    <key>RunAtLoad</key>
    <false/>
</dict>
</plist>
EOF

# Load the LaunchAgent
launchctl unload ~/Library/LaunchAgents/com.claude.paia.dailyscanner.plist 2>/dev/null || true
launchctl load ~/Library/LaunchAgents/com.claude.paia.dailyscanner.plist

echo "✅ PAIA Daily Scanner automation installed successfully!"
echo ""
echo "📅 Schedule: Every 4 hours during working hours"
echo "   • 08:00 AM - Morning task optimization"  
echo "   • 12:00 PM - Midday task redistribution"
echo "   • 04:00 PM - Afternoon task flow management"
echo "   • 08:00 PM - Evening task preparation"
echo ""
echo "📂 Working Directory: /Users/braydon/projects/claude-workspace"
echo "📄 Logs: ~/Library/Logs/claude-paia-daily-scanner.log"
echo ""
echo "🔧 Management Commands:"
echo "   launchctl unload ~/Library/LaunchAgents/com.claude.paia.dailyscanner.plist  # Disable"
echo "   launchctl load ~/Library/LaunchAgents/com.claude.paia.dailyscanner.plist    # Enable"
echo "   launchctl list | grep paia                                                   # Check status"
echo ""
echo "🚀 Your PAIA system will now automatically optimize daily tasks every 4 hours!"