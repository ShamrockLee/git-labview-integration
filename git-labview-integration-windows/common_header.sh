set -eu -o pipefail

function windowsize_posix_path {
		if [[ "$1" =~ ^/[A-Za-z](/.*)?$ ]]; then
			local diskRegister
			diskRegister="$(echo "${1:1:1}" | tr '[:lower:]' '[:upper:]')"
			local tailPath
			# shellcheck disable=SC1003
			tailPath="$(echo "${1:2}" | tr '/' '\\')"
			if [[ -n "$tailPath" ]]; then
				if [[ "${tailPath:${#tailPath}-1:1}" == "\\" ]]; then
					tailPath="${tailPath:0:${#tailPath}-1}"
				fi
			else
				tailPath="\\"
			fi
			echo "${diskRegister}:${tailPath}"
		fi
}

function posixize_windows_path {
		if [[ "$1" =~ ^[A-Za-z]\: ]]; then
			local diskRegister
			diskRegister="$(echo "${1:0:1}" | tr '[:upper:]' '[:lower:]')"
			local tailPath
			# shellcheck disable=SC1003
			tailPath="$(echo "${1:2}" | tr '\\' '/')"
			if [[ -n "$tailPath" && "${tailPath:${#tailPath}-1:1}" == "/" ]]; then
				tailPath="${tailPath:0:${#tailPath}-1}"
			fi
			echo "/${diskRegister}${tailPath}"
		fi
}

function absolutize_windows_path {
	local ORIG="$1"
	local PWD_GIVEN=""
	if (( "$#" > 2 )); then
		PWD_GIVEN="$2"
	else
		PWD_GIVEN="$PWD"
	fi
	local MODIFIED="$ORIG"
	if [[ "$ORIG" =~ ^[A-Za-z]\:\\+$ ]]; then
		if (( "${#ORIG}" == 2 )); then
			MODIFIED="${MODIFIED}\\"
		fi
		echo "$MODIFIED"
		return 0
	fi
	if [[ ! "$ORIG" =~ ^[A-Za-z]\:\\ ]]; then
		MODIFIED="$PWD_GIVEN\\$MODIFIED"
	fi
	if [[ "${MODIFIED:${#MODIFIED}-1:1}" == "\\" ]]; then
		MODIFIED="${MODIFIED:0:${#MODIFIED}-1}"
	fi
	echo "$MODIFIED"
}

function fix_tool_input_path {
	local PATH_TO_FIX="$1"
	local PROJECT_ROOT_WINDOWS="$2"
	absolutize_windows_path "$(windowsize_posix_path "$PATH_TO_FIX")" "$PROJECT_ROOT_WINDOWS"
}
