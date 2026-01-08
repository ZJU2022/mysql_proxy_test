#!/bin/bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo "============================================================"
echo "Running Java drivers in $BASE_DIR"
echo "============================================================"

for dir in "$BASE_DIR"/v*; do
  [ -d "$dir" ] || continue

  DRIVER=$(basename "$dir")

  echo "------------------------------------------------------------"
  echo "Driver version: $DRIVER"
  echo "------------------------------------------------------------"

  cd "$dir" || {
    echo -e "  ${RED}✗ Cannot cd to $dir${NC}"
    continue
  }

  # 清理 class
  rm -f *.class

  # 找 jar
  JAR=$(ls *.jar 2>/dev/null | head -n 1)
  if [ -z "$JAR" ]; then
    echo -e "  ${RED}✗ No jar found${NC}"
    continue
  fi

  # 编译
  if ! javac -cp "$JAR" Main.java; then
    echo -e "  ${RED}✗ COMPILE FAILED${NC}"
    continue
  fi

  # 运行
  if java -cp ".:$JAR" Main; then
    echo -e "  ${GREEN}✓ SUCCESS${NC}"
  else
    echo -e "  ${RED}✗ RUN FAILED${NC}"
  fi

  echo
done

echo "============================================================"
echo "Finished running Java drivers"
echo "============================================================"

