# Updated on each release with the version and sha256 from the
# Foglio MD release workflow's job summary.
cask "foglio" do
  version "0.3.0"
  sha256 "4dfbb1b065cb3b8aa8b0c73b543447364abc9bb8eaa37d3da1a5a7c3f708cd14"

  url "https://github.com/Ax6/foglio/releases/download/v#{version}/foglio-#{version}-universal.app.tar.gz"
  name "Foglio MD"
  desc "Lightweight, ultra-fast Markdown reader and editor"
  homepage "https://github.com/Ax6/foglio"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "Foglio MD.app"
  # The shim inside the bundle uses `open -a`, so `foglio notes.md` reaches the
  # running instance through the same Apple Event path as a Finder double-click.
  binary "#{appdir}/Foglio MD.app/Contents/Resources/foglio"

  zap trash: [
    "~/Library/Application Support/io.aaronrusso.foglio",
    "~/Library/Caches/io.aaronrusso.foglio",
    "~/Library/Saved Application State/io.aaronrusso.foglio.savedState",
    "~/Library/WebKit/io.aaronrusso.foglio",
  ]

  caveats <<~EOS
    To make Foglio MD the default for Markdown files, right-click any .md file in
    Finder → Get Info → Open with → Foglio MD → Change All.
  EOS
end
