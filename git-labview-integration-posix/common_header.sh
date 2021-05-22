set -eu

function absolutize_headless_relative_posix_path {
	local ORIG="$1"
	local PWD_GIVEN=""
	if test "$#" -ge 2; then
		PWD_GIVEN="$2"
	else
		PWD_GIVEN="$PWD"
	fi
	if test -n "$(echo "$ORIG" | grep -e '^["'"'"']*/+')"; then
		echo "$ORIG"
	elif test -n "$(echo "$ORIG" | grep -e '^\s*["'"'"']*\.["'"'"']*\s*$')"; then
		echo "$PWD_GIVEN"
	else
		echo "$PWD_GIVEN/$ORIG"
	fi
}

function fix_tool_input_path {
	local PATH_TO_FIX="$1"
	local PROJECT_ROOT_POSIX="$2"
	absolutize_headless_relative_posix_path "$PATH_TO_FIX" "$PROJECT_ROOT_POSIX"
}
