# AGENTS.md: guide for AI agents and contributors

Liger Zero (TSO LZ) is a prototype life simulation game that re-imagines
The Sims. It's written in **Swift only** (Swift 6.3, language mode 6)
as a Swift package, and builds on
[Motive Engine](https://github.com/tonytins/motive-engine), the owner's
needs-driven simulation library. Write the name as **Liger Zero** in prose
and docs; the package and target are `LigerZero`. The project is at its
starting point, so expect this guide to change as it grows. Read this file
first, then `docs/`.

## 1. Orientation

| Read | Why |
|---|---|
| [README.md](./README.md) | What the project is, requirements, license |
| [docs/contributing.md](./docs/contributing.md) | Setup, layout, principles, tests, pull requests |
| [docs/modding.md](./docs/modding.md) | The content-pack format as modders see it |
| [.agents/skills/swift-guidelines/SKILL.md](./.agents/skills/swift-guidelines/SKILL.md) | Swift style: naming, documentation, control flow, extensions, tests |
| [Motive Engine docs](https://github.com/tonytins/motive-engine/tree/main/docs) | How the engine's motives, items, free will, sessions, and content packs work |

## 2. Workspace map

```text
Sources/LigerZero/           the game executable
  Content/base/              the base content pack (pack.json, items.json)
  lot.json                   the starting lot
Tests/LigerZeroTests/        Swift Testing suites
docs/                        contributing and modding guides
```

**The engine and the game stay separate.**
- Simulation rules live in Motive Engine. If the game needs engine behavior
  that doesn't exist or doesn't work, fix it upstream in `motive-engine`
  rather than working around it here, and note the dependency in the change.
- Use only Motive Engine's public API.
- Content files follow Motive Engine's schemas (linked by `$schema`). Don't
  invent fields the engine doesn't decode.

## 3. Golden rules

### Never crash

Players will load content and mods into the game. Malformed content, a bad
save, or a broken script must produce an error the game can report, never a
trap.

- **No traps in `Sources/`.** No force unwraps (`!`), `try!`, `as!`,
  implicitly unwrapped optionals, `fatalError`, or `precondition`. Throw a
  typed error and handle it where the game can show it.
- **No silent fallbacks for bad content.** A default is fine when it's the
  documented meaning of valid input. Invalid content is reported, never
  quietly replaced.
- **Prove it.** Every crash or bad-input fix comes with a small regression
  test that failed before the fix.

### Project rules

1. **Dependencies.** Motive Engine and Swift Argument Parser are the only
   dependencies. Don't add another without the owner's approval.
2. **Deterministic simulation.** Take randomness from a stored seed and
   don't read the clock inside simulation logic, so runs can be reproduced.
3. **Tests are the gate.** Swift Testing (`import Testing`, `@Test`), never
   XCTest. Keep tests deterministic.
4. **Document public and non-obvious code**, and call out breaking changes
   (save formats, content formats, engine version bumps) in the change.
5. **Follow the [Swift guidelines](./.agents/skills/swift-guidelines/SKILL.md)**,
   and match the surrounding code when they disagree.
6. **Measure before optimizing.**

## 4. Before you finish a task

```sh
swift build
swift test
swift run LigerZero                                       # if you touched startup, content, or the lot
grep -rnE 'try!|as!|fatalError|precondition' Sources      # must print nothing
```

Keep [docs/modding.md](./docs/modding.md) true for anything content authors
can see, and describe only what works today. Keep the tree building and the
tests green at every step; the git log is how the next session picks up.

## 5. Content formats

Content files are a public contract with modders.

- Optional new fields keep existing packs loading. A change existing packs
  can't load needs a new pack `version`; say so in the change.
- Content errors name the file at fault, and no pack reads outside its own
  folder.
