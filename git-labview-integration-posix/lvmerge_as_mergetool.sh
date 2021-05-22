#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$0")"

source "$SCRIPT_DIR/common_header.sh"

CONFIGURATION_PATH_GIVEN="$1"

source "$SCRIPT_DIR/config_process_header.sh"

BASE_FIXED="$(fix_path_configured "$2")"
REMOTE_FIXED="$(fix_path_configured "$4")"
LOCAL_FIXED="$(fix_path_configured $3)"
MERGED_FIXED="$(fix_path_configured $5)"

"$LVMERGE_EXECUTABLE" "$LABVIEW_EXECUTABLE" "$BASE_FIXED" "$REMOTE_FIXED" "$LOCAL_FIXED" "$MERGED_FIXED"
