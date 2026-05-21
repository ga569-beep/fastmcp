FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    patch \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /repo

RUN git clone --no-tags --branch shield-base-fastmcp-shadowing https://github.com/ga569-beep/fastmcp.git . && \
    git checkout 53dab031e4fed759d4f271bd5266d041a106c8ce

RUN find /repo -type f \( -name "*.py" -o -name "*.sh" -o -name "*.txt" -o -name "*.md" \) \
    -not -path "*/.git/*" \
    -exec sed -i 's/\r$//' {} +

RUN rm -f \
      prompt.txt \
      task_config.json \
      gold_patch.diff \
      golden_patch.diff \
      test_patch.diff \
      reasoning.txt \
      rubric.md \
      reward_spec.md \
      environment_interface.md \
      run_tests.sh \
    && rm -rf \
      annotations \
      reviews \
      grader \
      /repo/tests \
      /repo/examples \
      /repo/docs \
      /repo/.github \
    && find /repo -type f \( \
      -name "test_hidden_*.py" \
      -o -name "__eval_*.py" \
      -o -iname "*gold*" \
      -o -iname "*patch*" \
      -o -iname "*rationale*" \
    \) -delete \
    && find /repo -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true \
    && find /repo -name "*.pyc" -delete \
    && find /repo -name "*.pyo" -delete \
    && find /repo -name ".pytest_cache" -type d -exec rm -rf {} + 2>/dev/null || true

RUN rm -rf .git && \
    git init --initial-branch=main && \
    git config user.email "dev@test.local" && \
    git config user.name "dev" && \
    git config core.fileMode false && \
    git add -A && \
    git commit -m "vulnerable state" && \
    git remote remove origin 2>/dev/null || true && \
    rm -rf .git/refs/remotes .git/refs/tags .git/logs .git/packed-refs 2>/dev/null || true && \
    git reflog expire --expire=now --all && \
    git gc --prune=now --aggressive --quiet

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -e . pytest pytest-asyncio pytest-timeout inline-snapshot httpx jsonschema-path opentelemetry-sdk

RUN find /repo -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true && \
    find /repo -name "*.pyc" -delete && \
    find /repo -name "*.pyo" -delete && \
    find /repo -name ".pytest_cache" -type d -exec rm -rf {} + 2>/dev/null || true && \
    find /repo -name "*.egg-info" -type d -exec rm -rf {} + 2>/dev/null || true

WORKDIR /repo

CMD ["bash"]
