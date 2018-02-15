---
title: "Api"
anchor: "api"
weight: 40
---

Meeseeks support commands to be invoked using a http API endpoint.

This can be particularly useful when wired to an alerting system as this can be
the seed to auto-remediation.

The way it works is that an admin user can create a new API token using the
`token-new` command and picking the user that will be linked to. The channel in
which the command will be invoked (and in which to reply), and then the command
and the arguments.

Tokens then can be listed with `tokens` and can be revoked with `token-revoke`

Tokens can only be managed in a direct message conversation, because otherwise
they would be leaking to any user who has access the used channel. Any attempt
to invoke any token command in an open channel will be rejected by the
meesseeks.

## Creating an api token

* `token-new @user #channel command [args...]`

This invokation will then return a UUID which is the API token. This UUID will
be linked to the command with the proposed arguments. The command will be
executed as the @user in the #channel.

Permissions-wise, the command access will be evaluated when it is being
invoked, which means that an admin can create a token for a user who does not
have access to the requested command, or the user can loose access to the
command afterwards, in both cases, the token can be used, it will simply be
rejected in execution time, resulting in an error in the registered #channel.

## Using an API token

To use a created token, you should invoke the http api endpoint with a HTTP
POST method. For example, using curl:

`curl -X POST -H "TOKEN: <UUID>" localhost:9696/message`

By default the http port is 9696 and the meeseeks are listening on 0.0.0.0.

Additionally, it's possible to add more arguments to the invocation by adding
them as a FORM, like this:

`curl -F 'message=arg1+arg2' -X POST -H "TOKEN: <UUID>" localhost:9696/message`

This will result in the command being called appending the _message_ value to
the tail of the command execution text.

## Listing api tokens

* `tokens`

This will return a list of the existing tokens with the following format:

> - *TOKEN* @user at #channel _command args..._
