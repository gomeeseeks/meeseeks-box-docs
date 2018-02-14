---
title: "Cancelling job"
date: 2018-02-14T13:43:27+01:00
weight: 40
---

Once jobs are running the user has total control over them. This means that at
any time a job can be queried for status, get the logs as they are being
streamed, and of course, they can be cancelled.

Job cancellation internally works the same way a timeout is handled. This means
that the job will get a kill signal, and as a result it will error out, leaving
the final state of the job as failed.

Still, any log that was streamed up to that point will be recorded, meaning
that the user can evaluate how far the command reached.

## Cancelling a job

* `cancel <job id>` cancels a job owned by the calling user that is currently running

* `kill <job id>` cancels a job owned by any user. This commands requires the calling user to be in the admin group.

Both commands behave the same way, with the only caveat of permissions and
scope.

## Sample

> pablo [12:13 PM]
> cancel 4
>
> marvin APP [12:13 PM]
> @pablo Ok
> Issued command cancellation to job 4

This will issue a command cancellation to job 4, independently, job 4 should have failed.
