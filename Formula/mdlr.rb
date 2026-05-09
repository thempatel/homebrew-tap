class Mdlr < Formula
  desc "Polyglot code-analysis tool that builds a graph of source-level units and computes structural metrics"
  homepage "https://github.com/thempatel/mdlr"
  url "https://github.com/thempatel/mdlr/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "5d8fda59724787920be5d7a9fc743b882c84a6514206d20d2a6c190425693537"
  license "MIT"
  head "https://github.com/thempatel/mdlr.git", branch: "main"

  depends_on "go" => :build
  depends_on "rustup-init" => :build

  def install
    ENV["RUSTUP_HOME"] = buildpath/"rustup"
    ENV["CARGO_HOME"] = buildpath/"cargo"

    system "rustup-init", "-y",
                          "--no-modify-path",
                          "--default-toolchain", "none",
                          "--profile", "minimal"
    ENV.prepend_path "PATH", "#{ENV["CARGO_HOME"]}/bin"

    system "cargo", "build", "--release", "--bin", "mdlr"
    bin.install "target/release/mdlr"

    cd "tools/mdlr-extract-go" do
      system "go", "build", "-o", bin/"mdlr-extract-go", "."
    end
  end

  test do
    assert_match "mdlr", shell_output("#{bin}/mdlr --version")
  end
end
