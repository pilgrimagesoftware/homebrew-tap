cask "fernrohr" do
  version "0.20.0"
  sha256 "9c51d4b4e4648e51215fb86ff3f1817a07fa8c5a53daa8957850720cd093cb8f"

  url "https://github.com/pilgrimagesoftware/Fernrohr-App/releases/download/v#{version}/Fernrohr_#{version}_aarch64.dmg"
  name "Fernrohr"
  desc "Desktop UI for Kubernetes cluster monitoring"
  homepage "https://github.com/pilgrimagesoftware/Fernrohr-App"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :big_sur

  app "Fernrohr.app"

  # Release builds carry an ad-hoc signature (signing-identity "-" in
  # app/Cargo.toml) unless Developer ID credentials are set, so Gatekeeper
  # blocks a quarantined copy.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "Fernrohr.app"], chdir: "{{appdir}}"
  end
end
