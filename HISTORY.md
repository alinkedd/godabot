# History

## Step 1

Init module with link to repo:

```sh
go mod init github.com/alinkedd/godabot
```

Install cobra-cli and init cli app:

```sh
go install github.com/spf13/cobra-cli@latest
cobra-cli init
go mod tidy # cobra is used directly
```

Generate version command file:

```sh
cobra-cli add version
```

Test build and run:
```sh
go run main.go help
```

Add appVersion variable to cmd, set it and build:
```sh
go build -ldflags "-X="github.com/alinkedd/godabot/cmd.appVersion=v1.0.0
```

Run:
```sh
./godabot # runs help by default
./godabot version
```

## Step 2

Generate godabot command file:

```sh
cobra-cli add godabot
```

Add telebot dependency:

```sh
go get -u gopkg.in/telebot.v3
```

### `godabot.go` file

Import telebot:

```go
import (
  ...
  telebot "gopkg.in/telebot.v3"
)
```

Get TeleToken variable from environment:

```go
var (
  TeleToken = os.Getenv("TELE_TOKEN")
)
```

Add alias `start` to godabot command:

```go
var godabotCmd = &cobra.Command{
  ...
  Aliases: []string{"start"}, // ./godabot start instead of ./godabot godabot
  ...
```

#### godabot (or start) command

Init new bot:

```go
godabot, err := telebot.NewBot(telebot.Settings{
  URL:    "",
  Token:  TeleToken,
  Poller: &telebot.LongPoller{Timeout: 10 * time.Second},
})
```

Add `OnText` handler:

```go
godabot.Handle(telebot.OnText, func(m telebot.Context) error {
  log.Print(m.Message().Payload, m.Text())

  payload := m.Message().Payload

  switch payload {
  case "hello":
    err = m.Send(fmt.Sprintf("Hello! I'm godabot %s", appVersion))
  }

  return err
})
```

Add bot start:

```go
godabot.Start()
```

## Step 3

Build project with upped version.

Get token from [BotFather](https://telegram.me/BotFather) bot:
- create bot - `/newbot`
- enter bot's name - `godabot`
- enter bot's username - `alinkedd_godabot` (an available one)
- copy HTTP API access token - `<access_token>`

Read variable silently from console and export it:
```sh
read -s TELE_TOKEN
# insert `<access_token>` value and press enter
export TELE_TOKEN
```

Start bot:

```sh
./godabot start
```
