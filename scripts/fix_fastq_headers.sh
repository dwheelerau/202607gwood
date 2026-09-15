#!/bin/bash

set -euo pipefail

echo "Processing R1 files..."

for f in *1.fq.gz
do
    [[ -e "$f" ]] || continue

    out="${f%.fq.gz}.fixed.fq.gz"

    echo "  Fixing $f -> $out"

    zcat "$f" | \
        awk 'NR%4==1{$0=$0"/1"}1' | \
        gzip > "$out"
done

echo "Processing R2 files..."

for f in *2.fq.gz
do
    [[ -e "$f" ]] || continue

    out="${f%.fq.gz}.fixed.fq.gz"

    echo "  Fixing $f -> $out"

    zcat "$f" | \
        awk 'NR%4==1{$0=$0"/2"}1' | \
        gzip > "$out"
done

echo "Done."
