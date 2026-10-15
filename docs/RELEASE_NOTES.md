## 小纳森 · Xiaonasen 1.2.4

### 简体中文

修复无声或底噪输入被生成成词表内容并自动填入的问题。

- ASR 不再接收词表作为系统提示；词表和常见术语规范化保留在文字处理阶段。
- 增加本地 WebRTC 语音活动检测。预览、最终转写和 ASR 请求均拦截无语音输入。
- 没有检测到语音时清空本次结果并停止自动填入，包括已有缓存的情况；检测组件不可用时停止处理。
- 覆盖静音、直流、嗡声、底噪、点击声、缓存污染、真实语音和出站请求回归。

检测库约 50 KB，随发行包提供，需要 Microsoft Visual C++ x64 运行库。未新增大模型。背景人声等仍可能被视为语音，检测不能保证排除所有环境声音。

升级前退出旧版，替换程序及 WebRtcVad.dll 等配套文件，保留 settings.json、terms.txt、runtime/。下载包不含大型模型，请核对 SHA256SUMS.txt。

### English

Fix non-speech audio being generated as vocabulary text and automatically inserted.

- Remove vocabulary from the ASR system context; keep vocabulary and term normalization in text processing.
- Gate previews, final transcription, and ASR requests with local WebRTC voice activity detection.
- Clear no-speech results and prevent insertion even with an existing cache. Detection-component failures stop processing.
- Add silence, DC, hum, hiss, click, polluted-cache, real-speech, and outgoing-request regressions.

The approximately 50 KB native detector is included and requires the Microsoft Visual C++ x64 runtime. No large model was added. Background voices may still count as speech; detection cannot reject every environmental sound.

Exit before upgrading. Replace the executable and companion files including WebRtcVad.dll, preserving settings.json, terms.txt, and runtime/. Large models are excluded. Verify SHA256SUMS.txt.
