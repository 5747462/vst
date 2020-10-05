#!/bin/bash

# Am I root?
if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi

# Check admin user account
if [ ! -z "$(grep ^admin: /etc/passwd)" ] && [ -z "$1" ]; then
    echo "Error: user admin exists"
    echo
    echo 'Please remove admin user before proceeding.'
    echo 'If you want to do it automatically run installer with -f option:'
    echo "Example: bash $0 --force"
    exit 1
fi

# Check admin group
if [ ! -z "$(grep ^admin: /etc/group)" ] && [ -z "$1" ]; then
    echo "Error: group admin exists"
    echo
    echo 'Please remove admin group before proceeding.'
    echo 'If you want to do it automatically run installer with -f option:'
    echo "Example: bash $0 --force"
    exit 1
fi

# Check wget
if [ -e '/usr/bin/wget' ]; then
    wget https://github.com/5747462/vst/vst-install-ubuntu.sh -O vst-install-ubuntu.sh
    if [ "$?" -eq '0' ]; then
        bash vst-install-ubuntu.sh $*
        exit
    else
        echo "Error: vst-install-ubuntu.sh download failed."
        exit 1
    fi
fi

# Check curl
if [ -e '/usr/bin/curl' ]; then
    curl -O https://github.com/5747462/vst/vst-install-ubuntu.sh
    if [ "$?" -eq '0' ]; then
        bash vst-install-ubuntu.sh $*
        exit
    else
        echo "Error: vst-install-ubuntu.sh download failed."
        exit 1
    fi
fi

exit
