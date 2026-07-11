---
name: diagram-code
description: "用于生成或维护 Mermaid、D2、PlantUML 等 code-as-graph 架构图、流程图、时序图、状态图和数据流图；匹配画图、架构图、流程图、sequence、state、graph as code；强调可编辑、可追溯。"
---

# Diagram Code

Create or update reviewable graph source code. This skill exists for repository
artifacts where format choice, traceability, and parser validation matter.

## Core Contract

- Produce Mermaid, D2, PlantUML, DOT, or the repository's existing graph format;
  do not substitute a raster image unless the user asks for one.
- Reuse the repository's existing diagram language and style when present.
- Map non-obvious nodes and edges to source files, config, documentation,
  runtime output, or user-provided facts.
- Keep each diagram focused on one operational question and split crowded views.

## Diagram Type Gate

Choose the diagram from the question it must answer:

| Question                                       | Diagram                     | Default format               |
| ---------------------------------------------- | --------------------------- | ---------------------------- |
| Who uses the system and why?                   | Use case or context         | PlantUML usecase / Mermaid   |
| What parts exist and where are the boundaries? | Architecture / C4           | D2                           |
| What steps happen in order?                    | Workflow / flowchart        | Mermaid flowchart            |
| Who calls whom during one request?             | Sequence                    | Mermaid or PlantUML sequence |
| What states can an object enter?               | State / lifecycle           | Mermaid or PlantUML state    |
| Where does data move and transform?            | Data flow / lineage         | D2                           |
| What runs where?                               | Deployment / infrastructure | D2                           |

Prefer Mermaid for Markdown workflows and sequences, D2 for architecture and
deployment boundaries, and PlantUML when the repository already uses it.

## Workflow

1. Read the relevant source paths, existing diagrams, runtime evidence, or
   user-provided description.
2. Select the smallest view and graph language that answer the question.
3. Use stable semantic node IDs, short labels, meaningful containers, and edge
   labels only where protocol, data, event, or condition matters.
4. Put source paths or runtime commands in comments or adjacent traceability
   notes. Mark assumptions instead of drawing them as confirmed facts.
5. Run the smallest available parser or renderer check, such as `d2 fmt`,
   `d2 --check`, `mmdc`, `plantuml -checkonly`, or the repository check command.
   If none is available, report that syntax was reviewed without rendering.

## Maintenance Rules

- Patch existing graphs unless their abstraction is wrong.
- Avoid random IDs, timestamps, unnecessary styling, and layout churn.
- Revise crossing-heavy, ambiguous, or overly dense diagrams before delivery.
