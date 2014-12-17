#!/bin/sh -e

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "Has to provide location of lock file to create"
LCK_FILE=$1

if [ -n "${http_proxy+1}" ]; then
  echo "export http_proxy='$http_proxy'" >> bin/profile.d/proxy.sh
  echo "export HTTP_PROXY='$http_proxy'" >> bin/profile.d/proxy.sh
fi
if [ -n "${https_proxy+1}" ]; then
  echo "export https_proxy='$https_proxy'" >> bin/profile.d/proxy.sh
  echo "export HTTPS_PROXY='$https_proxy'" >> bin/profile.d/proxy.sh
fi
if [ -n "${ftp_proxy+1}" ]; then
  echo "export ftp_proxy='$ftp_proxy'" >> bin/profile.d/proxy.sh
  echo "export FTP_PROXY='$ftp_proxy'" >> bin/profile.d/proxy.sh
fi
if [ -n "${no_proxy+1}" ]; then
  echo "export no_proxy='$no_proxy'" >> bin/profile.d/proxy.sh
  echo "export NO_PROXY='$no_proxy'" >> bin/profile.d/proxy.sh
fi

echo "Creating vagrant lock file ${LCK_FILE}"
touch ${LCK_FILE}

echo "Starting VM"
vagrant up



