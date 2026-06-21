# KataGo 18B 权重性能基准测试报告（最终版）

> **测试环境**  
> - KataGo 版本：OpenCL 版（18B 权重 `kata1-b18c384nbt-s9996604416-d4316597426`）  
> - 测试参数：固定 800 visits/局，自动搜索最优线程数  
> - 测试日期：2026-06-21  

---

## 一、性能总览（峰值 visits/s 排名）

| 排名 | 硬件型号 | 峰值访问速度 (visits/s) | 相对性能 (vs RTX 5080) | 推荐线程数 | FP16 / Tensor Core 支持 |
|:----:|----------|------------------------:|------------------------:|:----------:|:-----------------------:|
| 1    | **NVIDIA RTX 5080** | **2069.20** | 100% (基准) | 48 | ✅ Tensor Cores, FP16存储 |
| 2    | **AMD RX 6900 XT**  | **420.65**  | 20.3%      | 12 | ✅ FP16计算，无Tensor Core |
| 3    | **NVIDIA GTX 1070 Ti** | **270.30** | 13.1%      | 10 | ❌ 无FP16支持 |
| 4    | **NVIDIA GTX 1660 Super** | **195.43** | **9.4%**   | 12 | ✅ FP16存储，无Tensor Core |
| 5    | **Intel Iris Xe** (i7-1160G7) | **54.00** | 2.6%       | 5  | ✅ FP16计算，无Tensor Core |

> **注意**：峰值访问速度为各硬件在自动调优过程中测得的最高 `visits/s` 值（取10局平均），推荐线程数由KataGo基于访问速度与MCTS效率综合估算给出。

---

## 二、各硬件详细性能数据

### 1. NVIDIA GeForce RTX 5080
- **OpenCL 平台**：NVIDIA CUDA (OpenCL 3.0 CUDA 13.1.123)  
- **FP16 配置**：`FP16Storage=true, FP16Compute=false, FP16TensorCores=true`  
- **自动调优**：已有调优缓存（`tune11_gpuNVIDIAGeForceRTX5080...`）  
- **测试耗时**：约 11.6 秒（低线程）至 4.2 秒（高线程）  
- **峰值数据**：`numSearchThreads=80` → visits/s=2069.20, nnEvals/s=2011.34, avgBatchSize=48.11  
- **推荐配置**：`numSearchThreads=48`（估算 Elo 增益 +329，与40/64线程接近但MCTS效率更优）  

---

### 2. AMD Radeon RX 6900 XT (gfx1030)
- **OpenCL 平台**：AMD Accelerated Parallel Processing (OpenCL 2.1 AMD-APP 3652.0)  
- **FP16 配置**：`FP16Storage=true, FP16Compute=true, FP16TensorCores=false`  
- **自动调优**：已有调优缓存（`tune11_gpugfx1030...`）  
- **测试耗时**：约 27 秒（低线程）至 19 秒（高线程）  
- **峰值数据**：`numSearchThreads=16` → visits/s=420.65, nnEvals/s=357.63, avgBatchSize=7.83  
- **推荐配置**：`numSearchThreads=12`（与16线程Elo估算相同，但线程数更少，MCTS开销更低）  

---

### 3. NVIDIA GeForce GTX 1070 Ti
- **OpenCL 平台**：NVIDIA CUDA (OpenCL 3.0 CUDA 12.6.65)  
- **FP16 配置**：`FP16Storage=false, FP16Compute=false, FP16TensorCores=false`（完全不支持）  
- **自动调优**：首次运行执行完整 autotune（约 55 秒），并生成调优缓存  
- **测试耗时**：约 39 秒（低线程）至 30 秒（高线程）  
- **峰值数据**：`numSearchThreads=20` → visits/s=270.30, nnEvals/s=235.68, avgBatchSize=9.81  
- **推荐配置**：`numSearchThreads=10`（估算 Elo 增益 +48，优于其他高线程选项）  

---

### 4. NVIDIA GeForce GTX 1660 Super
- **OpenCL 平台**：NVIDIA CUDA (OpenCL 1.2 CUDA 11.1.114)  
- **FP16 配置**：`FP16Storage=true, FP16Compute=false, FP16TensorCores=false`（仅FP16存储加速）  
- **自动调优**：首次运行执行完整 autotune（约 3 分钟），自动启用 FP16 存储（`Enabling FP16 storage due to better performance`）  
- **测试耗时**：约 52 秒（低线程）至 42 秒（高线程）  
- **峰值数据**：`numSearchThreads=20` → visits/s=195.43, nnEvals/s=171.14, avgBatchSize=12.25  
- **推荐配置**：`numSearchThreads=12`（估算 Elo 增益 +42，与10线程接近但MCTS效率更优）  

---

### 5. Intel Iris Xe Graphics (i7-1160G7)
- **OpenCL 平台**：Intel OpenCL HD Graphics (OpenCL 3.0 NEO)  
- **FP16 配置**：`FP16Storage=true, FP16Compute=true, FP16TensorCores=false`  
- **自动调优**：已有调优缓存（`tune11_gpuIntelRIrisRXeGraphics...`）  
- **测试耗时**：非常长，低线程约 160 秒，高线程约 150 秒（受限于GPU算力）  
- **峰值数据**：`numSearchThreads=12` → visits/s=54.00, nnEvals/s=46.08, avgBatchSize=5.97  
- **推荐配置**：`numSearchThreads=5`（估算 Elo 增益 +149，高线程反而导致MCTS效率下降）  

---

## 三、性能差距、实战棋力与实际应用建议

### 性能差距
- **RTX 5080** 相比 **RX 6900 XT** 快约 **4.9 倍**，相比 **GTX 1070 Ti** 快约 **7.7 倍**，相比 **GTX 1660 Super** 快约 **10.6 倍**，相比 **Intel Iris Xe** 快约 **38 倍**。  
- **GTX 1660 Super** 虽启用 FP16 存储加速，但因缺乏 Tensor Core，性能仍低于 GTX 1070 Ti（约 72% 的1070 Ti性能），两者定位相近。  
- AMD RX 6900 XT 虽支持 FP16 计算，但缺乏 Tensor Core，导致与 RTX 5080 差距明显。  
- Intel 核显受限于功耗和显存带宽，峰值速度虽低，但通过合理配置仍可达到惊人的实战棋力（见下文）。

---

### 实战棋力表现与使用经验

**实测案例（Intel Iris Xe 核显，50+ visits/s）：**  
在 2022 年 Windows 轻薄平板电脑（i7-1160G7）上，使用 KataGo 18B 权重，**每步仅需 150 visits** 即可在 **中盘阶段击败星阵三星 AI“星猛虎”**，并且在 **野狐围棋** 中注册 AI 账号后，以 **几乎全胜** 的战绩升至 **野狐 9D**（共 70 盘对局，仅 2 盘因网络掉线超时告负）。  

这一结果证明：  
- **极低的算力（50 visits/s）搭配合理的访问量（150 visits/步）** 已经能够达到 **人类顶尖（乃至超一流）** 的棋力水平，足以在主流围棋平台大杀四方。  
- 对于配置更高的独立显卡，**单位时间可完成的 visits 数成倍增加**，意味着在相同时间内可以搜索更深、更广，棋力自然更高；同时，**更大的算力也带来更灵活的分析自由度**（如快速复盘、多分支变化图、高精度形势判断等）。  
- 与 **民用版绝艺** 相比，KataGo 的 **开源可定制性** 使得用户可以自由调整权重、访问量、时间控制等参数，棋力上限和实用性均 **显著高于** 封闭的民用版绝艺。

---

### 推荐配置与场景（含实际棋力参考）

| 硬件 | 适用场景 | 建议线程数 | 推荐每步 visits | 可达到的棋力水平（参考） |
|------|----------|:----------:|:---------------:|------------------------|
| **RTX 5080** | 顶级性能，高强度 AI 对战、大规模复盘、模型训练 | 48 | 1000~5000+ | 远超职业顶尖，可胜任 AI 研究 |
| **RX 6900 XT** | 高性能 AMD 平台，中高段位分析 | 12 | 500~2000 | 人类顶尖以上 |
| **GTX 1070 Ti** | 老款 N 卡，入门级 AI 使用 | 10 | 300~1000 | 职业九段以上，轻松上野狐 9D |
| **GTX 1660 Super** | 中低端 N 卡，轻量级分析，功耗较低 | 12 | 200~800 | 同上 |
| **Intel Iris Xe** | 便携、低功耗场景，移动端使用 | 5  | **100~300** | **野狐 9D（实测全胜）**，足以击败绝大多数 AI |

> **说明**：以上"推荐每步 visits"为经验值，可根据实际对局时间调整。对于核显，150 visits 已足够，更多 visits 可进一步提高棋力但会延长思考时间。
>
> 如果有比较不错的显卡想分析复杂局面，可以用性能更好的 KataGo 28b 版本（速度会稍慢）。

---

### 注意事项

- 所有测试均基于 OpenCL 后端，若使用 CUDA 版本（仅限 N 卡）可能进一步提升性能（尤其带 Tensor Core 的 RTX 系列）。
- 实际对局中，若采用 **固定时间搜索**（如 5 秒/步），线程数需重新权衡；本报告推荐基于固定 800 visits 的 benchmark。
- 建议根据自身硬件配置修改 `default_gtp.cfg` 中的 `numSearchThreads` 参数，以获得最佳性能/效率平衡。
- 对于核显等弱硬件，**不必追求高 visits**，合理设定（如 100~300）即可获得极强棋力，且能大幅缩短等待时间。

---

*本报告由 KataGo 自动基准测试数据生成，结合用户实测经验，所有数值均来自实际运行日志。*