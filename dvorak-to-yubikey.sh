#!/bin/bash
# Converts a desired password string to what you need to program into YubiKey
# when using a Dvorak keyboard layout.
#
# Usage: ./dvorak-to-yubikey.sh "your-desired-password"
#        ./dvorak-to-yubikey.sh -s "your-desired-password"  (show on screen)

show_output=false

while getopts "sh" opt; do
    case $opt in
        s) show_output=true ;;
        h) 
            echo "Usage: $0 [-s] <desired-password>"
            echo "  -s  Show output on screen (default: copy to clipboard)"
            exit 0
            ;;
        *) 
            echo "Usage: $0 [-s] <desired-password>"
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "$1" ]; then
    echo "Usage: $0 [-s] <desired-password>"
    echo "Converts password for YubiKey programming with Dvorak layout"
    echo "  -s  Show output on screen (default: copy to clipboard)"
    exit 1
fi

input="$1"

# QWERTY -> Dvorak mapping:
# QWERTY keys:  qwertyuiop[]asdfghjkl;'zxcvbnm,./
# Dvorak output: ',.pyfgcrl/=aoeuidhtns-;qjkxbmwvz
#
# REVERSE for our needs (Dvorak desired -> QWERTY to program):
# Use tr for the translation

# Lowercase: dvorak chars -> qwerty chars to type
dvorak_lower="',.pyfgcrl/=aoeuidhtns-;qjkxbmwvz"
qwerty_lower="qwertyuiop[]asdfghjkl;'zxcvbnm,./"

# Uppercase (shifted versions)
dvorak_upper='"<>PYFGCRL?+AOEUIDHTNS_:QJKXBMWVZ'
qwerty_upper='QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>?'

result=$(echo -n "$input" | tr "$dvorak_lower" "$qwerty_lower" | tr "$dvorak_upper" "$qwerty_upper")

if [ "$show_output" = true ]; then
    echo "Desired output: $input"
    echo "Program into YubiKey: $result"
else
    echo -n "$result" | pbcopy
    echo "Copied to clipboard (${#result} chars)"
fi
