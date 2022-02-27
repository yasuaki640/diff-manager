#!/bin/bash

cd "$(dirname "$0")" || exit 1

source ./const.sh

if [ -z "$GH_ACCESS_TOKEN" ]; then
  echo 'GH Access Token does not exists.'
  exit 1
fi

curl -H "Authorization: token $GH_ACCESS_TOKEN" "$ORIGINAL_YAML_URL" -o "$SPECFILE_INDEX"

for diff_file in $(\find ./patches -maxdepth 1 -type f); do
  echo Applying "$diff_file"
  patch "$SPECFILE_INDEX" <"$diff_file"
done

# 新規差分抽出用に既存の差分のみ当たったファイルを残す
cp "$SPECFILE_INDEX" "$SPECFILE_LOCAL"
