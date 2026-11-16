cask "knot-ai" do
  version "1.39.0"
  sha256 "ab5deab3b4fc9cf11bc19d1aca59e66e23088504f5a810e142a5745e8a2f4367"

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
