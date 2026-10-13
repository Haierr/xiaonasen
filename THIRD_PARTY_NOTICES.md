# 来源与第三方资源

**简体中文** · [English](THIRD_PARTY_NOTICES.en.md)

小纳森的原生 C# 界面、录音、快捷键、鼠标穿透、动画和粘贴流程由本项目维护。

ASR 请求协议、LoRA 调用约定和保守整理思路参考 [frankzch/Saymore v1.2.0](https://github.com/frankzch/Saymore/tree/v1.2.0)，固定提交 `eacb338353820358a033aebe0b43bc59e07ee6cc`。保留其版权声明与 [MIT 许可](licenses/Saymore-MIT.txt)。本项目不是 Saymore 官方发行版。

运行环境从上游下载，未包含在本仓库或轻量发行包中：

| 组件 | 来源 | 说明 |
| --- | --- | --- |
| llama.cpp b10034 Windows Vulkan | [ggml-org/llama.cpp](https://github.com/ggml-org/llama.cpp/releases/tag/b10034) | 推理引擎；MIT，发行包中的其他依赖以附带许可为准 |
| Qwen3-ASR-1.7B GGUF / 音频编码器 | [frankzch 的 ModelScope 量化仓库](https://modelscope.cn/models/frankzch/Qwen3-ASR-1.7B-GGUF) | 原模型来自 [Qwen3-ASR](https://github.com/QwenLM/Qwen3-ASR)，使用前查看模型卡及其许可 |
| multi-lora.gguf / basic_prompt.txt | [Saymore polish_lora](https://github.com/frankzch/Saymore/tree/v1.2.0/polish_lora) | 文本整理资源，下载时保留上游 MIT 许可 |
| .NET Framework / System.Speech | Windows 安装的 Microsoft 组件 | 不随本项目重新分发 |

咖啡图案由内置 AI 图像生成功能生成，用于本项目图标。原始图像与提示词位于 `assets/`；本项目素材按根目录 MIT 许可提供。

`runtime-manifest.json` 固定资源版本、下载地址与 SHA-256。下载脚本只准备运行资源，不执行下载的安装程序，也不更改 Windows 安全设置。
