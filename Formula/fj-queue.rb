class FjQueue < Formula
  desc "Forgejo Actions runner and CI queue dashboard"
  homepage "https://github.com/vtmocanu/fj-queue"
  url "https://github.com/vtmocanu/fj-queue/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "7b64bce2ffbbdbd19ae6c2dbe0b741abed8d7e114e4d516e05bea7fd246fc37b"
  license "MIT"

  depends_on "python@3.13"
  depends_on "uv"

  def install
    libexec.install "fj_queue.py"

    # uv resolves the script's PEP-723 inline deps (httpx, rich) on first run.
    # Pin the interpreter to the brewed python@3.13 so uv reuses it instead of
    # downloading a managed CPython.
    (bin/"fj-queue").write <<~SH
      #!/bin/bash
      exec "#{Formula["uv"].opt_bin}/uv" run \\
        --python "#{Formula["python@3.13"].opt_bin}/python3.13" \\
        "#{libexec}/fj_queue.py" "$@"
    SH
  end

  test do
    assert_match "fj-queue", shell_output("#{bin}/fj-queue --version")
  end
end
