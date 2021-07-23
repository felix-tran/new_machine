#!/bin/bash

# Simple script to install all my usual dev-tools

# git, gcloud, python3, pip3, docker, chrome

# Customize your Linux for more efficacy

This might be redundant because I will get a MacBook. I will look into writing a script for macOS instead.
<https://www.jamf.com/blog/reinstall-a-clean-macos-with-one-button/>

### Include git branch in terminal.

in `~/.bashrc` at the end add:

```sh
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="\e[94m\]\u@\h \[\e[32m\]\w \[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "
```

use this [link](https://misc.flogisoft.com/bash/tip_colors_and_formatting) to chose different colors.


### add color to nano.

in `/etc/nanorc` at the end add:

```sh
include "/usr/share/nano/*.nanorc"
```
