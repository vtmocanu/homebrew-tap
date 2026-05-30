class FjQueue < Formula
  desc "Forgejo Actions runner and CI queue dashboard"
  homepage "https://github.com/vtmocanu/fj-queue"
  url "https://github.com/vtmocanu/fj-queue/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "bf6410d7a09883ced235fbce06e2352063f44d44a9c1a986b47dc2286af39b9e"
  license "MIT"

  depends_on "python@3.13"
  depends_on "uv"

  def install
    libexec.install "fj_queue.py"

    # uv resolves the script's PEP-723 deps (httpx, rich) on first run.
    # Pin the interpreter to the brewed python@3.13 so uv reuses it
    # instead of downloading a managed CPython.
    (bin/"fj-queue").write <<~SH
      #!/bin/bash
      exec "#{Formula["uv"].opt_bin}/uv" run --python "#{Formula["python@3.13"].opt_bin}/python3.13" "#{libexec}/fj_queue.py" "$@"
    SH
  end

  test do
    assert_match "fj-queue", shell_output("#{bin}/fj-queue --version")
  end
end
