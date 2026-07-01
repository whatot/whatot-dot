---
name: diagram-code
description: "用于生成或维护 Mermaid、D2、PlantUML 等 code-as-graph 架构图、流程图、时序图、状态图和数据流图；匹配画图、架构图、流程图、sequence、state、graph as code；强调可编辑、可追溯。"
---

# Diagram Code

Use this skill when the desired artifact is graph source code, not a screenshot
or raster image. Prefer a small, maintainable diagram that can be reviewed in
git and adjusted by hand.

## Core Contract

- Output graph code first: Mermaid, D2, PlantUML, DOT, or an existing repo
  diagram format.
- Do not generate PNG/JPEG/WebP unless the user explicitly asks for rendered
  assets.
- Preserve traceability: every non-obvious node or edge should map back to a
  source file, config, doc section, command output, or user-provided statement.
- Include traceability in the same answer or file by default; do not make the
  user ask for it after seeing the diagram.
- Keep diagrams small enough to maintain. Split views by architecture layer,
  workflow, sequence, lifecycle, or data flow instead of making one giant graph.
- Reuse existing diagram files, naming, style, and language in the repo before
  introducing a new format.

## Diagram Type Gate

Before drawing, choose the diagram by the question it must answer:

| Question                                       | Diagram                     | Default format               |
| ---------------------------------------------- | --------------------------- | ---------------------------- |
| Who uses the system and why?                   | Use case or context         | PlantUML usecase / Mermaid   |
| What parts exist and where are the boundaries? | Architecture / C4           | D2                           |
| What steps happen in order?                    | Workflow / flowchart        | Mermaid flowchart            |
| Who calls whom during one request?             | Sequence                    | Mermaid or PlantUML sequence |
| What states can an object enter?               | State / lifecycle           | Mermaid or PlantUML state    |
| Where does data move and transform?            | Data flow / lineage         | D2                           |
| What runs where?                               | Deployment / infrastructure | D2                           |

If the user names a diagram type but the question implies another type, state the
fit issue briefly and use the better type unless they explicitly insist.

## Workflow

1. Establish the target view with the Diagram Type Gate.
   - Architecture: components, boundaries, dependencies, deployment shape.
   - Workflow: ordered steps, actors, gates, retries, observability.
   - Sequence: caller/callee order, sync/async calls, returns, failures.
   - State/lifecycle: states, events, terminal outcomes.
   - Data flow: producers, transforms, stores, consumers, sensitivity.

2. Gather evidence before drawing.
   - Read existing diagrams, README/docs, manifests, routes, schemas, service
     entrypoints, deployment config, or code paths relevant to the requested
     view.
   - If the user supplies prose, treat it as a source and keep uncertain claims
     visibly qualified.

3. Choose the language.
   - Default to Mermaid for Markdown-first docs and broad compatibility.
   - Prefer D2 for editable architecture diagrams that need clearer layout,
     containers, or visual polish.
   - Use PlantUML only when the repo already uses it or sequence/state detail is
     easier there.
   - Load [references/graph-languages.md](references/graph-languages.md) when
     choosing syntax, converting formats, or improving graph maintainability.

4. Write the graph source.
   - Use stable, semantic node ids.
   - Keep labels short; put detail in comments or adjacent docs.
   - Use subgraphs/containers for real ownership boundaries, not decoration.
   - Label edges only when the protocol, event, data asset, or condition matters.
   - Avoid styling that hides meaning in colors alone.
   - For cache hit/miss, retries, or alternate outcomes, prefer a branch,
     sequence, or state view over several curved return arrows in one flowchart.

5. Add traceability.
   - For new files, add a short comment block or adjacent notes section listing
     source evidence by node/edge id.
   - For existing files, follow the repo's current convention; if none exists,
     prefer comments near the graph over a separate index file.
   - Use source paths and line numbers when available. If evidence comes from
     runtime output, include the command or context that produced it.

6. Verify lightly.
   - Run the smallest available parser or renderer check when installed, such as
     `d2 fmt`, `d2 --check`, `mmdc`, `plantuml -checkonly`, markdown preview
     tooling, or the repo's documented check command.
   - If rendering tools are unavailable, inspect the syntax manually and state
     that no renderer check ran.

7. Self-review before finalizing.
   - Reject and revise diagrams with crossing-heavy edges, overlapping labels,
     unlabeled assumptions, missing traceability, ambiguous direction, or more
     than about nine nodes in one view.
   - If the first Mermaid flowchart reads poorly, switch to D2 for architecture
     or to Mermaid `sequenceDiagram` for request lifecycles.
   - Final output should include only the graph source, traceability notes, and
     a one-line validation/self-review result unless the user asks for more.

## Maintenance Rules

- Updating beats replacing: patch the existing graph unless it is clearly the
  wrong abstraction.
- Prefer one diagram per question. Add another diagram only when it answers a
  different operational question.
- Keep generated code deterministic: avoid random ids, timestamp labels, and
  layout churn unless the language requires coordinates.
- When the diagram depends on assumptions, write them next to the graph as
  assumptions rather than drawing them as confirmed facts.
