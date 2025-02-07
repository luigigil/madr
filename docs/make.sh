#!/usr/bin/env bash
set -e

for file in diagrams/*.d2; do
    BASE=$(basename "$file" .d2)
    d2 "$file" "diagrams/$BASE.svg"
    echo "Generated $BASE.svg"
done
