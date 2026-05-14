cask "macsift" do
  version "0.3.1"
  sha256 "1bd0eef0b0c87e7effdd8881b8c85b3bc6aab0f86c828ae6ca70bafe63046787"

  url "https://github.com/Lcharvol/MacSift/releases/download/v#{version}/MacSift-#{version}.zip",
      verified: "github.com/Lcharvol/MacSift/"
  name "MacSift"
  desc "Transparent disk cleaner that groups files by owning app"
  homepage "https://github.com/Lcharvol/MacSift"

  # The release flow publishes a versioned zip (MacSift-X.Y.Z.zip) alongside
  # the unversioned one. We point Homebrew at the versioned URL so livecheck
  # can scrape the /releases page and detect new tags.
  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  # MacSift is native SwiftUI. Liquid Glass APIs from macOS 26 (Tahoe) are
  # gated behind runtime availability checks, so the app launches on macOS
  # 15 (Sequoia) and falls back to .regularMaterial / .bordered button
  # styles there. LSMinimumSystemVersion is 15.0 in the shipped Info.plist.
  depends_on macos: ">= :sequoia"

  app "MacSift.app"

  # MacSift is ad-hoc signed (no paid Apple Developer ID yet), so Gatekeeper
  # flags it as "unidentified developer" on first launch. Homebrew needs to
  # strip the quarantine attribute so the right-click → Open dance isn't
  # required after `brew install --cask`.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.quarantine", "#{appdir}/MacSift.app"],
                   sudo: false
  end

  # Clean uninstall: remove everything MacSift writes outside of its own
  # .app bundle. Mirrors what the in-app "Uninstall MacSift…" button does
  # (minus the .app itself, which Homebrew handles).
  zap trash: [
    "~/Library/HTTPStorages/com.macsift.app",
    "~/Library/HTTPStorages/com.macsift.app.binarycookies",
    "~/Library/Logs/MacSift",
    "~/Library/Preferences/com.macsift.app.plist",
    "~/Library/Saved Application State/com.macsift.app.savedState",
  ]

  caveats <<~EOS
    MacSift is ad-hoc signed rather than notarized (no paid Apple Developer
    ID). The Homebrew cask strips the quarantine attribute automatically,
    so you should be able to open it with a regular double-click.

    If macOS still refuses to open it:
      1. Right-click MacSift.app in /Applications → Open → Open
      2. Or System Settings → Privacy & Security → "Open Anyway"

    MacSift requires Full Disk Access to scan system caches and logs. On
    first launch, grant it in System Settings → Privacy & Security →
    Full Disk Access.

    The UI is localized in English and French — it follows your macOS
    system locale automatically.

    Source: https://github.com/Lcharvol/MacSift
  EOS
end
