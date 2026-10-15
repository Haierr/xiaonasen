<p align="center"><img src="assets/coffee-logo.png" width="82" alt="Xiaonasen · 小纳森"></p>

<p align="center"><a href="README.md">简体中文</a> · <strong>English</strong></p>

<p align="center"><img src="assets/hero.svg" width="100%" alt="Xiaonasen · 小纳森 — Speak naturally. Write effortlessly."></p>

<p align="center">
  <a href="https://github.com/Haierr/xiaonasen/releases/latest"><img src="https://img.shields.io/github/v/release/Haierr/xiaonasen?style=flat-square&amp;label=release&amp;color=ceb17a" alt="Latest release"></a>
  <a href="https://github.com/Haierr/xiaonasen/actions/workflows/windows.yml"><img src="https://github.com/Haierr/xiaonasen/actions/workflows/windows.yml/badge.svg" alt="Windows build and checks"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-ceb17a?style=flat-square" alt="MIT license"></a>
  <img src="https://img.shields.io/badge/platform-Windows%20x64-6d7780?style=flat-square" alt="Windows x64">
</p>

<p align="center"><a href="https://github.com/Haierr/xiaonasen/releases/latest"><strong>Download Xiaonasen · 下载小纳森</strong></a> &nbsp; / &nbsp; <a href="#get-started">Get started</a> &nbsp; / &nbsp; <a href="README.md#安装">中文指南</a></p>

# Xiaonasen · 小纳森

Lightweight, local Chinese dictation for Windows. Press **Ctrl+E** to speak and insert cleaned text into your original input field. Press **T** while recording to translate your Chinese dictation into English.

A small coffee on your desktop. Clear feedback while you speak. A native Windows app that processes your speech locally.

## At a glance

| A small desktop presence | Feedback you can see | Speak Chinese, write English |
| --- | --- | --- |
| Coffee circle · Smooth expansion · Collapse after 5 seconds | Audio waveform · Listening status · Chinese preview | Press T while recording · Translate and insert when finished |

<p align="center"><img src="docs/recording-demo.png" width="440" alt="Xiaonasen · 小纳森 recording interface"></p>

<p align="center"><sub>UI preview · 界面示例</sub></p>

## Features

- **A coffee when idle.** The small circle expands smoothly when recording starts and collapses after five idle seconds following completion.
- **Live feedback.** The waveform follows microphone volume; listening status and Chinese text previews update as you speak.
- **Chinese or English output.** Press T while recording to switch between cleaned Chinese and an English translation of your Chinese speech.
- **Conservative cleanup.** Remove fillers and repetition, with a vocabulary list to help preserve technical names and spelling.
- **Mouse pass-through.** Click the application behind the overlay. Hold Alt to interact with the overlay itself.
- **Appearance customization.** Metallic themes, HEX colors, opacity, scale, corners, placement, and monitor selection.
- **Models loaded on demand.** Unload after 30 idle seconds by default; the microphone is closed while idle.
- **You decide when to send.** Insert text with Ctrl+V without pressing Enter. If the foreground window changes, retain the result for copying.

**Language support:** this release is designed for **Chinese speech**, with Chinese text or Chinese-to-English translation as output. Its app menus currently use Chinese; the label guide below helps you navigate them. The bilingual documentation does not imply an English-localized app interface or a separately validated English dictation mode.

## Get started

You need Windows 10 / 11 x64, .NET Framework 4.8, a working microphone, and a writable application directory. The validated engine is llama.cpp b10034 for Windows Vulkan; GPU drivers need Vulkan support. CPU-only performance and compatibility should be checked on your device. Neither the repository nor the lightweight ZIP includes the approximately 1.5 GB ASR models.

1. Download `xiaonasen-*-windows-x64.zip` from [Releases](https://github.com/Haierr/xiaonasen/releases), then extract it to a writable directory such as `D:\Xiaonasen`.
2. Run the following in that directory:

   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -File .\setup-runtime.ps1
   ```

   This execution-policy option applies only to this PowerShell process. The script downloads fixed engine and cleanup resources, plus ASR models, and checks SHA-256. Initial setup requires internet access and roughly 2 GB of free disk space. Interrupted downloads keep their `.part` files for resuming.
3. Open **xiaonasen.exe**. It uses your default system microphone and looks for resources in `runtime/` beside the executable. For manual configuration, copy `settings.example.json` to `settings.json` and edit it.

To reuse an existing compatible runtime:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\setup-runtime.ps1 -SourceRuntime "D:\ExistingApp\runtime"
```

The app is not code-signed. Download from this repository's Release and check the ZIP against `SHA256SUMS.txt`. Keep your system protections enabled.

## Everyday controls

| Action | Result |
| --- | --- |
| Focus an input field, then **Ctrl+E** | Start recording and expand the overlay |
| Release Ctrl+E, then press **T** while recording | Chinese output ↔ Chinese-to-English translation |
| **Ctrl+E** again | Stop, clean up, and insert text in the selected output language |
| Hold **Alt** | Click, copy, drag, or right-click the overlay |
| Right-click the tray icon | Settings, vocabulary, appearance, previous result, language, model unloading, or exit |

T is reserved only during recording. It returns to normal typing when recording stops, is canceled, enters processing, or the app exits. The default Ctrl+E overrides the same shortcut in other applications while Xiaonasen is running. If another global tool occupies a shortcut, use the tray or hold Alt and click the corresponding control.

Recordings are limited to 90 seconds. On first use or after unloading, model preparation takes a few seconds while audio capture starts immediately. The preview remains Chinese; English translation happens after recording ends. Check names, numbers, and specialized content. Some fields, permission-level differences, or applications that do not support Ctrl+V may require manual copying.

### Chinese labels in the app

| Label | Meaning |
| --- | --- |
| 中文 | Chinese output |
| 中→英 | Translate Chinese speech into English |
| 已听到你的声音 | Your voice is being detected |
| 正在聆听 | Listening |
| 正在识别 / 正在整理 / 正在翻译成英文 | Recognizing / cleaning up / translating into English |
| 复制 | Copy |
| 设置与词表 | Settings and vocabulary |
| 外观 DIY | Appearance customization |
| 查看上次结果 | View the previous result |
| 立即释放模型 | Unload the model now |
| 退出 | Exit |

## Make it yours

Choose **外观 DIY** from the tray or hold Alt and click **DIY**. Adjust champagne gold, platinum, rose gold, custom HEX colors, opacity, scale, corners, and placement. Select a monitor, anchor to a screen corner, or drag manually. Changes preview immediately; save to keep them, or cancel to restore the previous appearance.

![Appearance panel preview](docs/appearance-demo.png)

To customize recording, open **设置与词表**, click the shortcut field, press a combination, and save. Changes apply immediately without restarting. Use Ctrl or Alt with a letter, digit, function key, or another supported key. Conflicts preserve the previous shortcut. The default is Ctrl+E; recording-only T is unchanged.

Choose **设置与词表** to select a microphone and configure cleanup, automatic insertion, output language, and model-unloading time. Add one term per line in `terms.txt`. The public defaults contain general technical terms, not the developer's personal vocabulary.

## Resources and privacy

The app uses native WinForms with no resident Python or WebView runtime. Audio is held in local memory. Recognition, cleanup, and translation call `127.0.0.1:18902`; the app does not upload recordings or save dictated-text history. Resource setup accesses GitHub and ModelScope separately. The app does not automatically download resources or check for updates.

On one development Windows device, the UI working set after model unloading was approximately **43 MB**, an eight-second idle CPU sample was near zero, and startup to input-idle took about **0.8 seconds**. These observations exclude active model memory/VRAM and are not cross-device guarantees. Repeated animation checks showed no GDI/USER object growth. See [Testing](docs/TESTING.en.md).

## Build from source

```powershell
git clone https://github.com/Haierr/xiaonasen.git
cd xiaonasen
powershell -NoProfile -ExecutionPolicy Bypass -File .\build.ps1
# UI and shortcut checks do not require models
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\test.ps1
# Large runtime files stay in dist/runtime and outside Git
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\setup-runtime.ps1
```

The output is `dist/xiaonasen.exe`. The build uses the installed .NET Framework compiler with no NuGet dependencies. Packaging uses an explicit allowlist to exclude personal settings, logs, and models. See [Contributing](CONTRIBUTING.en.md) and [Security](SECURITY.en.md).

## Credits and license

MIT. The ASR protocol and cleanup approach draw on [Saymore v1.2.0](https://github.com/frankzch/Saymore/tree/v1.2.0), preserving frankzch's copyright and license. Runtime resources use Qwen3-ASR, Saymore's cleanup LoRA, and llama.cpp under their respective upstream terms. The coffee artwork is AI-generated; its prompt is in `assets/coffee-prompt.txt`. See [Third-party notices](THIRD_PARTY_NOTICES.en.md).

---

<p align="center"><strong>Xiaonasen · 小纳森</strong><br>Speak naturally. Write effortlessly.<br><a href="README.md">阅读完整中文指南 →</a></p>
