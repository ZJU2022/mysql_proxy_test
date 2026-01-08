# 使用前说明
1. 目前只有 v6_10_9  v8_3 两个版本驱动；更老的比如1和5的驱动无法连接mysql5.7和8.0

# 使用说明：C# / .NET 驱动测试 MySQL Proxy

本文档指导如何在 Linux (CentOS) 使用 **Mono** 执行 C# 程序，连接 MySQL Proxy 测试不同版本的 MySQL Connector/NET 驱动。

---

## 1. 环境准备

### 1.1 安装 Mono

确保系统已安装 Mono：

```bash
mono --version
mcs --version
```

如果未安装，请参考 Mono 官网：[https://www.mono-project.com/download/stable/](https://www.mono-project.com/download/stable/)

> 建议 Mono 6.x 或更高版本

### 1.2 设置环境变量

在执行程序前，需要设置 MySQL Proxy 连接信息：

```bash
export PROXY_HOST=10.9.175.56
export PROXY_PORT=3306
export DB_USER=root
export DB_PASS=123456
```

---

## 2. 驱动文件

项目目录中，每个驱动版本都有自己的文件夹：

```
Net/
├─ v6_10_9/       # MySQL Connector/NET 6.10.9
│   ├─ MySql.Data.dll
│   └─ Program.cs
├─ v8_3/          # MySQL Connector/NET 8.3.x
│   ├─ MySql.Data.dll
│   └─ Program.cs
```

> 每个文件夹下 **Program.cs** 为测试程序，MySql.Data.dll 为对应版本的 MySQL Connector/NET 驱动。

---

## 3. 编译与执行

以 **v8_3** 驱动为例：

1. 进入对应目录：

```bash
cd /opt/mysql_proxy_test/Net/v8_3
```

2. 编译 C# 程序：

```bash
mcs \
  -r:System.Data \
  -r:System.Xml \
  -r:MySql.Data.dll \
  Program.cs
```

* `-r:System.Data` / `-r:System.Xml`：引用 Mono 自带的基础类库
* `-r:MySql.Data.dll`：引用对应驱动 DLL

> 编译成功后会生成 `Program.exe`

3. 执行程序：

```bash
mono Program.exe
```

如果连接成功，会输出类似：

```
✓ SUCCESS (driver ok), SELECT 1 = 1
```

如果失败，会输出错误信息，例如：

```
✗ FAILED: #HY000unsupport COM_CHANGE_USER.
```

---

## 4. 注意事项

1. **驱动兼容性**：

   * v6_10_9 驱动适用于较老的 .NET Framework，但在 Mono 上可能编译失败。
   * v8_3 / v9_4 驱动使用 **netstandard2.0** 或 **net6.0**，在 Mono 6.x 上可直接编译运行。

2. **环境变量**：必须先设置 `PROXY_HOST`, `PROXY_PORT`, `DB_USER`, `DB_PASS`。

3. **清理旧编译文件**：

   ```bash
   rm -f Program.exe
   ```

4. **Mono 提示缺少 System.Data**：

   * 如果报类似 `CS0012: System.Data.Common.DbConnection` 的错误，需确保 `-r:System.Data` 引用正确。
   * 在 CentOS 上通常位于 `/usr/lib/mono/4.5/System.Data.dll`，可写全路径引用：

   ```bash
   mcs -r:/usr/lib/mono/4.5/System.Data.dll -r:/usr/lib/mono/4.5/System.Xml.dll -r:MySql.Data.dll Program.cs
   ```

---

## 5. 示例执行

```bash
cd /opt/mysql_proxy_test/Net/v8_3
export PROXY_HOST=10.9.175.56
export PROXY_PORT=3306
export DB_USER=root
export DB_PASS=123456
rm -f Program.exe
mcs -r:System.Data -r:System.Xml -r:MySql.Data.dll Program.cs
mono Program.exe
```

输出：

```
✓ SUCCESS (driver ok), SELECT 1 = 1
```

