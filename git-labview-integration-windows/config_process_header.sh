
## `CONFIGURATION_PATH_GIVEN` is needed before sourcing

PROJECT_ROOT_FORCED=""

if [[ -f "$CONFIGURATION_PATH_GIVEN" ]] || [[ -L "$CONFIGURATION_PATH_GIVEN" ]]; then
	source "$CONFIGURATION_PATH_GIVEN"
else
	echo "Configuration file ($CONFIGURATION_PATH_GIVEN) not found" >&2
	exit 1
fi

if [[ -z "$PROJECT_ROOT_FORCED" ]]; then
	PROJECT_ROOT_POSIX="$(
		cd "$(dirname "$CONFIGURATION_SOURCE")"
		if (( CONFIGURATION_DIRECTORY_LEVEL )); then
			for i in {1.."$CONFIGURATION_DIRECTORY_LEVEL"}; do
				cd ..
			done
		fi
		pwd
	)"
	PROJECT_ROOT_WINDOWS="$(windowsize_posix_path "$PROJECT_ROOT_POSIX")"
else
	PROJECT_ROOT_WINDOWS="$PROJECT_ROOT_FORCED"
fi

function fix_path_configured {
	fix_tool_input_path "$1" "$PROJECT_ROOT_WINDOWS"
}
