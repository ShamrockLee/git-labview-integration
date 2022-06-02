set -eu -o pipefail

function absolutize_posix_path {
	local ORIG="$1"
	local PWD_GIVEN=""
	if (( "$#" > 2 )); then
		PWD_GIVEN="$2"
	else
		PWD_GIVEN="$PWD"
	fi
	if [[ "${ORIG:0:1}" == "/" ]]; then
		echo "$ORIG"
	elif [[ "$ORIG" == "." ]]; then
		echo "$PWD_GIVEN"
	else
		echo "$PWD_GIVEN/$ORIG"
	fi
}

function fix_tool_input_path {
	local PATH_TO_FIX="$1"
	local PROJECT_ROOT_POSIX="$2"
	absolutize_posix_path "$PATH_TO_FIX" "$PROJECT_ROOT_POSIX"
}
