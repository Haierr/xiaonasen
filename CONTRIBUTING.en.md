# Contributing to Xiaonasen · 小纳森

[简体中文](CONTRIBUTING.md) · **English**

Build on Windows x64 with .NET Framework 4.8. The source entry point is `src/SaymoreLite.cs`. Keep the native footprint small and load models on demand.

```powershell
.\build.ps1
.\scripts\test.ps1
# Interactive desktop required; exit the running app to release Ctrl+E
.\scripts\test.ps1 -Interactive -Stress
# Complete runtime, microphone, and local Chinese SAPI voice required
.\scripts\test.ps1 -WithRuntime
.\scripts\package.ps1
```

Run relevant model-free checks for UI/shortcut changes and actual runtime checks for recognition, cleanup, translation, or setup changes. Reports are in `dist/`. Never commit personal recordings, dictated text, logs, settings, or models.

Stop, cancel, and exit must release recording resources and temporary shortcuts. Preserve input focus. Automatic insertion must not press Enter; retain text for copying if the foreground changes. Preserve third-party attribution.

Issues should include Windows/app versions, reproduction steps, and expected/actual behavior. Remove personal paths, dictated content, and secrets from diagnostics. Pull requests should explain the behavior change and checks performed.
