#!/bin/bash

cd "$(dirname "$0")" || exit 1

source ./const.sh

yaml_diff="$(diff -u "$SPECFILE_BK" "$SPECFILE")"
if [ -z "$yaml_diff" ]; then
  echo "Diff doesn't exists."
  exit 1
fi

patch_file=./patches/"$(date +%Y_%m%d_%H%M)".patch
echo "$yaml_diff" > "$patch_file"

echo "New patch file is created. -> $patch_file"
