#!/bin/bash
set -e

LANGUAGE=$1
BASE_DIR="/opt/mysql_proxy_test"

if [ -z "$LANGUAGE" ]; then
  echo "Usage: $0 <language>"
  exit 1
fi

if [ ! -x "$BASE_DIR/$LANGUAGE/run.sh" ]; then
  echo "No runnable script: $BASE_DIR/$LANGUAGE/run.sh"
  exit 1
fi

# 加载环境变量（全局只做一次）
source $BASE_DIR/env.sh

echo "============================================================"
echo "Running $LANGUAGE drivers against Proxy $PROXY_HOST:$PROXY_PORT"
echo "============================================================"

cd $BASE_DIR/$LANGUAGE
./run.sh

