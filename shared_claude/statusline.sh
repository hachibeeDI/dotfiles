#!/usr/bin/env bash
input=$(cat)

RESET=$'\033[0m'
ALERT=$'\033[31m'
WARN=$'\033[33m'

branch=$(git --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || echo "—")
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // 100')
model=$(echo "$input" | jq -r '.model.display_name // ""')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0' | awk '{printf "%.3f", $1}')

case "$branch" in
  master) branch_disp="${ALERT}${branch}${RESET}" ;;
  develop) branch_disp="${WARN}${branch}${RESET}" ;;
  *) branch_disp="$branch" ;;
esac

used=$(awk -v r="$remaining" 'BEGIN { printf "%d", 100 - r }')
if [ "$used" -ge 80 ]; then
  ctx_disp="${ALERT}ctx: ${remaining}%${RESET}"
elif [ "$used" -ge 50 ]; then
  ctx_disp="${WARN}ctx: ${remaining}%${RESET}"
else
  ctx_disp="ctx: ${remaining}%"
fi

echo " $branch_disp | $ctx_disp | $model | \$$cost"
