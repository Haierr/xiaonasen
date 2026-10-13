## 小纳森 · Xiaonasen 1.1.1

[中文指南](https://github.com/Haierr/xiaonasen#readme) · [English guide](https://github.com/Haierr/xiaonasen/blob/main/README.en.md)

### 简体中文

首个公开版本：原生 Windows 本地语音输入、实时中文预览、去杂词整理，以及中文口述转英文。

- Ctrl+R 开始 / 结束；录音中 T 切换中文 / 中→英。
- 动漫小咖啡待机、平滑展开和 5 秒自动收回。
- 默认鼠标穿透，Alt 临时操作浮窗，金属配色与外观 DIY。
- 模型按需启动和空闲卸载，自动粘贴不按回车。

下载 ZIP 后解压到可写目录，运行附带的 `setup-runtime.ps1` 准备引擎和约 1.5 GB 的 ASR 模型，再打开 `xiaonasen.exe`。轻量 ZIP 不包含大型模型，也不需要 Python/WebView。已有兼容资源可通过 `-SourceRuntime` 复用。

本应用未签名。请核对 `SHA256SUMS.txt`；完整使用方法、首次模型加载等待、快捷键占用说明和依赖来源见 README。

### English

The first public release of **Xiaonasen · 小纳森**: native Windows dictation for Chinese speech, live Chinese preview, conservative cleanup, and optional Chinese-to-English translation.

- **Ctrl+R** starts/stops recording. Press **T** while recording to switch output language.
- A cute coffee circle expands smoothly and collapses after five idle seconds.
- Mouse pass-through by default; hold **Alt** to interact with the overlay and customize its appearance.
- Load models on demand, unload when idle, and insert text without pressing Enter.

Extract the ZIP into a writable directory, run the included `setup-runtime.ps1` to prepare the engine and approximately 1.5 GB of ASR models, then open `xiaonasen.exe`. Reuse compatible resources with `-SourceRuntime`. The lightweight ZIP excludes large models and does not require Python or WebView.

The app UI currently uses Chinese labels; the English guide explains them. The app is unsigned. Verify `SHA256SUMS.txt` and consult the English guide for setup, first-use model loading, shortcut behavior, and dependency attribution.
