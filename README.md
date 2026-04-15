# homebrew-macsift

Homebrew tap for [MacSift](https://github.com/Lcharvol/MacSift) — a
transparent disk cleaner for macOS Tahoe.

## Install

```sh
brew tap Lcharvol/macsift
brew install --cask macsift
```

Then open MacSift:

```sh
open /Applications/MacSift.app
```

On first launch, grant **Full Disk Access** in System Settings → Privacy
& Security → Full Disk Access.

## Update

```sh
brew upgrade --cask macsift
```

`brew update` also checks for new releases automatically when you run
`brew outdated --cask`.

## Uninstall

```sh
brew uninstall --cask macsift
```

To remove preferences, the audit log, and everything MacSift wrote
outside the `.app` bundle:

```sh
brew uninstall --cask --zap macsift
```

Note that Homebrew can't undo the Full Disk Access grant — you'll need
to remove MacSift manually from System Settings → Privacy & Security →
Full Disk Access.

## Why a personal tap and not homebrew-cask proper?

MacSift is ad-hoc signed (no paid Apple Developer ID yet). The official
`homebrew-cask` repo prefers notarized apps and tends to push back on
casks that need Gatekeeper workarounds. Once MacSift is notarized, the
plan is to submit a PR upstream so `brew install --cask macsift` works
without adding a tap.

## License

The cask file is MIT. MacSift itself is MIT — see
[MacSift/LICENSE](https://github.com/Lcharvol/MacSift/blob/main/LICENSE).
