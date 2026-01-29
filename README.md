# 🎧 Linux Audio Output Switcher & Smart Resume

A robust Bash script for Linux users (PulseAudio/PipeWire) to toggle between **Headphones** and **Speakers** with a single shortcut.

Unlike simple togglers, this script intelligently manages your audio streams and playback status.

## 🚀 Features

- **Profile Toggling:** Instantly switches between defined audio card profiles (e.g., Headset vs. Surround Speaker).
- **Stream Moving:** Automatically moves all active audio streams (Spotify, Chrome, Zoom, etc.) to the new output device instantly.
- **Smart Resume:** If media was playing before the switch, the script automatically resumes playback (fixing the annoyance where switching outputs pauses the music).
- **Visual Feedback:** Sends a desktop notification indicating the active output source.

---

## 📦 Dependencies

Ensure you have the following packages installed on your system.

**For Fedora / RHEL:**
```bash
sudo dnf install pulseaudio-utils playerctl libnotify
```

**For Ubuntu / Debian:**

```bash
sudo apt install pulseaudio-utils playerctl libnotify-bin
```

## ⚙️  Configuration (Important) 
Because every computer's hardware ID is different, you must configure the script once before using it.

   1. Open audio-toggle.sh in a text editor.

   2. Run the following command in your terminal to find your Card Name:
	```bash
	pactl list cards | grep "Name:"
	```
   3. Update the CARD variable in the script with your card name.		
	
   4. Update PROFILE_SPEAKER and PROFILE_HEADPHONES variables with your specific profile names (found via pactl list cards).

## 💿 Usage

Installation

Clone the repository:
```bash
git clone [https://github.com/Futhark1393/linux-audio-switcher-and-smart-resume.git](https://github.com/Futhark1393/linux-audio-switcher-and-smart-resume.git)
cd linux-audio-switcher-and-smart-resume
```

Make the script executable:
```bash
chmod +x audio-toggle.sh
```

Testing
Run the script manually:
```bash
./audio-toggle.sh
```

Bind to a Shortcut (GNOME Example)

  1.  Go to Settings -> Keyboard -> View and Customize Shortcuts -> Custom Shortcuts.

  2.  Click Add Shortcut.

  3.  Fill in the details:

        Name: Audio Switcher

        Command: /home/YOUR_USER/path/to/linux-audio-switcher-and-smart-resume/audio-toggle.sh

        Shortcut: Choose your preferred keys (e.g., Super+A).

🤝 Contributing

Feel free to submit issues or pull requests if you have ideas to improve the script!
