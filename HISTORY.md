# History

## Step 1

Init module with link to repo:

```sh
go mod init github.com/alinkedd/godabot
```

Init cli app:

```sh
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

Generate godabot command file:

```sh
cobra-cli add godabot
```

Set version and build:
```sh
go build -ldflags "-X="github.com/alinkedd/godabot/cmd.appVersion=v1.0.0
```

Run:
```sh
./godabot # runs help by default
./godabot version
```
