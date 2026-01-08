#!/bin/bash
source /opt/mysql_proxy_test/env.sh

BASE_DIR="/opt/mysql_proxy_test/Net"

echo "============================================================"
echo "Running .NET drivers against Proxy $PROXY_HOST:$PROXY_PORT"
echo "============================================================"

for driver_dir in $(ls -1 $BASE_DIR | grep '^v'); do
  echo "------------------------------------------------------------"
  echo "Driver version: $driver_dir"
  echo "------------------------------------------------------------"

  cd $BASE_DIR/$driver_dir || { echo "Cannot cd $driver_dir"; continue; }

  if [ ! -f Program.cs ]; then
    echo "  ✗ No Program.cs found"
    continue
  fi

  # 清理旧 exe
  rm -f Program.exe

  # 编译
  mcs -reference:MySql.Data.dll Program.cs
  if [ ! -f Program.exe ]; then
    echo "  ✗ Compile failed"
    continue
  fi

  # 运行
  if mono Program.exe; then
    echo "  ✓ SUCCESS"
  else
    echo "  ✗ FAILED"
  fi
  echo
done

echo "============================================================"
echo "Finished running .NET drivers"
echo "============================================================"

