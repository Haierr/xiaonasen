## 小纳森 · Xiaonasen 1.2.1

[中文指南](https://github.com/Haierr/xiaonasen#readme) · [English guide](https://github.com/Haierr/xiaonasen/blob/main/README.en.md)

### 简体中文

这次集中缩短处理路径并修复取消、长段输入和阻塞。

- 默认“识别 → 本地快速整理 → 填入”，不额外跑 AI 整理。旧版用户在设置中关闭“AI 精细整理”即可切换。
- 处理中再按录音快捷键（默认 Ctrl+E），或点击 ×，立即取消并停止自有引擎，保留已有文字供复制。
- 可选 AI 精细整理整次最多等待 12 秒，超时保留原文；英文翻译不再前置 AI 整理。
- 预览只处理最近 8 秒；停止后分段完整识别，录音上限 10 分钟。
- 取消后的旧任务不再覆盖下一次输入，关闭引擎不再阻塞 UI 等待进程退出。

快速规则不会推断口误或改写语义。首次模型加载仍需几秒，实际速度取决于设备。升级前退出旧版，保留 `settings.json`、`terms.txt`、`runtime/`，替换程序和配套资源。下载包不含大型模型，核对 `SHA256SUMS.txt`。

### English

This update shortens the processing path and fixes cancellation, long input, and blocking behavior.

- Default to recognition → local fast cleanup → insertion. Existing users can disable **AI 精细整理** in Settings to use the fast path.
- Press the recording shortcut (Ctrl+E by default) again while processing, or click ×, to cancel immediately, stop the owned engine, and retain available text for copying.
- Optional AI cleanup has a 12-second total budget and keeps the source on timeout. English translation skips the preceding AI cleanup pass.
- Preview only the latest eight seconds; transcribe the full recording in chunks when stopped, up to ten minutes per recording.
- Canceled jobs cannot overwrite the next session, and engine shutdown no longer waits for process exit on the UI thread.

Fast rules do not infer spoken corrections or rewrite meaning. Cold model loading still takes a few seconds and speed depends on the device. Exit the old version before upgrading; preserve `settings.json`, `terms.txt`, and `runtime/`. Large models are excluded. Verify `SHA256SUMS.txt`.
