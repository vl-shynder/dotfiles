---
name: herdr-delegation
description: Use when user asks to delegate coding work to another agent or subagent.
---

# Delegate with Herdr

When the user asks for delegation or a subagent, use Herdr to create a new tab and start the requested agent there. This user preference overrides Herdr's usual default of creating a sibling pane in the current tab.

Use Codex with model `gpt-6.1-sol` at medium reasoning effort by default, or Claude with model `claude-opus-5-5` at medium effort. Honor a model or agent explicitly requested by the user.

Do not wait for the delegated agent to finish unless the user asks you to wait. Continue the primary task independently and incorporate the agent's result when it becomes available.

Always close agents that are done with their task in full and there is no more delegation to be done.

When reviewing code, use /ponytail-review or let the delegated agent use it.

# Model per task

You should pick appropriate model for the delegated task. Here is a list of models and their preferred tasks:

| Model | Preferred Task | How to use |
|-------|----------------|------------|
| claude-opus-5-5 | Reasoning, planning heavy tasks, design work, code review | Normally main orchestrator, reviewer or implementer if task is complex. Use high reasoning for planning work for other agents, reviewing. For UI work or implementing already planned features use medium reasoning |
| gpt-6.1-sol | Coding, reasoning, non ui work | Use for coding, reasoning, and non-UI work. Use medium reasoning for coding tasks. Use high reasoning for complex coding tasks or when the user asks for it. |
| gpt-6-luna | UI work, design, prototyping, front end work | Use for UI work with concrete requirements, prototyping, front end work. Use high reasoning by default. Always provide detailed implementation guidelines and be specific, do not let this model make complicated decisions about architecture |

By default implementation that is not UI work should be delegated to codex and gpt models. Any implementer agent should have it's own reviwer agent. Each reviewer can only do a maximum of 3 rounds of review and report the outstanding bugs to the leading agent. The leading agent should not wait or check on the implementer or any other agent created using this skill. Each agent created should have instructions on how to communicate with the lead agent when the task is complete or if there are any questions and how reviewer and implementer should communicate with each other.

# Herdr layout

By default group implementers and reviewers into single tab. Lead agent should be in a separate tab. If the user asks for a specific layout, follow their instructions.