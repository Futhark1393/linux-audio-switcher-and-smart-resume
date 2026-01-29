#!/bin/bash

# ==============================================================================
# Audio Output Toggler with Smart Resume
# Description: Toggles between Speaker and Headphone profiles on Linux (PulseAudio/PipeWire).
#              It also moves active streams to the new sink and resumes playback if it was playing.
# Dependencies: pulseaudio-utils (pactl), playerctl, libnotify
# ==============================================================================

# --- CONFIGURATION ---
# TODO: Run 'pactl list cards' to find your Card Name and Profile Names.
# Replace the variables below with your system's specific identifiers.

# Your Audio Card Name (e.g., alsa_card.pci-0000_00_1f.3)
CARD="alsa_card.pci-0000_65_00.6"

# Profile Names (These differ by hardware/driver)
PROFILE_SPEAKER="HiFi (Mic1, Speaker)"
PROFILE_HEADPHONES="HiFi (Headphones, Mic1)"

# 1. CHECK STATUS: Is media currently playing?
# returns "Playing", "Paused" or "Stopped"
PLAYBACK_STATUS=$(playerctl status 2>/dev/null)

# 2. DETECT CURRENT PROFILE AND TOGGLE
# We grep the active profile for the specific card
CURRENT_PROFILE=$(pactl list cards | grep -A 50 "Name: $CARD" | grep "Active Profile" | cut -d: -f2 | xargs)

if [[ "$CURRENT_PROFILE" == *"$PROFILE_HEADPHONES"* ]]; then
    # Switch to Speaker
    pactl set-card-profile "$CARD" "$PROFILE_SPEAKER"
    MSG="Output: Speaker"
    ICON="audio-speakers"
else
    # Switch to Headphones
    pactl set-card-profile "$CARD" "$PROFILE_HEADPHONES"
    MSG="Output: Headphones"
    ICON="audio-headphones"
fi

# 3. WAIT AND MOVE STREAMS
# Wait for the new sink to initialize
sleep 0.5
NEW_SINK=$(pactl get-default-sink)

# Move all currently playing audio streams to the new sink
pactl list short sink-inputs | awk '{print $1}' | while read input; do
    pactl move-sink-input "$input" "$NEW_SINK"
done

# 4. SMART RESUME
# If music was playing before the switch, resume it.
# (Switching profiles often pauses players automatically)
if [[ "$PLAYBACK_STATUS" == "Playing" ]]; then
    sleep 0.5
    playerctl play
fi

# 5. NOTIFICATION
notify-send -i "$ICON" "Audio Switcher" "$MSG"








