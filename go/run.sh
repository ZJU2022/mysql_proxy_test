#!/bin/bash
set -e

BASE_DIR=$(pwd)

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

for dir in v*; do
  [ -d "$dir" ] || continue

  echo "------------------------------------------------------------"
  echo "Driver version: $dir"
  echo "------------------------------------------------------------"

  cd "$BASE_DIR/$dir"

  # go.mod 必须存在
  if [ ! -f go.mod ]; then
    echo -e "  ${RED}✗ go.mod not found${NC}"
    continue
  fi

  # 直接 go run
  if go run main.go; then
    echo -e "  ${GREEN}✓ SUCCESS${NC}"
  else
    echo -e "  ${RED}✗ FAILED${NC}"
  fi

  echo
done

