# 🎯 Lizzieyzy 围棋AI 整合便携版

一个开箱即用的围棋AI分析工具，基于强大的 KataGo 引擎，集成友好的图形界面，让你轻松体验 AI 围棋的魅力。

---

## ✨ 核心特性

- **双引擎配置**：内置 KataGo **18b** 和 **28b** 两个权重版本，可在软件内一键切换，兼顾性能与棋力。
- **真正便携**：自带 Java 运行环境（OpenJDK 17），无需在电脑上安装任何额外软件，**解压即用**。
- **开箱即用**：所有路径均已配置为相对路径，可随意移动文件夹位置，不影响使用。
- **跨显卡兼容**：基于 OpenCL 通用版，支持 **NVIDIA、AMD、Intel** 等主流显卡。

---

## 🎯 适合谁用？

- 围棋爱好者想用 AI 分析自己的棋局
- 围棋教师用于课堂演示和教学
- 想体验 AI 围棋但对技术配置不熟悉的用户
- 需要便携版围棋AI，随时带在U盘里使用

---

## 🚀 如何使用？

1. 解压压缩包到任意位置（**建议路径不要包含中文和空格**，如 `D:\Lizzieyzy`）
2. 双击桌面上的 **`Lizzieyzy（围棋AI）`** 快捷方式启动
3. 在软件顶部菜单下拉切换 **18b / 28b** 引擎
4. 开始下棋，或导入 `.sgf` 棋谱进行分析
5. 使用说明详情请看：[Lizzieyzy README](https://github.com/yzyray/lizzieyzy/blob/main/README.md) 或者 `程序使用说明_cn.pdf`

---

## ⚠️ 首次启动注意事项

> **首次运行时会自动进行 OpenCL 调优（约 3-5 分钟），这是正常现象，请耐心等待，不要强制关闭程序（在程序内按 "E" 键显示命令窗口以查看进度）。**

- **AMD 显卡用户**：如果启动后报错 `Got nonfinite for policy sum`，请在以下配置文件中添加一行：
  - `engines\engine_18b\default_gtp.cfg`
  - `engines\engine_28b\default_gtp.cfg`

  在文件末尾单独添加一行：

  ```
  openclUseFP16 = false
  ```

  保存后重新启动即可。

- **NVIDIA / Intel 显卡**：通常无需额外配置，直接使用即可。

---

## 📦 文件结构说明

```text
Lizzieyzy-KataGo-Portable_v1.0/
├── engines/
│   ├── engine_18b/          # KataGo 18b 引擎
│   └── engine_28b/          # KataGo 28b 引擎
├── jre/                     # OpenJDK 17 运行环境（自带）
├── config.txt               # 引擎配置文件（已配置相对路径）
├── README.md                # 本说明文件
├── Lizzieyzy-2.5.3-win64.exe # 围棋AI主程序
└── Update_Lizzieyzy.txt     # 更新日志
```

---

## 🙏 鸣谢

本整合包的诞生离不开以下优秀的开源项目，在此向所有作者和维护者致以诚挚的感谢：

| 项目 | 作者 / 组织 | 许可证 | 贡献 |
| :--- | :--- | :--- | :--- |
| **Lizzieyzy** | [yzyray](https://github.com/yzyray) | GPL v3 | 提供优雅的图形界面和丰富的功能集成 |
| **KataGo** | [lightvector](https://github.com/lightvector) | MIT License | 提供世界顶级的开源围棋AI引擎 |
| **OpenJDK** | Oracle / OpenJDK Community | GPL v2 + CE | 提供跨平台的 Java 运行环境 |
| **JOGL** | JogAmp Community | New BSD 2-Clause | 提供 Java 的 OpenGL 绑定，支撑图形渲染 |
| **GlueGen** | JogAmp Community | New BSD 2-Clause | 提供 Java 与原生代码的自动绑定工具 |

### 💝 特别致谢

- 感谢 **KataGo 训练团队** 持续提供高质量的神经网络权重，让 AI 棋力不断突破。
- 感谢所有 **Lizzieyzy 和 KataGo 的用户与贡献者**，你们的反馈和参与让这些项目越来越好。
- 感谢开源社区的无私奉献，让技术惠及更多人。

---

## 📌 许可证声明

本整合包仅是将上述开源组件打包分发，**未修改任何源代码**。各组件均遵循其原始许可证，详见各组件目录下的 `LICENSE` 文件。

- **Lizzieyzy**：GNU General Public License v3.0 → `/LICENSE.txt`
- **KataGo**：MIT License → `/engine_18b/LICENSE` 和 `/engine_28b/LICENSE`
- **OpenJDK**：GPL v2 with Classpath Exception → `/jre/java17/LICENSE`

本整合包仅供学习交流使用，不得用于商业目的。

---

## 📞 获取帮助

如遇到问题，可参考以下渠道：

- Lizzieyzy 官方仓库：[https://github.com/yzyray/lizzieyzy](https://github.com/yzyray/lizzieyzy)
- KataGo 官方仓库：[https://github.com/lightvector/KataGo](https://github.com/lightvector/KataGo)

---

**版本信息**：KataGo v1.16.4 | Lizzieyzy v2.5.3 | OpenJDK 17

**祝你下棋愉快！** 🎋
