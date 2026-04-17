# Homebrew Tap

Homebrew formulae for tools by [PrivateVictories-Main](https://github.com/PrivateVictories-Main).

## Install

```bash
brew tap PrivateVictories-Main/tap
brew install claude-auto-continue
```

Or in one command:

```bash
brew install PrivateVictories-Main/tap/claude-auto-continue
```

## Available Formulae

| Formula | Description |
|---------|-------------|
| `claude-auto-continue` | Auto-click Continue in Claude desktop app, browser, and CLI |

## After Install

```bash
# One-time setup (grants Accessibility permission)
claude-auto-continue --setup

# Run as a background service (auto-start on login, survive reboots)
brew services start claude-auto-continue
```
