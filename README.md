# dvorak-to-yubikey

Convert passwords for YubiKey static password programming when using a Dvorak keyboard layout.

## The Problem

YubiKey sends USB HID keycodes as if typing on a QWERTY keyboard. When your system is set to Dvorak, these keycodes get interpreted incorrectly, resulting in garbled output.

For example, if you program `password` into YubiKey:
- Expected output: `password`
- Actual output with Dvorak: `ra;;,soh`

## The Solution

This script converts your desired password into what you need to program into the YubiKey, so that when Dvorak interprets the keystrokes, you get the correct output.

## Usage

```bash
# Copy converted password to clipboard (default, more secure)
./dvorak-to-yubikey.sh "MySecretPassword123"

# Show on screen instead
./dvorak-to-yubikey.sh -s "MySecretPassword123"

# Help
./dvorak-to-yubikey.sh -h
```

## Installation

```bash
# Download and make executable
chmod +x dvorak-to-yubikey.sh

# Optionally, move to your PATH
mv dvorak-to-yubikey.sh /usr/local/bin/dvorak-to-yubikey
```

## Requirements

- Bash
- macOS (uses `pbcopy` for clipboard). For Linux, replace `pbcopy` with `xclip -selection clipboard`

## Security

- The script contains no secrets - just standard keyboard layout mappings
- By default, output goes to clipboard to avoid showing passwords on screen
- Tip: prefix command with a space to avoid shell history: ` ./dvorak-to-yubikey.sh "password"`

## License

MIT
