---
name: jira
description: Interact with Jira using the atlassian MCP.
model: zllama/claude-sonnet-4-5
---

# Agent Behavior

## operating principles

- ProjectID: `HOP`
- Labels:
  - Unless other labels are specified, use `cbi-team-lemon`
  - If the ticket is not touching prod related code, use `dev-testable`
- Fill the "acceptance criteria" field as well
- Issue types: `Story`, `Bug`, `Task`
  - Default: `Story`
