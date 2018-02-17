---
title: "Formatting"
anchor: "formatting"
weight: 50
---

There are multiple formatting options to customize your meeseeks experience.

## Messages

The messages used to reply in a conversation can be changed. To do so add a
messages section in the configuration file.

```yaml
messages:
  handshake:
  - "Message that will be shown when the bot accepts a job"
  failure:
  - "Message that will be shown when the job fails"
  success:
  - "Message that will be shown when the job succeeds"
  unknowncommand:
  - "Message that will be shown when the requested
    command is not registered"
  unauthorized:
  - "Message that will be shown when the user
    requesting a command is not authorized to run it"
```

There can be more than 1 message on each section, they will be picked randomly
when replying.

## Colors

By default messages in attachment mode will show colors for errors, success and
info. These can be changed by adding a format section to the configuration file.

```yaml
format:
  colors:
    info: "#FFFFFF"
    success: "#CCCCCC"
    error: "#000000"
```

## Reply Style

The slack client supports sending messages with 2 styles:

- `text` this will be a plain message without any decoration in which urls and
  media will be unfurled by default.
- `attachment` this is the default, in which the message is posted as an
  attachment, using a color decoration depending on what kind of message it is.

This can be changed in a case by case by adding a formatting section to the
configuration file.

```yaml
format:
  reply_styles:
    handshake: text
    failure: attachment
    success: text
    unknowncommand: attachment
    unauthorized: attachment
```

## Command Templates

Commands can be templated using go [text/template](https://golang.org/pkg/text/template/) language.

This is done through the configuration.

These are the default ones.

```yaml
messages:
  handshake: "{{ AnyValue handshake . }}"
  failure: |
    "{{ .user }} {{ AnyValue failure . }} :disappointed: {{ .error }}
    {{ with $out := .output }}\n```\n{{ $out }}```{{ end }}"
  success: |
    "{{ .user }} {{ AnyValue success . }}
    {{ with $out := .output }}\n```\n{{ $out }}```{{ end }}"
  unknowncommand: |
    "{{ .user }} {{ AnyValue unknowncommand . }} {{ .command }}"
  unauthorized: |
    "{{ .user }} {{ AnyValue unauthorized . }} {{ .command }}"
```

### Helper functions

There are a couple of functions that are added when rendering templates, these are useful to handle arrays, texts and some values.

- `AnyValue` will pick a random value from a string slice.
- `HumanizeTime` will print a time in human readable format, ex. _6 hours ago_
- `HumanizeSize` will print a size in human readable format, ex. _100Mb_
- `HumanizeNumber` will pring a float in a human readable format, removing long trails of decimals.
- `Join` joins a string slice into a single string using a joining char.

