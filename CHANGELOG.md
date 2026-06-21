# Changelog

所有对本项目的显著更改都将记录在此文件中。

本文档格式基于 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)，
并遵循 [语义化版本](https://semver.org/lang/zh-CN/)。

## [1.1.0] - 2026-06-21

### Added
- 新增一键调优脚本（`update_threads_18b.ps1` / `update_threads_28b.ps1`）
  - 自动运行 `katago benchmark` 并提取推荐的 `numSearchThreads`
  - 自动更新 `default_gtp.cfg` 中的线程数配置
  - 支持 18B 和 28B 两个权重版本独立调优
- **【强烈推荐】** 新增根目录一键调优启动器 **`点我首次运行调优.bat`**（零门槛首选方式）
  - 双击即可依次自动调优 18B 和 28B 两个模型，无需打开任何文件夹
  - 中间无暂停，全程自动化，降低误操作可能性
  - 让不熟悉电脑的用户也能轻松完成性能调优
- 新增 `PERFORMANCE.md` 基准性能参考表
- 新增 `run_benchmark_18b.bat` / `run_benchmark_28b.bat` 单独调优启动脚本

### Changed
- 更新 `README.md`，增加一键调优使用说明
- 增强脚本的跨环境兼容性，优化配置文件处理
- 改进 PowerShell 脚本对中文路径的兼容性

## [1.0.0] - 2026-06-20

### Added
- 初始版本发布
- 集成 Lizzieyzy + KataGo OpenCL 版
- 包含 18B 和 28B 两个权重
- 支持 Windows 平台开箱即用
- 广泛硬件兼容性测试（Intel Xe / AMD 6000 / RTX 10系/50系）