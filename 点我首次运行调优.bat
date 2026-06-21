@echo off
title Lizzieyzy KataGo 一键性能调优

echo ===================================================
echo      Lizzieyzy KataGo 一键性能调优 v1.1
echo ===================================================
echo.
echo 即将依次为 18B 和 28B 两个模型运行基准测试，
echo 自动检测你的显卡并设置最佳 numSearchThreads。
echo.
echo 预计耗时：约 2~6 分钟，请耐心等待。
echo 提示：请确保调优时没有运行 Lizzieyzy。
echo.
echo *** 中途不需要任何操作，整个过程自动完成，请勿关闭窗口 ***
echo.
pause
echo.

rem ========== 1/2: 18B 模型调优 ==========
echo ===================================================
echo  [1/2] 正在对 18B 模型进行调优...
echo ===================================================
echo.
cd /d "%~dp0engine_18b"
powershell -ExecutionPolicy Bypass -File "%~dp0engine_18b\update_threads_18b.ps1"
echo.
echo  18B 模型调优完成！接下来将进行 28B 模型调优...
echo  请不要关闭窗口，继续等待即可 ^(约 1~3 分钟^)
echo.

rem ========== 2/2: 28B 模型调优 ==========
echo ===================================================
echo  [2/2] 正在对 28B 模型进行调优...
echo ===================================================
echo.
cd /d "%~dp0engine_28b"
powershell -ExecutionPolicy Bypass -File "%~dp0engine_28b\update_threads_28b.ps1"
echo.
echo ===================================================
echo      全部调优完成！
echo ===================================================
echo.
echo 两个模型的配置文件已更新，备份文件为：
echo   engine_18b\default_gtp.cfg.bak
echo   engine_28b\default_gtp.cfg.bak
echo.
echo 现在可以启动 Lizzieyzy 使用了！
echo.
pause