# Testing Xiaonasen · 小纳森

[简体中文](TESTING.md) · **English**

## Model-free checks

`scripts/test.ps1` starts separate application processes:

| Check | Coverage |
| --- | --- |
| `--appearance-test` | Themes, HEX, opacity, scale, anchoring, cancel restoration, range validation |
| `--compact-test` | Circle, animations, five-second idle collapse, recording/processing visibility, rapid reversal, retained results |
| `--reliability-test` | Cancel stalled recognition/cleanup/translation within 500 ms, stale-result isolation, 12-second cleanup fallback, lossless ten-minute audio partitioning, long text/Unicode, UI heartbeat |
| `--hotkey-test` | Ctrl+E, immediate rebinding, old-key release, persistence, invalid combinations, conflict/save-failure rollback, exit cleanup |
| `--language-key-test` | Recording-only T, both output modes, session/preference consistency, Chinese preview retention, ignored queued events, 30 registration cycles, cancel/exit cleanup |

Windows CI runs these without models, microphone access, or typing into other apps.

`-Interactive` adds `--window-test`: Ctrl+E, repeated showing, input focus, mouse pass-through for both overlay states, Alt interaction, and full-opacity pass-through. Exit the running app and use an interactive desktop.

`-Stress` adds 40 complete animation cycles and 10 rapid reversals after warmup. It checks private memory, GDI/USER objects, bitmaps, and timers. The test message pump adds overhead; its frame count does not measure desktop refresh rate.

## Complete speech pipeline

`-WithRuntime` adds `--self-test`, `--translation-test`, and `--recovery-test`. These need a compatible engine/models, a microphone, and a local Chinese SAPI voice. Coverage includes encoding, device lifecycle, previews, final recognition, cancellation/recovery, cleanup, translation of numbers/negation/questions/terms/long passages, and model unloading. Do not run alongside an app using the same local port.

## Local observations

On one development device, the unloaded UI working set was about 43 MB, with about 25 MB private memory. An eight-second idle CPU sample was near zero; startup to input-idle took about 816 ms. Animation checks showed zero GDI/USER growth and approximately 3.33 MB private-memory growth after warmup. These exclude active model memory and do not generalize to all devices or prove that crashes cannot occur.

Reports are excluded from Git. Public documentation contains aggregate findings rather than raw device information, usernames, paths, or dictated content.

The real-engine recovery check uses locally synthesized Chinese speech without microphone capture. It tests cancel/stop, reload, recognition after cancellation, multi-part speech, and unloading. This development-device run observed 5.67 s cold startup, 0.61 s short-phrase ASR, and approximately 1 ms cancel/stop. These are not cross-device guarantees.
