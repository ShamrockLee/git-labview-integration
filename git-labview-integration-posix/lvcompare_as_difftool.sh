#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$0")"

source "$SCRIPT_DIR/common_header.sh"

CONFIGURATION_PATH_GIVEN="$1"

source "$SCRIPT_DIR/config_process_header.sh"

echo "Left: $2" >&2
echo "Right: $3" >&2

LEFT_FIXED="$(fix_path_configured "$2")"
RIGHT_FIXED="$(fix_path_configured "$3")"

echo "Left fixed: $LEFT_FIXED" >&2
echo "Right fixed: $RIGHT_FIXED" >&2

"$LVCOMPARE_EXECUTABLE" "$LEFT_FIXED" "$RIGHT_FIXED" "-lvpath" "$LABVIEW_EXECUTABLE" "-nobdcosm" "-nobdpos" "-nofppos"
