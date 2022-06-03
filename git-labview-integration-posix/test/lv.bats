#!/usr/bin/env bats

setup_file() {
	PROJECT_ROOT="$(cd "$BATS_TEST_DIRNAME/../.."; pwd)"
}

@test "Check lvcompare_as_difftool.sh" {
	run --separate-stderr bash "$PROJECT_ROOT/git-labview-integration-posix/lvcompare_as_difftool.sh" "$PROJECT_ROOT/git-labview-integration-posix/test/labview_path_posix.config" "remote.lv" "local.lv"
	outputExpected="$("$PROJECT_ROOT/git-labview-integration-posix/test/pseudo-lv" "$PROJECT_ROOT/remote.lv" "$PROJECT_ROOT/local.lv" "-lvpath" "pseudo-labview" "-nobdcosm" "-nobdpos" "-nofppos")"
	diff <(echo "$output") <(echo "$outputExpected")
	[ "$output" == "$outputExpected" ]
}

@test "Check lvmerge_as_mergetool.sh" {
	run --separate-stderr bash "$PROJECT_ROOT/git-labview-integration-posix/lvmerge_as_mergetool.sh" "$PROJECT_ROOT/git-labview-integration-posix/test/labview_path_posix.config" "base.lv" "remote.lv" "local.lv" "merged.lv"
	outputExpected="$("$PROJECT_ROOT/git-labview-integration-posix/test/pseudo-lv" "pseudo-labview" "$PROJECT_ROOT/base.lv" "$PROJECT_ROOT/remote.lv" "$PROJECT_ROOT/local.lv" "$PROJECT_ROOT/merged.lv")"
	diff <(echo "$output") <(echo "$outputExpected")
	[ "$output" == "$outputExpected" ]
}
