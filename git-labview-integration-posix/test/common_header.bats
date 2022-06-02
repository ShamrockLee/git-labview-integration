#/usr/bin/env bats

setup() {
	. $(dirname "$BATS_TEST_FILENAME")/../common_header.sh
}

@test "Check absolutize_posix_path" {	
	run absolutize_posix_path "/dev/shm"
	echo "$output"
	[ "$output" == "/dev/shm" ]

	run absolutize_posix_path "/dev/shm" "/foo/bar"
	[ "$output" == "/dev/shm" ]

	run absolutize_posix_path "/"
	[ "$output" == "/" ]

	run absolutize_posix_path "baz" "/foo/bar"
	echo "/foo/bar/baz"
}
