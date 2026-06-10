class FjQueue < Formula
  desc "Forgejo Actions runner and CI queue dashboard"
  homepage "https://github.com/vtmocanu/fj-queue"
  url "https://github.com/vtmocanu/fj-queue/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "d2ff9d525fa52255f54f8d99da9b2a84a1339c67b454a6526741c0808558ec11"
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
