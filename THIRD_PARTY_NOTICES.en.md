# Credits and third-party resources

[简体中文](THIRD_PARTY_NOTICES.md) · **English**

This project maintains the native C# interface, recording, shortcuts, mouse pass-through, animations, and insertion workflow.

The ASR protocol, LoRA conventions, and conservative cleanup approach draw on [frankzch/Saymore v1.2.0](https://github.com/frankzch/Saymore/tree/v1.2.0), pinned to `eacb338353820358a033aebe0b43bc59e07ee6cc`. Its copyright and [MIT license](licenses/Saymore-MIT.txt) are preserved. This project is independently maintained.

Runtime resources are downloaded separately and excluded from the repository and lightweight ZIP:

| Component | Source and terms |
| --- | --- |
| llama.cpp b10034 Windows Vulkan | [llama.cpp](https://github.com/ggml-org/llama.cpp/releases/tag/b10034); MIT, with other bundled dependencies subject to their own notices |
| Qwen3-ASR-1.7B GGUF and audio encoder | [ModelScope quantization repository](https://modelscope.cn/models/frankzch/Qwen3-ASR-1.7B-GGUF), based on [Qwen3-ASR](https://github.com/QwenLM/Qwen3-ASR); consult model cards and licenses |
| multi-lora.gguf and basic_prompt.txt | [Saymore polish_lora](https://github.com/frankzch/Saymore/tree/v1.2.0/polish_lora); retain the upstream MIT notice |
| .NET Framework / System.Speech | Microsoft components installed in Windows; not redistributed |

The coffee artwork is AI-generated for the project. Its image and prompt are in `assets/`; project artwork is offered under the root MIT license.

`runtime-manifest.json` fixes versions, URLs, and SHA-256. Setup does not execute downloaded installers or change Windows security settings.
