#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$0")"

source "$SCRIPT_DIR/common_header.sh"

CONFIGURATION_PATH_GIVEN="$1"

source "$SCRIPT_DIR/config_process_header.sh"

echo "BASE: \"$2\"" >&2
echo "REMOTE: \"$4\"" >&2
echo "LOCAL: \"$3\"" >&2
echo "MERGED: \"$5\"" >&2

BASE_FIXED="$(fix_path_configured "$2")"
REMOTE_FIXED="$(fix_path_configured "$4")"
LOCAL_FIXED="$(fix_path_configured "$3")"
MERGED_FIXED="$(fix_path_configured "$5")"

echo "BASE_FIXED: \"$BASE_FIXED\"" >&2
echo "REMOTE_FIXED: \"$REMOTE_FIXED\"" >&2
echo "LOCAL_FIXED: \"$LOCAL_FIXED\"" >&2
echo "MERGED_FIXED: \"$MERGED_FIXED\"" >&2

"$LVMERGE_EXECUTABLE" "$LABVIEW_EXECUTABLE" "$BASE_FIXED" "$REMOTE_FIXED" "$LOCAL_FIXED" "$MERGED_FIXED"
