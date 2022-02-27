#!/bin/bash

cd "$(dirname "$0")" || exit 1

source ./const.sh

yaml_diff="$(diff -u "$SPECFILE_LOCAL" "$SPECFILE_INDEX")"
if [ -z "$yaml_diff" ]; then
  echo "Diff doesn't exists."
  exit 1
fi

echo "$yaml_diff"
read -p "The diff is shown above. ok? (y/N): " yn
case "$yn" in [yY]*) ;; *) echo "abort." ; exit ;; esac

patch_file=./patches/"$(date +%Y_%m%d_%H%M)".patch
echo "$yaml_diff" > "$patch_file"

echo "New patch file is created. -> $patch_file"

patch "$SPECFILE_LOCAL" <"$patch_file"