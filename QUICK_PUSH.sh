#!/bin/bash
# 快速推送脚本 - 只添加核心文件，排除大文件
# 使用方法: bash QUICK_PUSH.sh

echo "=== 步骤1: 添加核心配置文件 ==="
git add .gitignore README.md GITHUB_SETUP.md HowToUseNet.md env.sh run_language.sh

echo "=== 步骤2: 添加 Go 代码 ==="
git add go/

echo "=== 步骤3: 添加 Java 代码（排除 .jar 文件）==="
git add Java/*.sh Java/*/*.java 2>/dev/null || true

echo "=== 步骤4: 添加 Node.js 测试代码（只添加测试文件）==="
git add Nodejs/*.sh Nodejs/common/ 2>/dev/null || true
git add Nodejs/v*/*.js Nodejs/v*/package.json 2>/dev/null || true

echo "=== 步骤5: 添加 Python 代码（排除 venv 和 .rpm）==="
git add python/*.sh python/common/ 2>/dev/null || true
git add python/v*/*.py python/v*/requirements.txt 2>/dev/null || true

echo "=== 步骤6: 添加 Net 代码（排除 .dll）==="
git add Net/*.sh Net/*/*.cs Net/*/*.json 2>/dev/null || true

echo "=== 步骤7: 添加 C 代码（只添加源文件）==="
git add C/*.c C/*.h C/*.sh 2>/dev/null || true

echo ""
echo "=== 完成！查看暂存文件（只显示前20个）==="
git status --short | head -20

echo ""
echo "现在可以执行："
echo "  git commit -m 'Initial commit: MySQL Proxy Driver Compatibility Test Suite'"
echo "  git push -u origin main"

