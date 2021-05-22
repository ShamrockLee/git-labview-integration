set -eu

function windowsize_posix_path {
        echo $1 | sed -r 's/^(["'"'"']*)\/([A-Za-z])/\1\U\2:/' | sed 's/\//\\/g'
}

function posixize_windows_path {
        echo $1 | sed -r 's/^(["'"'"']*)([A-Za-z]):/\1\/\L\2/' | sed 's/\\/\//g'
}

function absolutize_headless_relative_windows_path {
	local ORIG="$1"
	local PWD_GIVEN=""
	if test "$#" -ge 2; then
		PWD_GIVEN="$2"
	else
		PWD_GIVEN="$PWD"
	fi
	if test -n "$(echo "$ORIG" | grep -e '^["'"'"']*[A-Za-z]:')"; then
		echo "$ORIG"
	else
		echo "$PWD_GIVEN\\$ORIG"
	fi
}

function fix_tool_input_path {
	local PATH_TO_FIX="$1"
	local PROJECT_ROOT_WINDOWS="${2}"
	absolutize_headless_relative_windows_path "$(windowsize_posix_path "$PATH_TO_FIX")" "$PROJECT_ROOT_WINDOWS"
}
