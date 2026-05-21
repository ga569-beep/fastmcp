#!/bin/bash
set -e

cd /repo
git apply /solution/gold_patch.diff
