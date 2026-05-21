#!/bin/bash
set -e

mkdir -p /logs/verifier

cd /repo
git apply /tests/test_patch.diff

python -m pytest \
  tests/test_hidden_tool_injection_shadowing.py \
  tests/test_tool_injection_shadowing_p2p.py \
  --no-header -rA --tb=short --color=no -p no:cacheprovider

echo 1 > /logs/verifier/reward.txt
