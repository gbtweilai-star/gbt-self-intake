#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_self_intake info
PYTHONPATH=src python -m gbt_self_intake check --payload '{}'
PYTHONPATH=src python -m gbt_self_intake run   --payload '{}'
