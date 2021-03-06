class Opa < Formula
  desc "Open source, general-purpose policy engine"
  homepage "https://www.openpolicyagent.org"
  url "https://github.com/open-policy-agent/opa/archive/v0.16.2.tar.gz"
  sha256 "f71b0532790962fb2b19b18acab21f8303c1e25f1a6822f461f006a3f47f0c93"

  bottle do
    cellar :any_skip_relocation
    sha256 "c2bbcbe1fc2918e0980ad9b917504dd29e40f33625374f2306c5c1df379493ff" => :catalina
    sha256 "b25e1bee179f8f63d64c7fe5cd7663bf4bc0250808a492736607d817b1915815" => :mojave
    sha256 "3432dfa618db7aad868f9ea064a1518c3299fcafdee9e16c861bba6f3ba486cc" => :high_sierra
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/"opa", "-trimpath", "-ldflags",
                 "-X github.com/open-policy-agent/opa/version.Version=#{version}"
    prefix.install_metafiles
  end

  test do
    output = shell_output("#{bin}/opa eval -f pretty '[x, 2] = [1, y]' 2>&1")
    assert_equal "+---+---+\n| x | y |\n+---+---+\n| 1 | 2 |\n+---+---+\n", output
    assert_match "Version: #{version}", shell_output("#{bin}/opa version 2>&1")
  end
end
