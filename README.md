# 🎯 Lizzieyzy 围棋AI 整合便携版

一个开箱即用的围棋AI分析工具，基于强大的 KataGo 引擎，集成友好的图形界面，让你轻松体验 AI 围棋的魅力。

---

## ✨ 核心特性

- **双引擎配置**：内置 KataGo 最新的 **18b** 和 **28b** 两个权重版本，可在软件内一键切换，兼顾性能与棋力。
- **一键性能调优**（v1.1 新增）：双击根目录的 `点我首次运行调优.bat`，自动为两个模型完成调优，全程无需任何操作，真正零门槛。
- **真正便携**：自带 Java 运行环境（OpenJDK 17），无需在电脑上安装任何额外软件，**解压即用**。
- **开箱即用**：所有路径均已配置为相对路径，可随意移动文件夹位置，不影响使用。
- **跨显卡兼容**：基于 OpenCL 通用版，支持 **NVIDIA、AMD、Intel** 等主流显卡
- **强悍棋力**：8年老显卡，3年旧核显，每步算3s，轻松打赢职业九段

---

## 🆕 v1.1 新增：一键性能调优

为了让 KataGo 在不同显卡上都能发挥最佳性能，v1.1 版本新增了**一键调优脚本**，使用KataGo官方benchmark指令并自动使用推荐设置以获得更好的性能。
尤其对于性能较好的独立显卡，运行调优后可获得大幅性能提升。（实测在RTX 5080 上优化后分析速度可提升接近一倍 ）

### 为什么需要调优？

KataGo 的 `numSearchThreads`（搜索线程数）直接影响分析速度。设置过低，GPU 性能无法充分发挥；设置过高，调度开销反而拖慢速度。不同显卡的最优值各不相同，例如：
- RTX 5080 推荐 **40** 线程
- RTX 3060 推荐 **16** 线程
- Intel Xe 核显推荐 **4-6** 线程

### 如何使用？

> ⭐ **零门槛推荐**（新手首选）：双击项目根目录的 **`点我首次运行调优.bat`**，脚本会自动依次为两个模型完成调优，途中无需任何操作，等待约 2~6 分钟即可全部完成。

1. 双击根目录的 **`点我首次运行调优.bat`**
2. 脚本将**依次自动**为 18B 和 28B 两个模型运行基准测试
3. 等待全部完成（约 2~6 分钟），过程中无需任何操作
4. 脚本自动提取推荐值并更新 `default_gtp.cfg`，原配置自动备份为 `.bak`

**也可以单独调优某个模型（进阶用户）：**

1. 进入 `engine_18b` 或 `engine_28b` 文件夹
2. 双击运行 `run_benchmark_18b.bat`（或 `run_benchmark_28b.bat`）
3. 等待 benchmark 运行完成（约 1-3 分钟）
4. 脚本自动提取推荐值并更新 `default_gtp.cfg`，原配置自动备份为 `.bak`

> 💡 **提示**：更换显卡或在另一台电脑上使用（存放在U盘里作为便携版时），建议重新运行一次调优脚本以确保最佳性能。
> ⚠️ **注意**：请勿在运行调优脚本时打开 Lizzieyzy，否则可能会导致脚本运行失败。
    

---

## 🎯 适合谁用？

- 围棋爱好者想用 AI 分析自己的棋局
- 围棋教师用于课堂演示和教学
- 想体验 AI 围棋但对技术配置不熟悉的用户
- 需要便携版围棋AI，随时带在U盘里使用

---

## 🚀 如何使用？

### 首次使用

1. 解压压缩包到任意位置（**建议路径不要包含中文和空格**，如 `D:\Lizzieyzy`）
2. 双击文件夹内 Lizzieyzy-2.5.3-win64.exe 即可启动，也可将该程序创建桌面快捷方式方便使用。
3. 在软件顶部菜单下拉切换 **18b / 28b** 引擎
4. 开始下棋，或导入 `.sgf` 棋谱进行分析
5. ⭐ **（强烈推荐）** 运行根目录的 **`点我首次运行调优.bat`**，一键自动完成性能调优

使用说明详情请看：[Lizzieyzy README](https://github.com/yzyray/lizzieyzy/blob/main/README.md)

---

## ⚠️ 首次启动注意事项

> **首次运行时会自动进行 OpenCL 调优（约 3-5 分钟），这是正常现象，请耐心等待，不要强制关闭程序（在程序内按 "E" 键显示命令窗口以查看进度）。**

- **AMD 显卡用户**：如果启动后报错 `Got nonfinite for policy sum`，请在以下配置文件中添加一行：
  - `engine_18b\default_gtp.cfg`
  - `engine_28b\default_gtp.cfg`

  在文件末尾单独添加一行：
  ```text
  openclUseFP16 = false
  ```

保存后重新启动即可。

- **NVIDIA / Intel 显卡**：通常无需额外配置，直接使用即可。

---

## 💻 硬件兼容性与性能参考

### 📊 性能说明（重要）

在 2022 年的 Windows 轻薄平板电脑的核显（i7-1160G7 的 Intel Iris Xe）上，KataGo 18b 运行速度可达 **50+ visits/s**。实测每步棋 **150 visits** 即可中盘击败星阵三星 AI 星猛虎，并在野狐围棋中注册了 AI 账号几乎全胜上野狐 9D（共 70 盘有 2 盘因网络问题掉线超时）。对于配置更高的带有独立显卡的电脑，单位时间棋力会更高，棋力和分析自由度也显著高于民用版绝艺。

---

本整合包已在以下硬件平台上完成兼容性测试：

| 品牌 | 测试型号 |
| :--- | :--- |
| **NVIDIA** | RTX 50 系列, GTX 10 系列, GTX1660Super（图灵架构）|
| **AMD** | RX 6000 系列 |
| **Intel** | Xe 核显（Tiger Lake / Alder Lake 等） |

在之前的 v1.0 版本中，尚未报告有兼容性问题，包括 RTX 20、30、40 系列。若遇到兼容性问题，可查阅 [KataGo 性能调优指南](https://github.com/lightvector/KataGo#tuning-for-performance)（例如 AMD Radeon RX 5700），也可以在 GitHub 上[反馈问题直接提交 issue](https://github.com/Coderchen-001/AI_GO/issues)。

详细的性能数据（visits/s、推荐线程数等）请参阅项目中的 **[PERFORMANCE.md](PERFORMANCE.md)**。

> 如果你的显卡不在列表中，也极大概率可以正常运行（只要支持 OpenCL 1.2 及以上，事实上2012年以后生产的大多数主流显卡基本都支持）。运行一键调优脚本即可自动获取最佳配置。

---

## ❓ 遇到问题？

如果双击 `点我首次运行调优.bat` 或 `run_benchmark_*.bat` 后没有反应或报错，请尝试以下步骤：

1. **右键点击 `.bat` 文件，选择“以管理员身份运行”**，这可以解决大部分权限问题。
2. **确保项目解压路径不包含中文和空格**（如 `D:\Lizzieyzy` 或 `C:\GoTools`）。
3. **如果出现 `CL_PLATFORM_NOT_FOUND_KHR` 错误**，这表示系统未找到 OpenCL 平台。请更新你的显卡驱动，确保其支持 OpenCL 1.2 或更高版本。
4. **如仍无法解决**，请前往 [GitHub Discussions](https://github.com/Coderchen-001/AI_GO/discussions) 提交你的问题，并附上脚本运行时的**完整报错截图**。

---

## 📦 文件结构说明

```text
Lizzieyzy-KataGo-Portable_v1.1/
├── 点我首次运行调优.bat         # 一键调优启动器（推荐，自动调优两个模型）(v1.1)
├── engine_18b/              # KataGo 18b 引擎
│   ├── katago.exe           # KataGo OpenCL 版主程序
│   ├── default_gtp.cfg      # 引擎配置文件
│   ├── update_threads_18b.ps1   # 一键调优脚本 (v1.1)
│   └── run_benchmark_18b.bat    # 一键调优启动器（单独调优 18B）(v1.1)
├── engine_28b/              # KataGo 28b 引擎
│   ├── katago.exe
│   ├── default_gtp.cfg
│   ├── update_threads_28b.ps1   # 一键调优脚本 (v1.1)
│   └── run_benchmark_28b.bat    # 一键调优启动器（单独调优 28B）(v1.1)
├── jre/                     # OpenJDK 17 运行环境（自带）
├── config.txt               # 引擎配置文件（已配置相对路径）
├── README.md                # 本说明文件
├── PERFORMANCE.md           # 性能基准参考 (v1.1)
├── CHANGELOG.md             # 版本更新日志 (v1.1)
├── Lizzieyzy-2.5.3-win64.exe # 围棋AI主程序
└── Update_Lizzieyzy.txt     # Lizzieyzy 更新日志
```

## 🙏 鸣谢

本整合包的诞生离不开以下优秀的开源项目，在此向所有作者和维护者致以诚挚的感谢：

| 项目 | 作者 / 组织 | 许可证 | 贡献 |
| :--- | :--- | :--- | :--- |
| **Lizzieyzy** | yzyray | GPL v3 | 提供优雅的图形界面和丰富的功能集成 |
| **KataGo** | lightvector | MIT License | 提供世界顶级的开源围棋AI引擎 |
| **OpenJDK** | Oracle / OpenJDK Community | GPL v2 + CE | 提供跨平台的 Java 运行环境 |
| **JOGL** | JogAmp Community | New BSD 2-Clause | 提供 Java 的 OpenGL 绑定，支撑图形渲染 |
| **GlueGen** | JogAmp Community | New BSD 2-Clause | 提供 Java 与原生代码的自动绑定工具 |

## 💝 特别致谢

感谢 KataGo 训练团队 持续提供高质量的神经网络权重，让 AI 棋力不断突破。

感谢所有 Lizzieyzy 和 KataGo 的用户与贡献者，你们的反馈和参与让这些项目越来越好。

感谢开源社区的无私奉献，让技术惠及更多人。

## 📌 许可证声明

本整合包仅是将上述开源组件打包分发，未修改任何源代码。各组件均遵循其原始许可证，详见各组件目录下的 LICENSE 文件。

- **Lizzieyzy**：GNU General Public License v3.0 → `/LICENSE.txt`
- **KataGo**：MIT License → `/engine_18b/LICENSE` 和 `/engine_28b/LICENSE`
- **OpenJDK**：GPL v2 with Classpath Exception → `/jre/java17/LICENSE`

本整合包仅供学习交流使用，不得用于商业目的。

## 📞 获取帮助

如遇到问题，可参考以下渠道：

- **Lizzieyzy 官方仓库**：[https://github.com/yzyray/lizzieyzy](https://github.com/yzyray/lizzieyzy)
- **KataGo 官方仓库**：[https://github.com/lightvector/KataGo](https://github.com/lightvector/KataGo)
- **讨论区交流**：[AI GO 讨论区](https://github.com/Coderchen-001/AI_GO/discussions/1)

**版本信息**：KataGo v1.16.4 | Lizzieyzy v2.5.3 | OpenJDK 17

祝你下棋愉快！ 🎋
