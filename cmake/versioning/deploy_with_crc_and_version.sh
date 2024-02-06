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
#       CREATED: 03/01/2023 15:35
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
DEPLOY_FOLDER=$1
ORIGIN_FILE=$2
IMAGE_BASENAME=$3
VERSION_FILE=${DEPLOY_FOLDER}/version.txt
CHECKSUM=$(gzip -c "$ORIGIN_FILE" | tail -c 8 | hexdump -n 4 -e '"%08x"')

mkdir -p "$DEPLOY_FOLDER"

version=0
if [[ -r $VERSION_FILE ]]; then
	version=$(cat "$VERSION_FILE")
fi
version_formatted=$(printf "%05d" "$version")
filesize=$(wc -c "$ORIGIN_FILE" | awk '{print $1}')
filesize_formatted=$(printf "%06d" "$filesize")

destination_filename=${IMAGE_BASENAME}_${version_formatted}_${CHECKSUM}_${filesize_formatted}.bin
destination_filename1=GMAB1_${version_formatted}_${CHECKSUM}_${filesize_formatted}.bin
destination_filename2=GMAB2_${version_formatted}_${CHECKSUM}_${filesize_formatted}.bin

echo "Deploying $ORIGIN_FILE to ${DEPLOY_FOLDER}/${destination_filename}"

cp -p "$ORIGIN_FILE" "$DEPLOY_FOLDER/$destination_filename"
cp -p "$ORIGIN_FILE" "$DEPLOY_FOLDER/$destination_filename1"
cp -p "$ORIGIN_FILE" "$DEPLOY_FOLDER/$destination_filename2"

((version++))
echo "$version" > "$VERSION_FILE"
