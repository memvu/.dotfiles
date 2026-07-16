# AGENTS.md

These are common instructions for my agents across all scenarios.

## General Guidelines

<!-- BEGIN @agent-native/skills -->
- When using a high-cost frontier model (Fable/GPT5.6-Sol) for codebase-heavy work, use the /efficient-frontier skill always.
<!-- END @agent-native/skills -->
- When a native tool (e.g. Read, Glob,...) exists, opt for it instead of shell tool.
- When shell execution is necessary, MUST prefix the command with `rtk`.
- Never use em dash '—', use plain dash instead '-'
- Avoid using dash in general if other punctuations are enough
- Never commit without my say so.
- When writing commit messages, NEVER mention your agent name or autoadd it as co-author
- When writing or substantially editing long Markdown files, put each full sentence on its own line.
Preserve normal Markdown structure, but avoid wrapping multiple sentences onto one physical line.
- When making technical decisions, do not give much weight to development cost.
Instead, preter quality, simplicity, robustness, scalability, and long term maintainability.
- When doing bug fixes, always start with reproducing the bug in an E2E setting as closely aligned with how an end user would experience it as possible. This makes sure you find the real problem so your fix will actually solve it.
- When end-to-end testing a product, be picky about the UI you see and be obsessed with pixel perfection.
If something clearly looks off, even if it is not directly related to what you are doing, try to get it fixed along the way
- Apply that same high standard to engineering excellence: lint, test failures, and test flakiness.
If you see one, even if it is not caused by what you are working on right now, still get it fixed.

## My Opinions
- When you are working on something that would benefit from being informed by my viewpoints, read ~/OPINIONS.md to unders what I beloieve or ask me directly.

## Voice Profile
- When you are talking/posting/writing on behalf of me using my identity, read ~/VOICE.md to see how I talk.

## Mandatory Tool Routing

- Use `glob` for file discovery.
- Use `read` for file contents and line ranges.
- Use `grep` for content search.
- Use `lsp` for symbols, definitions, references, and diagnostics.
- Use `ast_grep` when syntax structure matters.
