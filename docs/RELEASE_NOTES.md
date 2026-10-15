## 小纳森 · Xiaonasen 1.2.0

[中文指南](https://github.com/Haierr/xiaonasen#readme) · [English guide](https://github.com/Haierr/xiaonasen/blob/main/README.en.md)

### 简体中文

- 默认录音快捷键改为 **Ctrl+E**。
- 托盘右键 → **设置与词表** → 点击录音快捷键输入框，按下新组合键并保存，立即生效。
- 快捷键占用或设置保存失败时保留原快捷键；浮窗、托盘和提示同步更新。
- 录音中单独按 **T** 切换中文 / 中→英的操作保持不变。

解压轻量 ZIP 后运行 `setup-runtime.ps1` 准备资源，再打开 `xiaonasen.exe`。升级前退出旧版，只替换程序和配套资源，保留个人 `settings.json`、`terms.txt` 和 `runtime/`。旧配置未指定快捷键时默认使用 Ctrl+E。下载包不含大型模型；核对 `SHA256SUMS.txt`。

### English

- The default recording shortcut is now **Ctrl+E**.
- Right-click the tray → **设置与词表** (Settings and vocabulary), click the recording shortcut field, press a combination, and save. It applies immediately.
- Conflicts and save failures keep the previous shortcut. Overlay, tray, and tooltip hints update together.
- Pressing **T** during recording still switches Chinese output / Chinese-to-English translation.

Extract the lightweight ZIP, run `setup-runtime.ps1`, then open `xiaonasen.exe`. To upgrade, exit the old version and replace app resources while preserving your `settings.json`, `terms.txt`, and `runtime/`. Existing configurations without a shortcut field use Ctrl+E. Large models are excluded; verify `SHA256SUMS.txt`.
