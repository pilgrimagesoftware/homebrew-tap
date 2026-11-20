cask "knot-ai" do
  version "1.41.1"
  sha256 "3e54871fc5652b60b87944c065205e968cf38b227e06a6f9e645cde7a2139103"

  url "https://github.com/pilgrimagesoftware/Knot-App/releases/download/v#{version}/Knot_#{version}_aarch64.dmg"
  name "Knot"
  desc "Runs a team of AI coding agents in embedded terminals"
  homepage "https://github.com/pilgrimagesoftware/Knot-App"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Knot.app"

  # Release builds carry an ad-hoc signature, so Gatekeeper blocks a
  # quarantined copy. Matches the xattr step in docs/site/latest/install.md.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "Knot.app"], chdir: "{{appdir}}"
  end
end
