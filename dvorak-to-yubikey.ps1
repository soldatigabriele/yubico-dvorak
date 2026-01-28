<#
.SYNOPSIS
    Converts a desired password string to what you need to program into YubiKey
    when using a Dvorak keyboard layout.

.DESCRIPTION
    When you type on a Dvorak keyboard, but the YubiKey sends QWERTY scancodes,
    this script calculates what to program into YubiKey so it outputs your desired password.

.PARAMETER Password
    The desired password you want YubiKey to output.

.PARAMETER Show
    Show output on screen instead of copying to clipboard.

.EXAMPLE
    .\dvorak-to-yubikey.ps1 "your-desired-password"
    
.EXAMPLE
    .\dvorak-to-yubikey.ps1 -Show "your-desired-password"
#>

param(
    [Parameter(Position=0)]
    [string]$Password,
    
    [Alias("s")]
    [switch]$Show
)

if (-not $Password) {
    Write-Host "Usage: .\dvorak-to-yubikey.ps1 [-Show] <desired-password>"
    Write-Host "Converts password for YubiKey programming with Dvorak layout"
    Write-Host "  -Show, -s  Show output on screen (default: copy to clipboard)"
    exit 1
}

# QWERTY -> Dvorak mapping:
# QWERTY keys:   qwertyuiop[]asdfghjkl;'zxcvbnm,./
# Dvorak output: ',.pyfgcrl/=aoeuidhtns-;qjkxbmwvz
#
# REVERSE for our needs (Dvorak desired -> QWERTY to program):

# Lowercase: dvorak chars -> qwerty chars to type
$dvorakLower = "',.pyfgcrl/=aoeuidhtns-;qjkxbmwvz"
$qwertyLower = "qwertyuiop[]asdfghjkl;'zxcvbnm,./"

# Uppercase (shifted versions)
$dvorakUpper = '"<>PYFGCRL?+AOEUIDHTNS_:QJKXBMWVZ'
$qwertyUpper = 'QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>?'

# Build translation table
$translationTable = @{}
for ($i = 0; $i -lt $dvorakLower.Length; $i++) {
    $translationTable[$dvorakLower[$i]] = $qwertyLower[$i]
}
for ($i = 0; $i -lt $dvorakUpper.Length; $i++) {
    $translationTable[$dvorakUpper[$i]] = $qwertyUpper[$i]
}

# Translate the password
$result = -join ($Password.ToCharArray() | ForEach-Object {
    if ($translationTable.ContainsKey($_)) {
        $translationTable[$_]
    } else {
        $_
    }
})

if ($Show) {
    Write-Host "Desired output: $Password"
    Write-Host "Program into YubiKey: $result"
} else {
    Set-Clipboard -Value $result
    Write-Host "Copied to clipboard ($($result.Length) chars)"
}
