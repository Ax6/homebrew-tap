# Updated on each release with the version and sha256 from the
# showmd release workflow's job summary.
cask "showmd" do
  version "0.1.0"
  sha256 "496a7a314de2459a84b5a4c7e773ecc864a959ca4d2da270f6b85f1524b66a9d"

  url "https://github.com/Ax6/showmd/releases/download/v#{version}/showmd-#{version}-universal.app.tar.gz"
  name "showmd"
  desc "Lightweight, ultra-fast Markdown reader and editor"
  homepage "https://github.com/Ax6/showmd"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "showmd.app"
  # The shim inside the bundle uses `open -a`, so `showmd notes.md` reaches the
  # running instance through the same Apple Event path as a Finder double-click.
  binary "#{appdir}/showmd.app/Contents/Resources/showmd"

  # Remove once releases are signed and notarized with a Developer ID.
  postflight do
    system_command "/bin/chmod",
                   args: ["+x", "#{appdir}/showmd.app/Contents/Resources/showmd"],
                   sudo: false
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/showmd.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/io.aaronrusso.showmd",
    "~/Library/Caches/io.aaronrusso.showmd",
    "~/Library/Saved Application State/io.aaronrusso.showmd.savedState",
    "~/Library/WebKit/io.aaronrusso.showmd",
  ]

  caveats <<~EOS
    showmd is not yet notarized by Apple. The install removes the quarantine
    flag for you; if macOS still refuses to open it, allow it once under
    System Settings → Privacy & Security → "Open Anyway".

    To make showmd the default for Markdown files, right-click any .md file in
    Finder → Get Info → Open with → showmd → Change All.
  EOS
end
