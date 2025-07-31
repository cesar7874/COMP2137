#!/bin/bash



trap '' TERM HUP INT



verbose=false

desiredName=""

desiredIP=""

hostEntryName=""

hostEntryIP=""



log() {

    logger "$1"

    $verbose && echo "$1"

}



while [[ $# -gt 0 ]]; do

    case "$1" in

        -verbose)

            verbose=true

            ;;

        -name)

            shift

            desiredName="$1"

            ;;

        -ip)

            shift

            desiredIP="$1"

            ;;

        -hostentry)

            shift

            hostEntryName="$1"

            shift

            hostEntryIP="$1"

            ;;

    esac

    shift

done



# Handle hostname

if [[ -n "$desiredName" ]]; then

    currentName=$(hostname)

    if [[ "$currentName" != "$desiredName" ]]; then

        echo "$desiredName" > /etc/hostname

        hostname "$desiredName"

        sed -i "s/127.0.1.1.*/127.0.1.1\t$desiredName/" /etc/hosts

        log "Hostname updated to $desiredName"

    else

        $verbose && echo "Hostname already set to $desiredName"

    fi

fi



