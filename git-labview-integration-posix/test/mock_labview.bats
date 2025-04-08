#!/usr/bin/env bats

setup_file() {
	PROJECT_ROOT="$(cd "$BATS_TEST_DIRNAME/../.."; pwd)"
	export PROJECT_ROOT
}

@test "Check lvcompare_as_difftool.sh" {
	bats_require_minimum_version 1.5.0
	run --separate-stderr bash "$PROJECT_ROOT/git-labview-integration-posix/lvcompare_as_difftool.sh" "$PROJECT_ROOT/git-labview-integration-posix/test/labview_path_posix.config" "remote.lv" "local.lv"
	outputExpected="$("$PROJECT_ROOT/git-labview-integration-posix/test/mock-labview" "$PROJECT_ROOT/remote.lv" "$PROJECT_ROOT/local.lv" "-lvpath" "pseudo-labview" "-nobdcosm" "-nobdpos" "-nofppos")"
	diff <(echo "$output") <(echo "$outputExpected")
	[ "$output" == "$outputExpected" ]
}

@test "Check lvmerge_as_mergetool.sh" {
	bats_require_minimum_version 1.5.0
	run --separate-stderr bash "$PROJECT_ROOT/git-labview-integration-posix/lvmerge_as_mergetool.sh" "$PROJECT_ROOT/git-labview-integration-posix/test/labview_path_posix.config" "base.lv" "remote.lv" "local.lv" "merged.lv"
	outputExpected="$("$PROJECT_ROOT/git-labview-integration-posix/test/mock-labview" "pseudo-labview" "$PROJECT_ROOT/base.lv" "$PROJECT_ROOT/remote.lv" "$PROJECT_ROOT/local.lv" "$PROJECT_ROOT/merged.lv")"
	diff <(echo "$output") <(echo "$outputExpected")
	[ "$output" == "$outputExpected" ]
}
