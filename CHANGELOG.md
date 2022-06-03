# Changelog

## v0.2.0

### Highlights
*   Refactor to use Bash + coreutil guided by BATS test cases.

### Fixes
*   Fix the `README.md` typo about the missing double-quote (`"`)
    in the `git config` setting, and the table about the default configuration on Windows.

### Enhancements
*   Remove the `sed` and `grep` dependencies.

*   Add test cases using [BATS](https://github.com/bats-core/bats-core)

*   Support Bash version 3, 4 and 5

### Backward incompatibilities
*   The order of `$REMOTE` and `$LOCAL` is now NOT reversed inside the program.

    The `git config difftool.lvcompare.cmd` and `git config mergetool.lvmerge.cmd`
    needs to be change accordingly.

    Even if the above manual change is not made,
    this should only affects the order of the files compared.

### Release status
*   v0.2.0-beta20220603: Passed the current test cases, but have not been tested on a real setup.

## v0.1.0

### Highlights
*   Initialize the project.

*   Test the windows part against a Windows 10 VM with LabVIEW installed.

*   The posix part is not tested yet.
