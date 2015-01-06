#!/bin/sh -e

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "Has to provide location of lock file to remove"
LCK_FILE=$1

vagrant destroy --force

echo "Removing lock file ${LCK_FILE}"
rm ${LCK_FILE}
