#!/usr/bin/env bash
input=$(cat)

branch=$(git --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || echo "—")
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // 100')
model=$(echo "$input" | jq -r '.model.display_name // ""')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0' | awk '{printf "%.3f", $1}')

echo " $branch | ctx: ${remaining}% | $model | \$$cost"
