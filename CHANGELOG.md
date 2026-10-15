# 更新记录

## 1.2.3

- 正在录音时，麦克风按钮和外圈显示红色；结束或取消后恢复主题颜色。
- The microphone button and ring turn red while recording and return to theme colors on stop or cancel.

## 1.2.2

- 录音期间增量识别并保留已完成段落，停止后只补未识别的尾段。
- 无新增语音的预览可直接复用；有新增语音则替换未确认尾段，避免重复追加。
- 停止时短暂接收即将完成的识别结果，取消仍立即生效。
- 增加缓存完整性、取消隔离及真实模型的停止后等待对比测试。

### English

- Retain completed segments while recording and recognize only the unfinished tail on stop.
- Reuse previews followed by silence; replace provisional tails when new speech arrives without duplicating text.
- Briefly allow an in-flight result to complete on stop while preserving immediate cancellation.
- Add cache integrity, cancellation isolation, and real-model stop-to-result comparison checks.

## 1.2.1

- 默认快速规则整理，避免每次额外跑 AI；AI 精细整理可选，整次最多 12 秒，失败保留原文。
- 处理中按录音快捷键或点击 × 即可取消，立即终止自有模型；旧任务不能写回新会话。
- 预览仅处理最近 8 秒，降低频率，避免整段重复推理；结束后完整识别。
- 录音上限改为 10 分钟，音频按最多 24 秒分段；长文本分段整理和翻译。
- 英文模式直接翻译，省去前置 AI 整理；引擎停止不再在 UI 线程等待进程退出。
- 增加卡住任务取消、超时回退、长段完整性、真实模型重启恢复验证。

### English

- Default to local rule-based cleanup, with optional AI cleanup capped at 12 seconds and source-preserving fallback.
- Cancel processing with the recording shortcut or ×; stop the owned engine immediately and isolate stale results.
- Preview only the latest eight seconds at a lower frequency; transcribe the complete recording on stop.
- Support recordings up to ten minutes using audio chunks of at most 24 seconds and bounded text chunks.
- Skip redundant cleanup before English translation; never wait for child-process exit on the UI thread.
- Add stalled-task cancellation, timeout fallback, long-input integrity, and real-engine recovery checks.

## 1.2.0

- 默认录音快捷键改为 Ctrl+E。
- 设置中可直接按键自定义录音快捷键，保存后立即生效。
- 快捷键占用或保存失败时保留原组合，界面提示随设置更新。
- 增加 Windows 快捷键注册、切换、持久化和失败回滚检查。

### English

- Change the default recording shortcut to Ctrl+E.
- Capture a custom recording shortcut in Settings and apply it immediately on save.
- Preserve the previous combination on conflicts or save failures; update shortcut hints throughout the UI.
- Add Windows registration, rebinding, persistence, and rollback checks.

## 1.1.1

首个公开发行版。

- 原生 Windows 语音输入与中文实时预览。
- Ctrl+R 开始 / 结束；录音中 T 切换中文 / 中→英。
- 保守去杂词、重复与术语拼写辅助。
- 默认鼠标穿透，Alt 临时操作浮窗。
- 左上角动漫咖啡待机图标、340 毫秒缓动展开、5 秒自动收回。
- 金属主题、自定义颜色、透明度、大小、圆角、位置及多屏设置。
- 按需启动本地模型、空闲卸载、退出时清理自有引擎。
- 公开版默认系统麦克风与可移植模型路径。
- 固定运行资源版本、下载校验、源码构建和轻量打包脚本。

### English

First public release of **Xiaonasen · 小纳森**.

- Native Windows dictation with live Chinese previews, conservative cleanup and vocabulary assistance.
- Ctrl+R starts/stops recording; T switches Chinese output / English translation while recording.
- Mouse pass-through with temporary Alt interaction.
- Anime coffee circle, smooth 340 ms transitions and five-second idle collapse.
- Metallic themes, custom colors, opacity, scale, corners, placement and monitor selection.
- Local models loaded on demand, unloaded when idle, and cleaned up on exit.
- Automatic insertion without pressing Enter, default system microphone and portable model paths.
- Pinned runtime resources, SHA-256 verification, source builds and lightweight packaging.
