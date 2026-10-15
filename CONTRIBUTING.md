# 参与开发

**简体中文** · [English](CONTRIBUTING.en.md)

在 Windows x64 上构建，需 .NET Framework 4.8。源码入口为 `src/SaymoreLite.cs`，保持原生依赖和按需模型加载。

```powershell
.\build.ps1
.\scripts\test.ps1
# 需要交互式桌面，先退出正常运行的程序，避免占用 Ctrl+E
.\scripts\test.ps1 -Interactive -Stress
# 需要完整运行环境、麦克风和本机中文 SAPI 语音
.\scripts\test.ps1 -WithRuntime
.\scripts\package.ps1
```

UI/快捷键修改应运行对应的模型无关检查；识别、整理、翻译或资源准备修改应补充实际运行环境验证。检查失败时看 `dist/` 中的报告。不要把私人录音、口述文本、日志、个人配置或模型提交到仓库。

录音与快捷键生命周期必须保证停止、取消和退出后释放资源；浮窗不得抢走输入窗口的焦点。自动粘贴不能自动按回车，前台切换时保留文字供用户复制。保留第三方版权和来源说明。

提交 Issue 请说明 Windows 版本、程序版本、操作步骤与预期/实际结果；错误日志先去掉个人路径、输入内容及其他敏感信息。提交 PR 时说明行为改变和已运行的检查。
