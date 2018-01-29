---
title: "Getting Started"
anchor: "getting-started"
weight: 20
---

## Installation

Following the simplicity tenet, installation is as simple as picking the right binary from the releases page, unpack with tar.gz and just launch.

The only requirement is to have a valid slack token which can be obtained creating a bot user in [Slack](https://my.slack.com/services/new/bot) and then passing it in a SLACK_TOKEN environment variable.

## Running with Docker

Docker images for both amd64 and armv6 are provided. To launch a meeseeks box just create the environment variables file, copy the configuration file and run with

```sh
docker run -it --rm \
  --env-file %(pwd)/environment \
  -v $(pwd)/meeseeks-box.yaml:/meeseeks.yaml \
  pcarranza/meeseeks-box \
  -config /meeseeks.yaml
```

## Running within kubernetes

Because docker images are provided, it's trivial to run a meeseeks-box inside a kubernetes cluster. The steps are as follow:

1. Create the a token secret file with `echo -n <SLACK_TOKEN> > slack-token`
2. Load the token in kubernetes `kubectl create secret generic slack-token --from-file=./slack-token`
3. Create the config map using the provided sample `kubectl create -f kubernetes/config-map.yml`
4. Create the meeseeks deployment using the provided file `kubectl create -f kubernetes/deployment.yml`

### Running on raspberrypi

To run on a raspberripy cluster you only need to change the container image to `pcarranza/meeseeks-box-armv6`

## Starting to use the meeseeks-box

Once the process is running and you got `INFO[0000] Listening messages` printed out, you could simply invite your bot to any channel, or just open a direct DM conversation with it.

If you are talking in a public channel you will need to start any message with the bot handle for it to pay attention to you, if you are talking in DM you don't need to say the name.

Go ahead and try issuing `help` to get a list of commands supported, or `version` to see what version have you installed.
