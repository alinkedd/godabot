# godabot

Godabot is a CLI app for the Telegram bot.

[Original bot URL](https://t.me/alinkedd_godabot)

## Bundle

### Build

Set version and build app:

```sh
go build -ldflags "-X="github.com/alinkedd/godabot/cmd.appVersion=<version>
```

`godabot` bin file will be located in the root of the workspace.

### Env

Telegram access token `TELE_TOKEN` should be set as an environment variable ([example](HISTORY.md#step-3)).

## Commands index

### [Help](./cmd/root.go)

Print main info about an app and available commands:

```sh
./godabot
# or
./godabot help
```

Print info about specific command:

```sh
./godabot help <command>
```

### [Version](./cmd/version.go)

Print build version of the bot:

```sh
./godabot version
```

### [Start](./cmd/godabot.go)

Start bot and listen to updates:

```sh
./godabot start
# or
./godabot godabot
```
