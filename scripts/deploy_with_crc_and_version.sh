#!/bin/bash - 
#===============================================================================
#
#          FILE: deploy_with_crc_and_version.sh
# 
#         USAGE: ./deploy_with_crc_and_version.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Andrea Bigagli, 
#  ORGANIZATION: 
#       CREATED: 09/02/2024 15:35
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
DEPLOY_FOLDER=$1
ORIGIN_FILE=$2
IMAGE_BASENAME=$3
VERSION_FILE=$4
CHECKSUM=$(gzip -c "$ORIGIN_FILE" | tail -c 8 | hexdump -n 4 -e '"%08x"')

mkdir -p "$DEPLOY_FOLDER"

next_minor=$(cut -d ';' -f 2 "$VERSION_FILE")
deployed_minor=$((next_minor - 1))

version_formatted=$(printf "%05d" "$deployed_minor")
filesize=$(wc -c "$ORIGIN_FILE" | awk '{print $1}')
filesize_formatted=$(printf "%06d" "$filesize")

destination_filename=${IMAGE_BASENAME}_${version_formatted}_${CHECKSUM}_${filesize_formatted}.bin

echo "Deploying $ORIGIN_FILE to ${DEPLOY_FOLDER}/${destination_filename}"

cp -p "$ORIGIN_FILE" "$DEPLOY_FOLDER/$destination_filename"
