---
title: "Alias Commands Family"
anchor: "alias-commands-family"
weight: 40
---

Aliases are a convenient way to create shortcuts for complex commands. Instead of typing all the flags, which can be prone to typos, one can simply add an alias for the whole command and that can be as short as a single letter.

Aliases are set per-user. This means you can't see other users' aliases nor there are global shared aliases. Two users can set the same alias without collisions.

## User Commands

The set of commands that control aliases are:

### `alias <alias> <full command>`

Sets an alias for a command, including flags.

Sample:

>omame [11:27]
>@marvin alias ps audit -status running
>
>marvin APP [11:27]
>@omame Mr Meeseeks
>alias created successfully
>
>omame [11:27]
>@marvin ps
>
>marvin APP [11:27]
>@omame All done!
>*44* - 3 days ago - *wait* by *omame* in *DM* - >*Running*

### `unalias <alias>`

Remove an alias.

Sample:

>omame [11:28]
>@marvin unalias ps
>
>marvin APP [11:28]
>@omame All done!
>- *pablo-failed* - `audit -status failed -user pablo`
>- *ps* - `audit -status running`

## Admin commands

There are no admin commands for aliases.

## Not recorded commands

* Builtin commands are not recorded, on purpose (they would simply be noise)
* Rejected commands are not recorded.
