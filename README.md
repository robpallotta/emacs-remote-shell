# Remote Shell #

Interactively open shell-mode buffer on remote machine, using tramp.

## Usage ##

Run `M-x remote-shell` then enter the hostname and user. A
`shell-mode` buffer will then open, connected to the specified
hostname as the specified user.

The list of hostnames to use for autocompletion is derived from your ssh config file (`~/.ssh/config`).

The list of users to use for autocompletion is defined by the customizable variable `remote-shell-user-completion-list`.
