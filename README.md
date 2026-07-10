# homebrew-tap

Homebrew tap for [@vtmocanu](https://github.com/vtmocanu)'s tools.

```sh
brew tap vtmocanu/tap
brew trust vtmocanu/tap    # Homebrew 6.0+ requires trusting third-party taps
brew install <formula>
```

(On Homebrew older than 6.0, skip the `brew trust` line. `brew trust --formula vtmocanu/tap/<formula>` scopes trust to a single formula instead of the whole tap.)

## Formulae

| Formula | Description | Source |
|---------|-------------|--------|
| `cc-statusline` | Two-line ANSI statusline for Claude Code | [vtmocanu/cc-statusline](https://github.com/vtmocanu/cc-statusline) |
| `fj-queue` | Forgejo Actions runner and CI queue dashboard | [vtmocanu/fj-queue](https://github.com/vtmocanu/fj-queue) |

Formulae are bumped automatically on each upstream release.
