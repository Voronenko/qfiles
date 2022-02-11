#!/bin/bash

_remove_app() {
    [[ $# -lt 2 ]] && {
        echo "Usage: ${FUNCNAME} <timeout_secs> <application>"; return 1
    }

    # Increase this value to decrease the freqeuncy of checks for the
    # existence of the uninstall script. A freq of '5' would mean
    # there are 12 checks per minute. freq=10 would be 6 checks per
    # minute.
    freq=10

    timeout=$(($(date +%s) + ${1}))
    until [[ $(date +%s) -gt $timeout ]]; do
        [[ -f /share/CACHEDEV1_DATA/.qpkg/$2/.uninstall.sh ]] && { \
            echo $(date)": Attempting ${2} uninstall script (uninstall.sh)..."
            /share/CACHEDEV1_DATA/.qpkg/$2/.uninstall.sh
            sleep 2

            echo $(date)": Removing ${2} from Application Center (rmcfg)..."
            /sbin/rmcfg ${2} -f /etc/config/qpkg.conf
            sleep 2

            # optional? Not sure???
            echo $(date)": Attempting CLI PKG MGMT (qpkg_cli) uninstall of ${2}..."
            qpkg_cli --stop $2
            qpkg_cli --disable $2
            qpkg_cli --remove $2
            qpkg_cli -C $2
            sleep 2

            echo $(date)": Attempts to uninstall ${2} completed..."
            return 0
        }
        sleep $freq
    done
    echo $(date)": Timeout reached without attempting uninstall of ${2}."
    return 2
}

#_remove_app 200 MultimediaConsole
_remove_app $1 $2
