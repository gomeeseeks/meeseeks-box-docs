---
title: "Auditory Commands Family"
anchor: "auditory-commands-family"
weight: 40
---

Following the security tenet, the Meeseeks box provides a set of builtin
commands that allow any user to control the commands that were executed in
the past.

These auditory commands can be split into 2 main groups, one that allows the
invoking user to check jobs launched by himself, and another that allows an
administrator to check commands that were called by all users, or one in
particular.

## User Commands

The set of commands that control a job are:

### `jobs`

This command will print the last 5 jobs that were invoked by the calling user.

It supports the `-limit` argument to extend or shorten how many jobs are shown.

Sample:

> pablo [2:13 PM]
> @marvin jobs
> marvin APP [2:13 PM]
> @pablo Spend a few thousand million years in a job and eventually you get
> promoted, I have my own bucket now. Finally, I am somebody.
> *58* - 18 hours ago - *docker-ps* by *pablo* in *DM* - *Successful*
> *57* - 18 hours ago - *docker-images* by *pablo* in *DM* - *Successful*
> *56* - 18 hours ago - *docker-pull* by *pablo* in *DM* - *Failed*
> *55* - 18 hours ago - *df* by *pablo* in *DM* - *Failed*

### `job`

This command will print the details of a job. It requires the user to send a job id.

Sample:

> pablo [2:16 PM]
> @marvin job 58
> marvin APP [2:16 PM]
> @pablo I know. Wretched, isn’t it?
> * *ID* 58
> * *Status* Successful
> * *Command* docker-ps
> * *Where* IM
> * *When* 18 hours ago

This command will also print other information like the arguments that were
passed in, in the case they are available.

### `logs`

Given a job id, this command will print the recorded output of the job.

It important to realize that any command executed will be recorded, for good,
and this output can always be extracted. This is particularly useful because
it can turn the Meeseeks into a production log.

The way this command looks like is exactly the same as when a command
finishes execution.

### `last`

Last is equivalent to run `job` with the last job id available for the user.

This command can be useful to see the status of the last invoked job.

### `tail`

Tail is equivalent to run `logs` with the last job id available for the user.

Because jobs stream the logs to the meeseeks storage this can be particularly
useful to monitor the current state of a job, even before it finishes.

In future releases `tail` will be improved to only return N lines of the logs
instead of it all, and there will also be a `head` command to do the exact
opposite.

## Admin Commands

Admin commands are equivalent to the user commands, with the caveat that they
don't filter by the calling user but return jobs or logs from any user.

Becase he amount of data extracted this way can be a bit daunting, by default
all the listing commands will only return 5 lines unless `-limit X` is passed.
 This command also allows to filter by a particular user with `-user X`.

### `audit`

Admin command that behaves like `jobs` but returns the unfiltered list of users.

Use `-limit` and `-user` to filter away.

### `auditjob`

Requires a job ID, behaves the same way as `jobs` but without the limitation
of filtering the job by the calling user.

### `auditlogs`

Requires a job ID, behaves the same way as `logs` but without the limitation
of filtering the job by the calling user.

## Not recorded commands

* Builtin commands are not recorded, on purpose (they would simply be noise)
* Rejected commands are not recorded.

## A note about privacy

A side effect of how Slack behaves when searching for channels led to avoiding
leaking private conversations.

This happens when a direct conversation in between more than one person and
the meeseeks takes place, the meeseeks will record the job, and it will
record the channel id.

But when an admin requests the job list through the `audit` command, the job
will try to extract the channel description to show it to the admin. In some
cases this will not be possible. Particularly when the admin user does not
have access to the channel because it's not invited to it. When this happens
the query will return an error and this error will be handled by presenting
the channel as **unknown-channel**.

If the user has access, then the channel will be presented in the form of
**#@invitee1,invetee2,etc**, this channel will be a link that can be clicked
*and can take him to the conversation.

This started as a way of handling the error, but for the sake of privacy it
is left this way because it makes sense.

This means that an admin is able to see the command details, or the logs, but
it will not be able to see who was in the private channel.
