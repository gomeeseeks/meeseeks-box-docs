---
title: "Configuring Shell Commands"
anchor: "configuring-shell-commands"
weight: 30
---

Simply add those commands to the yaml configuration file, like this:

```yaml
---
commands:
  echo:
    command: "echo"
      auth_strategy: any
      timeout: 5
      help:
        summary: "command that prints back the arguments passed"
        args:
        - "any argument that is passed will be echoed back"
```

Add as many commands as you need, with the only caveat tha they each command needs to have a different name.

To invoke this command you will need to restart the process (still no hot configuration reloaded supported) and then write `@bot-name echo argument1 argument2` in a channel where the bot has already been invited.

When invoking this command, the execution will be translated into calling the `echo` binary, passing through the arguments the user wrote in slack.

As stated before, the `command` has to be an executable, it has to be inside the path and can only be a single word.

## Options

A command can be configured the following way:

- `command`: the command to execute
- `args`: list of arguments to always prepend to the command
- `timeout`: how long we allow the command to run until we cancel it, in
  seconds, 60 by default
- `auth_strategy`: defines the authorization strategy
  - `any`: everyone will be allowed to run this command
  - `none`: no user will be allowed to run this command (default value,
    permissions have to be explicit and conscious)
  - `group`: use `allowed_groups` to control who has access to this command
- `allowed_groups`: list of groups allowed to run this command
- `channel_strategy`: defines the channel authorization strategy
  - `any`: the command can be invoked from any channel
  - `im_only`: the command can only be invoked in an direct message conversation
  - `channel`: use `allowed_channels` to define which channels are allowed to invoke the command
- `allowed_channels`: list of channels allowed to run this command, any if the list is empty.
- `no_handshake`: when true, the bot will not issue a handshake message when the command is accepted.
- `help`: help structure to be printed when using the builtin `help` command

### A slightly more complex example

Running a command with docker, for example, would look like this

```yaml
groups:
  docker: ["pablo"]
commands:
  run-command:
    command: docker
    args:
      - "run"
      - "--rm"
      - "container-image:latest"
    auth_strategy: group
    allowed_groups: ["docker"]
    channel_strategy: "channel"
    allowed_channels:
      - "general"
    no_handshake: true
    help:
      summary: "Run the container-image docker image passing arguments in"
      args:
      - "docker image to run"
      - "arguments to pass to docker..."
```

This will launch a container image every time the command in invoked.

### Environment variables

Environment variables defined when launching the process will percolate to
the executed shell processes. This is so because of the fork/exec model and
because it is how Unix works.

This can be particularly useful to define secrets and other process
configurations following the 12 factor app model.

A caveat is that no environment variable will be expanded when calling a
command, so if a command is defined such that an argument is an environment
variable it will simply not work. If you need to use environment variables to
call a specific executable somehow consider wrapping it with a bash command
where the expansion will happen.
