# godabot

Godabot is a CLI app for the Telegram bot.

[Original bot URL](https://t.me/alinkedd_godabot)

## Prerequisites

- Go (>=1.21.4)

## Setup

### Install

Set version and install app:

```sh
go install -ldflags "-X="github.com/alinkedd/godabot/cmd.appVersion=<version> github.com/alinkedd/godabot
```

### Env

Telegram access token `TELE_TOKEN` should be set as an environment variable ([example](HISTORY.md#step-3)).

## Command index

### [Help](./cmd/root.go)

Print main info about an app and available commands:

```sh
godabot
# or
godabot help
```

Print info about specific command:

```sh
godabot help <command>
```

### [Version](./cmd/version.go)

Print build version of the bot:

```sh
godabot version
```

### [Start](./cmd/godabot.go)

Start bot and listen to updates:

```sh
godabot start
```
