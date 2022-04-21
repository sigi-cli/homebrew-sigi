class Sigi < Formula
  desc "Organizing tool for terminal lovers that hate organizing"
  license "GPL-2.0-only"
  homepage "https://github.com/hiljusti/sigi"
  url "https://static.crates.io/crates/sigi/sigi-3.2.1.crate"
  sha256 "6a230b8aaae39efb1df133c50702b7e1171848319d399ce6362302ff0775b847"
  head "https://github.com/hiljusti/sigi.git", branch: "core"

  depends_on "rust" => :build

  def install
    # When using --head, Homebrew does a git clone and the install method
    # is run from the context of that directory.
    unless build.head?
      # Otherwise, the create file is downloaded to a temporary directory, and
      # then the install method is run from that directory, so we need to
      # extract that crate file first. A crate file is just a tarball with a
      # different file extension.
      system "tar", "--strip-components", "1", "-xzvf", "sigi-#{version}.crate"
    end

    system "cargo", "install", *std_cargo_args
    bin.install "target/release/sigi"
    man1.install "sigi.1"
  end

  test do
    system "#{bin}/sigi", "--version"
  end
end
