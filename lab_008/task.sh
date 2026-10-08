#!/bin/bash

if [ "$#" -ne 3 ] && [ "$#" -ne 4 ]; then
    echo "Usage: bash task.sh output_file directory extension [HH:MM]" >&2
    exit 1
fi

if [ -z "$1" ]; then
    echo "Output filename must not be empty" >&2
    exit 1
fi

if [ -e "$1" ] && [ ! -f "$1" ]; then
    echo "Output path is not a regular file: $1" >&2
    exit 1
fi

if [ -f "$1" ] && [ ! -w "$1" ]; then
    echo "Cannot write to the output file: $1" >&2
    exit 1
fi

if [ ! -e "$1" ]; then
    if [ ! -d "$(dirname -- "$1")" ] || [ ! -w "$(dirname -- "$1")" ]; then
        echo "Output directory does not exist or is not writable" >&2
        exit 1
    fi
fi

if [ ! -d "$2" ]; then
    echo "Directory does not exist: $2" >&2
    exit 1
fi

if [ ! -r "$2" ] || [ ! -x "$2" ]; then
    echo "Cannot read the directory: $2" >&2
    exit 1
fi

case "$3" in
    ''|.*|*/*|*'*'*|*'?'*|*'['*|*']'*)
        echo "Use an extension without the leading dot or wildcard characters" >&2
        exit 1
        ;;
esac

if [ "$#" -eq 4 ]; then
    if [[ ! "$4" =~ ^([01][0-9]|2[0-3]):[0-5][0-9]$ ]]; then
        echo "Time must be HH:MM, from 00:00 to 23:59" >&2
        exit 1
    fi

    if ! command -v crontab > /dev/null; then
        echo "Install cron first: sudo apt install cron" >&2
        exit 1
    fi

    case "$PWD$1$2$3" in
        *[$'\t\r\n']*|*%*)
            echo "Scheduled paths and extension must not contain %, tabs or newlines" >&2
            exit 1
            ;;
    esac

    if [ ! -f ./task.sh ]; then
        echo "Run this command from the laboratory directory containing task.sh" >&2
        exit 1
    fi

    {
        crontab -l 2>/dev/null | grep -Fv "$(printf 'cd %q && /bin/bash ./task.sh ' "$PWD")"
        printf '%s %s * * * cd %q && ' "${4#*:}" "${4%:*}" "$PWD"
        printf '%q ' /bin/bash ./task.sh "$1" "$2" "$3"
        printf '>> cron.log 2>&1\n'
    } | crontab -

    if [ "$?" -ne 0 ]; then
        echo "Could not save the schedule" >&2
        exit 1
    fi

    echo "Scheduled daily at $4."
    crontab -l
    exit 0
fi

find "$(realpath -- "$2")" -maxdepth 1 -type f -name "*.$3" ! -samefile "$1" -printf '%f\n' > "$1"
