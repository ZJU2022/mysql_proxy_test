#!/bin/bash
set -e

BASE_DIR="/opt/mysql_proxy_test/Nodejs"

echo "============================================================"
echo "Running Nodejs drivers against Proxy $PROXY_HOST:$PROXY_PORT"
echo "============================================================"

for driver_dir in $(ls -1 $BASE_DIR | grep '^v'); do
  echo "------------------------------------------------------------"
  echo "Driver version: $driver_dir"
  echo "------------------------------------------------------------"

  cd $BASE_DIR/$driver_dir || continue

  if [ ! -f test.js ]; then
    echo "  ✗ No test.js found"
    echo
    continue
  fi

  if node test.js; then
    echo "  ✓ SUCCESS"
  else
    echo "  ✗ FAILED"
  fi

  echo
done

echo "============================================================"
echo "Finished running Nodejs drivers"
echo "============================================================"

