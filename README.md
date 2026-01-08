# MySQL Proxy Driver Compatibility Test Suite

## 📌 项目背景

本项目用于 **验证不同编程语言、不同 MySQL 驱动版本，通过 Proxy 访问不同 MySQL 版本时的兼容性与稳定性**。

目标是构建一套：

* ✅ 可自动化执行
* ✅ 多语言统一结构
* ✅ 多驱动版本可切换
* ✅ 仅修改 Proxy 配置即可复用
* ✅ 可直接打包为自定义镜像 / CI 使用

的 **MySQL Proxy 驱动回归测试框架**。

---

## 🧩 当前已支持语言

| 语言          | 状态    |
| ----------- | ----- |
| Go          | ✅ 已完成 |
| Java (JDBC) | ✅ 已完成 |
| Python      | ❌ 依赖错 |
| Net         | ✅ 已完成|
| Node.js     | ✅ 已完成| |
| PHP         | ⏳ 规划中 |
| C / C++     | ⏳ 规划中 |
| Ruby        | ⏳ 规划中 |
| Rust        | ⏳ 规划中 |

> 所有语言遵循 **相同的目录结构和执行规范**。

---

## 📂 项目目录结构

```text
mysql_proxy_test/
├── env.sh                 # 全局环境变量（Proxy / DB）
├── run_language.sh        # 语言级执行入口
├── go/
│   ├── run.sh
│   ├── v1_4/
│   ├── v1_7/
│   └── v1_9/
├── Java/
│   ├── run.sh
│   ├── v5_1/
│   ├── v8_4/
│   └── v9_4/
├── python/
├── Nodejs/
├── PHP/
├── C/
├── C++/
├── Ruby/
└── Rust/
```

---

## 🌍 环境变量配置

统一在 `env.sh` 中配置，**所有语言共用**：

```bash
export PROXY_HOST=10.9.x.x
export PROXY_PORT=3306
export DB_USER=root
export DB_PASS=your_password
```

加载方式：

```bash
source env.sh
```

---

## ▶️ 执行方式

### 1️⃣ 执行指定语言的所有驱动版本

```bash
./run_language.sh go
./run_language.sh Java
```

执行效果示例：

```text
Driver version: v5_1
✓ SUCCESS (driver ok) cost=302ms

Driver version: v8_4
✓ SUCCESS (driver ok) cost=355ms

Driver version: v9_4
✓ SUCCESS (driver ok) cost=348ms
```

---

## 🧪 测试逻辑（所有语言一致）

每个驱动版本都会执行以下逻辑：

1. 通过 Proxy 建立 MySQL 连接
2. 执行 `PING`
3. 执行 `SELECT 1`
4. 执行简单系统表查询
5. 输出耗时与结果

示例（Java / Go 一致）：

```sql
SELECT 1;
SELECT COUNT(*) FROM mysql.user;
```

---

## 🧱 驱动版本管理原则（非常重要）

### ✅ 每个驱动版本目录

以 Java 为例：

```text
Java/v8_4/
├── Main.java
└── mysql-connector-j-8.4.0.jar
```

原则：

* ❌ 不依赖系统 `/usr/share/java`
* ❌ 不使用 Maven / Gradle
* ✅ 目录即能力，拷贝即可运行
* ✅ 方便镜像化、离线使用、CI 集成

---

## ☕ Java 驱动版本说明

| 目录   | JDBC 版本 | 备注               |
| ---- | ------- | ---------------- |
| v5_1 | 5.1.49  | 旧版本，兼容 MySQL 5.7 |
| v8_4 | 8.4.0   | 中间版本             |
| v9_4 | 9.4.0   | 最新版本             |

---

## 🐹 Go 驱动版本说明

使用 `github.com/go-sql-driver/mysql`：

| 目录   | 驱动版本   |
| ---- | ------ |
| v1_4 | v1.4.x |
| v1_7 | v1.7.x |
| v1_9 | v1.9.x |

---

## 其他说明
1. 环境配置驱动请使用华北一地域镜像：ImageName：驱动Nodejs
2. 压缩包内有代码和相关驱动配置；如镜像不可用可解压缩；不过需要自行配置语言环境

---


