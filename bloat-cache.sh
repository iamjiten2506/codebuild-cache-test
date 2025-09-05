#!/bin/bash
# Script to artificially bloat Go build cache
echo "Creating cache bloat simulation..."

# Create large temporary Go files to force cache growth
for i in {1..50}; do
    mkdir -p /tmp/go-bloat-$i
    cat > /tmp/go-bloat-$i/main.go << EOF
package main

import (
    "fmt"
    "crypto/rand"
    "encoding/hex"
)

func main() {
    // Generate large data structures
    data := make([]string, 10000)
    for i := range data {
        bytes := make([]byte, 100)
        rand.Read(bytes)
        data[i] = hex.EncodeToString(bytes)
    }
    fmt.Printf("Generated %d items\n", len(data))
}
EOF
    
    cd /tmp/go-bloat-$i
    go mod init bloat-$i
    go build -o bloat-$i main.go
done

echo "Cache bloat simulation completed"
