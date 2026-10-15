## 小纳森 · Xiaonasen 1.2.2

### 简体中文

- 录音时增量识别并保存已完成段落，停止后只补尾段，不再整段重跑。
- 静音尾部直接复用预览，新增语音替换未确认尾段，避免重复。
- Ctrl+E、T 切换和立即取消保持不变。

同一段约 61 秒本机合成语音，热模型停止后的转写等待从 1.84 秒降至 0.09 秒。该测试假设前面的段落已完成，不包含冷启动、翻译、AI 整理或粘贴；实际耗时因设备和输入而异。

升级前退出旧版，保留 settings.json、terms.txt 和 runtime/。下载包不含大型模型，核对 SHA256SUMS.txt。

### English

- Recognize incrementally during recording; reuse completed segments and process only the remaining tail on stop.
- Reuse previews followed by silence, and replace provisional tails after new speech without duplicating text.
- Ctrl+E, recording-only T, and immediate cancellation are unchanged.

The same approximately 61-second local synthetic recording measured 1.84 s versus 0.09 s of stop-to-result latency with a warm model and earlier segments already recognized. This excludes cold startup, translation, AI cleanup, and insertion; live performance depends on the device and input.

Exit before upgrading. Preserve settings.json, terms.txt, and runtime/. Large models are excluded. Verify SHA256SUMS.txt.
