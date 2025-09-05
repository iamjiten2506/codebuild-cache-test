#!/bin/bash
# Script to artificially bloat disk space to test cleanup mechanism
echo "Creating cache bloat simulation..."

# Show initial disk usage
echo "Initial disk usage:"
df -h /

# Method 1: Create large files in actual Go cache directories
echo "Creating large files in Go cache directories..."
mkdir -p /root/.cache/go-build/bloat-test
mkdir -p /root/go/pkg/mod/bloat-test

# Create 50GB of bloat files to push disk usage above 70%
for i in {1..50}; do
    echo "Creating bloat file $i/50..."
    dd if=/dev/zero of=/root/.cache/go-build/bloat-test/large-file-$i bs=1M count=1000 2>/dev/null || true
done

# Method 2: Also create files in /mce-cache if it exists
if [ -d "/mce-cache" ]; then
    echo "Creating additional bloat in /mce-cache..."
    mkdir -p /mce-cache/bloat-test
    for i in {1..20}; do
        dd if=/dev/zero of=/mce-cache/bloat-test/bloat-$i bs=1M count=1000 2>/dev/null || true
    done
fi

# Method 3: Create large temporary files as fallback
echo "Creating additional large files..."
for i in {1..30}; do
    dd if=/dev/zero of=/tmp/bloat-file-$i bs=1M count=1000 2>/dev/null || true
done

# Show final disk usage
echo "Final disk usage after bloat:"
df -h /

echo "Cache bloat simulation completed"
