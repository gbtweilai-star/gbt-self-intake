# self_intake

**One capability bit from GBT V8, packaged standalone.** No. 171 of 341,
`mind` domain (Mind).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> **未命中即取源 · 自递归改进**（主人令 2026-10-15：「在她的知识库未命中的时候转抓取全网国内外的论文来实现自我递归改进，这样就不会出现自己都不懂的东西就无脑操作了」。回路：**known（先查本地知识库）→ 未命中 ⇒ intake（抓取全网取源）→ 蒸馏胶囊（带出处）→ 钢印护照 + 入 context_vault 索引 → 再查就命中**。op：known/gate/rules（只读）· intake（写）。**主执行器是万能插**（`five-dim.py cap self_intake`），不是传统执行器。铁律：未命中且无出处 ⇒ 拒绝干活；取不到就写「未读到」。

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-self-intake.git
cd gbt-self-intake
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_self_intake info                  # capability card
python -m gbt_self_intake spec --json           # machine-readable contract
python -m gbt_self_intake check --payload '{}'
python -m gbt_self_intake run   --payload '{}'
```

Real `info` output from this machine:

```text
self_intake  (mind)  v1.0.0
----------------------------------------
**未命中即取源 · 自递归改进**（主人令 2026-10-15：「在她的知识库未命中的时候转抓取全网国内外的论文来实现自我递归改进，这样就不会出现自己都不懂的东西就无脑操作了」。回路：**known（先查本地知识库）→ 未命中 ⇒ intake（抓取全网取源）→ 蒸馏胶囊（带出处）→ 钢印护照 + 入 context_vault 索引 → 再查就命中**。op：known/gate/rules（只读）· intake（写）。**主执行器是万能插**（`five-dim.py cap self_intake`），不是传统执行器。铁律：未命中且无出处 ⇒ 拒绝干活；取不到就写「未读到」。

gated      : True   <- needs explicit consent
external   : False
multi-op   : True
params     : (none)
values     : known, gate, rules
```

Wire a real implementation:

```python
from gbt_self_intake import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

**注册表登记的取值 / 子动作（3 个）**：`known`、`gate`、`rules`

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Gated: this bit is marked `safe: false` in the registry — it can change state that no inverse action restores.
- No external service dependency declared.
- Multi-op (`multi_op: true`): several sub-actions share one name — read `op` before calling.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.13s
```

## Provenance

| field | value |
|---|---|
| capability | `self_intake` |
| domain | `mind` |
| handler | `self_intake` |
| safe | `False` (gated = `True`) |
| external | `False` |
| atlas page | [mind/self_intake](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/mind/self_intake.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
