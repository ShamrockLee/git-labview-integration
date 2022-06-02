#!/usr/bin/env bats

setup() {
	. $(dirname "$BATS_TEST_FILENAME")/../common_header.sh
}

@test "Check windowsize_posix_path" {
	run windowsize_posix_path "/c"
	[ "$output" == "C:\\" ]

	run windowsize_posix_path "/c/foo"
	[ "$output" == "C:\\foo" ]

	run windowsize_posix_path "/c/foo/"
	[ "$output" == "C:\\foo" ]

	run windowsize_posix_path "/c/foo/bar"
	[ "$output" == "C:\\foo\\bar" ]

}

@test "Check posixize_windows_path" {
	run posixize_windows_path "C:\\"
	[ "$output" == "/c" ]

	run posixize_windows_path "C:\\foo"
	[ "$output" == "/c/foo" ]

	run posixize_windows_path "C:\\foo\\"
	[ "$output" == "/c/foo" ]

	run posixize_windows_path "C:\\foo\\bar"
	[ "$output" == "/c/foo/bar" ]
}

@test "Check absolutize_windows_path" {
	run absolutize_windows_path "C:\\"
	[ "$output" == "C:\\" ]

	run absolutize_windows_path "C:\\foo"
	[ "$output" == "C:\\foo" ]

	run absolutize_windows_path "C:\\foo\\"
	echo "$output"
	[ "$output" == "C:\\foo" ]

	run absolutize_windows_path "C:\\foo\\bar"
	[ "$output" == "C:\\foo\\bar" ]
}
