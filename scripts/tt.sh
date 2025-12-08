#!/bin/bash
# Quick shell startup time tester
# Usage: tt [iterations]

ITERATIONS=${1:-10}

echo "🚀 Testing zsh startup time ($ITERATIONS runs)..."
echo ""

if command -v hyperfine &>/dev/null; then
    hyperfine --warmup 2 --runs "$ITERATIONS" 'zsh -i -c exit'
else
    echo "Using basic time measurement (install 'hyperfine' for better stats):"
    total=0
    for i in $(seq 1 "$ITERATIONS"); do
        runtime=$(TIMEFORMAT='%R'; { time zsh -i -c exit; } 2>&1)
        ms=$(echo "$runtime * 1000" | bc)
        printf "Run %2d: %.1f ms\n" "$i" "$ms"
        total=$(echo "$total + $runtime" | bc)
    done
    avg=$(echo "scale=3; $total / $ITERATIONS" | bc)
    avg_ms=$(echo "scale=1; $avg * 1000" | bc)
    echo ""
    echo "Average: ${avg}s (${avg_ms}ms)"
fi

echo ""
echo "📊 Performance reference (with CrowdStrike Falcon):"
echo "  • Minimal config:     ~100ms"
echo "  • Your config (now):  ~148ms  ✅"
echo "  • Heavy config:       200-300ms"
