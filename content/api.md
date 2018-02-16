---
title: "Commands Api"
anchor: "commands-api"
weight: 40
---

Meeseeks support commands to be invoked using a http API endpoint.

This can be particularly useful when wired to an alerting system as this can be
the seed to auto-remediation.

Tokens can only be managed in a direct message conversation, because otherwise
they would be leaking to any user who has access the used channel. Any attempt
to invoke any token command in an open channel will be rejected by the
meesseeks.

## Creating an api token

* `token-new @user #channel command [args...]`

This invokation will then return a UUID which is the API token. This UUID will
be linked to the command with the proposed arguments. The command will be
executed as the `@user` in the `#channel`. The command can be also an
[alias](#alias-commands-family).

Permissions-wise, the command access level will be evaluated when it is being
invoked. This means that an admin can create a token for a user who does not
have access to the requested command, or the user can lose access to the command
afterwards. In both cases, the token can be used but the command will simply be
rejected at execution time, resulting in an error in the registered `#channel`.

## Using an API token

To use a token, you should invoke the HTTP API endpoint with a HTTP
POST method. For example, using curl:

`curl -X POST -H "TOKEN: <UUID>" localhost:9696/message`

By default meeseeks-box HTTP API listens on `0.0.0.0:9696`.

Additionally, it is possible to add more arguments to the invocation by adding
them as an HTTP form, like this:

`curl -F 'message=arg1+arg2' -X POST -H "TOKEN: <UUID>" localhost:9696/message`

This will result in the command being called appending the _message_ value to
the tail of the command execution text.

## Listing api tokens

* `tokens`

This will return a list of the existing tokens with the following format:

> - *UUID* @user at #channel _command args..._

## Revoking api tokens

* `token-revoke <UUID>`

This will destroy the token and it will not be available anymore.
