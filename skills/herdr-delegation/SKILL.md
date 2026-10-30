---
name: herdr-delegation
description: Delegate coding work to another agent through Herdr when the user asks for a subagent, delegation, or another coding agent.
---

# Delegate with Herdr

When the user asks for delegation or a subagent, use Herdr to create a new tab and start the requested agent there. This user preference overrides Herdr's usual default of creating a sibling pane in the current tab.

Use Codex with model `gpt-6.1-sol` at medium reasoning effort by default, or Claude with model `claude-opus-5-5` at medium effort. Honor a model or agent explicitly requested by the user.

Do not wait for the delegated agent to finish unless the user asks you to wait. Continue the primary task independently and incorporate the agent's result when it becomes available.
