# Contributing

Thanks for your interest in Liger Zero! It's a prototype life simulation
game that re-imagines The Sims, built on
[Motive Engine](https://github.com/tonytins/motive-engine). The project is
just getting started, so this guide is short and will change as it grows.

If you want to make content for the game, such as items or interactions,
you want the [modding guide](./modding.md) instead.

## Ways to help

- **Report a bug.** Open an issue with what you expected, what happened, and
  the smallest steps or content that show it.
- **Improve the docs.** If something confused you, it will confuse someone
  else. Fixes to wording and examples are welcome.
- **Write code.** For anything larger than a bug fix, open an issue first so
  we can agree on the approach before you spend time on it.

Simulation rules (motives, free will, actions, content packs) live in Motive
Engine. If a bug or missing feature is in the engine, report or fix it
[there](https://github.com/tonytins/motive-engine) rather than working
around it here.

## Getting set up

You need Swift 6.3 or later. From the repository root:

```sh
swift build        # build the game and tests
swift test         # run the tests
swift run LigerZero
```

## How the Project Is Organized

| Path | What's there |
| --- | --- |
| `Sources/LigerZero/` | The game executable. |
| `Sources/LigerZero/Content/base/` | The base content pack. |
| `Sources/LigerZero/lot.json` | The starting lot. |
| `Tests/LigerZeroTests/` | Swift Testing suites. |
| `docs/` | Contributing and modding guides. |

## What We Look for in a Change

- **It never crashes on bad input.** Content, mods, and saves can be wrong.
  Validate them where they enter the game and report problems with a thrown
  error the game can show. Avoid force unwraps, `try!`, `fatalError`, and
  quietly substituting a default for invalid data.
- **It's deterministic.** Simulation randomness comes from a stored seed, so
  runs can be reproduced.
- **Dependencies are rare.** Motive Engine and Swift Argument Parser are the
  only ones. Ask before adding another.

For code style, the project follows the
[Swift guidelines](../.agents/skills/swift-guidelines/SKILL.md) kept in this
repository: names that read clearly at the call site, documentation comments
on public and non-obvious code, and flat control flow. When existing code and
the guidelines disagree, match the surrounding code.

## Tests

Every change needs tests that show the new behavior and its edge cases.

- Use Swift Testing (`import Testing`, `@Test`), not XCTest.
- Keep tests deterministic: no timing, randomness without a fixed seed, or
  dependence on test order.
- Every crash or bad-input fix comes with a test that failed before the fix.

## Documentation

If a change affects anything content authors can see, update
[modding.md](./modding.md) in the same pull request. Describe only what
works today.

## Pull Requests

Keep each pull request focused on one change. In the description, include:

- the problem and how your change solves it;
- anything that could break existing saves or content;
- how you tested it.

Before opening it, check that `swift build` and `swift test` pass.

## A Note on AI Assistants

The repository includes [AGENTS.md](../AGENTS.md), which gives AI coding
assistants the same expectations as this guide. You don't need to read it,
but if you use an assistant, it will pick those instructions up.
