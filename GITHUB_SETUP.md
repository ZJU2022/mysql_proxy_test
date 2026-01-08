# GitHub 仓库推送指南

## 📋 完整操作步骤

### 第一步：在 GitHub 上创建新仓库

1. 登录 GitHub：https://github.com
2. 点击右上角的 **"+"** 按钮，选择 **"New repository"**
3. 填写仓库信息：
   - **Repository name**: `mysql_proxy_test` (或你想要的名称)
   - **Description**: MySQL Proxy Driver Compatibility Test Suite (可选)
   - **Visibility**: 选择 Public 或 Private
   - ⚠️ **重要**: **不要**勾选 "Initialize this repository with a README"（因为本地已有代码）
   - ⚠️ **不要**添加 .gitignore 或 license（本地已有）
4. 点击 **"Create repository"**

### 第二步：删除旧的 remote 并添加新的 remote

```bash
# 删除旧的 remote
git remote remove origin

# 添加新的 remote（将 YOUR_USERNAME 替换为你的 GitHub 用户名）
git remote add origin https://github.com/YOUR_USERNAME/mysql_proxy_test.git

# 或者使用 SSH（如果你配置了 SSH key）
# git remote add origin git@github.com:YOUR_USERNAME/mysql_proxy_test.git

# 验证 remote 配置
git remote -v
```

### 第三步：提交本地代码

```bash
# 添加所有文件到暂存区
git add .

# 创建首次提交
git commit -m "Initial commit: MySQL Proxy Driver Compatibility Test Suite"

# 查看提交历史确认
git log
```

### 第四步：推送到 GitHub

```bash
# 推送 main 分支到远程仓库
git push -u origin main
```

如果遇到错误，可能需要强制推送（仅当确定要覆盖远程时）：
```bash
git push -u origin main --force
```

---

## 🔧 一键执行脚本

你也可以使用以下命令序列（记得替换 YOUR_USERNAME）：

```bash
# 1. 删除旧 remote
git remote remove origin

# 2. 添加新 remote（替换 YOUR_USERNAME）
git remote add origin https://github.com/YOUR_USERNAME/mysql_proxy_test.git

# 3. 提交代码
git add .
git commit -m "Initial commit: MySQL Proxy Driver Compatibility Test Suite"

# 4. 推送到 GitHub
git push -u origin main
```

---

## 🔐 认证方式

### 方式一：使用 Personal Access Token (推荐)

1. GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
2. 生成新 token，勾选 `repo` 权限
3. 推送时使用 token 作为密码：
   ```
   Username: 你的GitHub用户名
   Password: 你的Personal Access Token
   ```

### 方式二：使用 SSH Key

1. 生成 SSH key（如果还没有）：
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```
2. 将公钥添加到 GitHub：Settings → SSH and GPG keys → New SSH key
3. 使用 SSH URL：
   ```bash
   git remote add origin git@github.com:YOUR_USERNAME/mysql_proxy_test.git
   ```

---

## ⚠️ 常见问题

### 问题1：推送时提示认证失败
- 检查用户名和密码/token是否正确
- 如果使用HTTPS，确保使用Personal Access Token而不是GitHub密码

### 问题2：提示 "remote origin already exists"
- 先执行：`git remote remove origin`
- 然后再添加新的 remote

### 问题3：提示 "refusing to merge unrelated histories"
- 使用：`git push -u origin main --allow-unrelated-histories`

---

## 📝 后续更新代码

以后更新代码时，使用以下命令：

```bash
git add .
git commit -m "你的提交信息"
git push
```

