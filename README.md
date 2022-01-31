# Git LabVIEW Integration

This repository provides Bash wrappers for local LvCompare and LvMerge executables to be used in both Windows and POSIX(-like) environments (Mac and Linux).

## Usage

It can serve as a template of a LabVIEW project using Git as its version control system, a submodule of another git repo, or be placed outside the project (e.g. in the home directory).

To get start on Windows, work on Git Bash:

*   Copy `git-labview-integration-posix/labview_path_windows.config.default` to your project and rename to `labview_path_windows.config`.

    *   The name is arbitrary, and the path to the configuration will be used later.
    *   It is preferred to place it at the project root, but it's okay not to.
    *   `PROJECT_ROOT_FORCED` needs to be set if the config file isn't placed inside the project.

*   Edit the configuration
    *   <table>
        <tr><td><code>LABVIEW_EXECUTABLE</code></td><td>Path to the LabVIEW executable </td></tr>
        <tr><td><code>LVCOMPARE_EXECUTABLE</code></td><td>Path to the LvCompare executable<br />
                                                          For 32-bit version on Windows, it would be<br />
                                                          <code>C:\Program Files (x86)\National Instruments\Shared\LabVIEW Compare\LVCompare.exe</code></td></tr>
        <tr><td><code>LVMERGE_EXECUTABLE</code></td><td>Path to the LvMerge executable<br />
                                                        For 32-bit version on Windows, it would be<br />
                                                        <code>C:\Program Files\National Instruments\Shared\LabVIEW Merge\LVMerge.exe</code></td></tr>
        <tr><td><code>CONFIG_DIRECTORY_LEVEL</code></td><td>Level of directory from the project root to this configuration file.<br />
                                                            0 if placed at the project root.</td></tr>
        <tr><td><code>PROJECT_ROOT_FORCED</code></td><td>(Optional) Path to the project root<br/>
                                                         If set to non-empty string, it overrides the auto-detection result
                                                         from <code>CONFIGURATION_DIRECTORY_LEVEL</code> and the configuration source path<br />
                                                         This option is needed only when the configuration file
                                                         cannot be placed inside the project folder, or
                                                         the absolute path of the project root cannot be correctly determined.<br />
                                                         For example, when working on a project in the shared folder of Windows-in-VirtualBox,
                                                         Git sometimes interprete the path as `//VBoxSvr` and cause the script to err,
                                                         making manual specification nessisary.</td></tr>
        </table>

*   Inside the project, do
    ```console
    $ git config difftool.lvcompare.cmd "bash \"path/to/lvcompare_as_difftool.sh\" \"path/to/labview_path_windows.config\" \"\$LOCAL\" \"\$REMOTE\""
    $ git config difftool.lvmerge.cmd "bash \"path/to/lvmerge_as_mergetool.sh\" \"path/to/labview_path_windows.config\" \"\$BASE\" \"\$LOCAL\" \"\$REMOTE\" \"\$MERGED\"
    ```
    *   `"path\\to\\blablabla"` is okay in Git BASH, but too much escape makes me dizzy.
    *   If you want `lvcompare` to be the default `difftool` and `lvmerge` the default `mergetool`, you can also do
        ```console
        $ git config diff.tool lvcompare
        $ git config merge.tool lvmerge
        ```
 
 *   Now you can use
     ```console
     $ git difftool -t lvconfig something another
     ```
     to see the difference with LvCompare and
     ```console
     $ git mergetool -t lvmerge
     ```
     to resolve merge conflicts.
     `-t` can be omitted if `lvdiff` and `lvmerge` is set as the default `difftool` and `mergetool` respectively.

The above configuration can also be done in cmd.exe or PowerShell, but the escaping might be different.

The configuration steps are the same in POSIX environments, plus the executable path can be automatically detected by e.g. `"$(command -v LabVIEW)"` as long as those commands appear in the `PATH` variable.

## Status

*   The usage/featrues mentioned above have all been implemented.

*   The Windows version has been tested with LabVIEW setup.

*   Both are tested by specifying echo as `LVCOMPARE_EXECUTABLE` and `LVMERGE_EXECUTABLE`.

*   Since I haven't figured out the way to get a working setup of LabVIEW on Linux,
    and I doesn't have a Mac machine,
    the POSIX part haven't been tested against real LabVIEW setup.

*   Considering that the Windows part are more complex than the POSIX part
    due to the gap between Windows and BASH, it also requires more user experience to be improved.

*   Suggestions, ideas and contributions are welcome!

## References

*   NI Documentation
    *   Configuring Source Control with LvConfig.exe\
        https://zone.ni.com/reference/en-XX/help/371361R-01/lvhowto/configlvcomp_thirdparty/
    *   Compare VIs Dialog Box\
        https://zone.ni.com/reference/en-XX/help/371361R-01/lvdialog/compare_vis_dialog_box/
    *   Configuring Source Control with LVMerge.exe\
        https://zone.ni.com/reference/en-XX/help/371361R-01/lvhowto/configmerge_thirdparty/
    *   Select VIs to Merge Dialog Box\
        https://zone.ni.com/reference/en-XX/help/371361R-01/lvdialog/merge_vis_db/
    *   Getting started with Git and LabVIEW\
        https://knowledge.ni.com/KnowledgeArticleDetails?id=kA00Z0000019OWSSA2

*   Forum posts
    *   Configuring Git to work with LVCompare and LVMerge\
        https://lavag.org/topic/17934-configuring-git-to-work-with-lvcompare-and-lvmerge/
    *   LabVIEW and Git\
        https://forums.ni.com/t5/LabVIEW/LabVIEW-and-git/td-p/3369275?profile.language=en
        


## Acknowledgements

*   Special thanks go to Jörg Herzinger, Joe Friedrichsen and contributers of the project [joerg/LabViewGitEnv](https://github.com/joerg/LabViewGitEnv).\
    The project also works on making LvCompare and LvMerge available Git.
    Their work enhanced my understanding to LvCompare, LvMerge, git-difftool and git-mergetool, and inspired me to make this one.

## Copyright

*   This work is authored by Yueh-Shun Li (a.k.a. Shamrock Lee) and is released under the MIT license. See `LICENSE` for detail.

*   Git is a trademark held by the Git Project.

*   LabVIEW is a trademark held by the National Instruments Corp..
