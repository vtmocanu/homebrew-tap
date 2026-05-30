class FjQueue < Formula
  desc "Forgejo Actions runner and CI queue dashboard"
  homepage "https://github.com/vtmocanu/fj-queue"
  url "https://github.com/vtmocanu/fj-queue/archive/refs/tags/v2.0.1.tar.gz"
  sha256 "05975a382e9b588cbee3abe3cf0f7b40bd67b8fc2cc523a8b8857431bf3601a6"
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
