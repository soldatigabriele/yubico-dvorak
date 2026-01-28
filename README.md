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

### macOS/Linux

```bash
# Copy converted password to clipboard (default, more secure)
./dvorak-to-yubikey.sh "MySecretPassword123"
# Output: Copied to clipboard (21 chars)

# Show on screen instead
./dvorak-to-yubikey.sh -s "MySecretPassword123"
# Output:
#   Desired output: MySecretPassword123
#   Program into YubiKey: Mt:diodkRa;;,soh123

# Help
./dvorak-to-yubikey.sh -h
```

### Windows (PowerShell)

```powershell
# Copy converted password to clipboard (default, more secure)
.\dvorak-to-yubikey.ps1 "MySecretPassword123"
# Output: Copied to clipboard (21 chars)

# Show on screen instead
.\dvorak-to-yubikey.ps1 -Show "MySecretPassword123"
# Output:
#   Desired output: MySecretPassword123
#   Program into YubiKey: Mt:diodkRa;;,soh123

# Help
Get-Help .\dvorak-to-yubikey.ps1
```

## Installation

### macOS/Linux

```bash
# Download and make executable
chmod +x dvorak-to-yubikey.sh

# Optionally, move to your PATH
mv dvorak-to-yubikey.sh /usr/local/bin/dvorak-to-yubikey
```

### Windows

```powershell
# If script execution is disabled, you may need to allow it:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## Requirements

### macOS/Linux
- Bash
- macOS (uses `pbcopy` for clipboard). For Linux, replace `pbcopy` with `xclip -selection clipboard`

### Windows
- PowerShell 5.1+ (included in Windows 10/11)

## Security

- The script contains no secrets - just standard keyboard layout mappings
- By default, output goes to clipboard to avoid showing passwords on screen
- Tip: prefix command with a space to avoid shell history: ` ./dvorak-to-yubikey.sh "password"`

## License

MIT
