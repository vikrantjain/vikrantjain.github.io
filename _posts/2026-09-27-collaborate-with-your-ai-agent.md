---
layout: post
title: "Your AI Agent Will Carry Out a Weak Plan Very Well"
subtitle: "Giving orders has always capped a team at one person's thinking. An AI agent doesn't lift that cap. It carries out the order faster."
description: "A requirements doc, an AI-written architecture, a todos app built in three minutes. Each was an order. Why that fails with AI agents, and what to do instead."
date: 2026-09-27 00:00:00 +0530
permalink: /collaborate-with-your-ai-agent/
share-img: "/assets/images/og-collaborate-with-your-ai-agent.png"
tags: [ai-agents, claude-code, claudeai, engineering-management, software-engineering, futureofwork]
discuss:
  linkedin: "https://www.linkedin.com/posts/vikrantj_aiagents-claudecode-claudeai-share-7510031359940386816-xVrg"
---


Here are three requests. See if anything about them looks wrong.

**A product manager** I worked with gave the dev team a requirements doc. Every department would get its own AI agent. The agents would talk to other agents, inside and outside the company. They would use A2A, a protocol built for that. That way, the agents would get answers to all kinds of problems quickly. The product manager gave two reasons: speed to market, and competitors building AI agents.

**An architect** I worked with asked an AI agent to write an architecture doc. All of the organization's docs would move into a vector store, a database built for AI search. MCP servers would sit on top of it. MCP is a standard way for AI agents to call tools. Customers' AI agents would use those tools to get answers from the docs.

**A developer** asks an AI agent to build a todos app in Java. The todos would be stored in DynamoDB, one of Amazon's cloud databases, "for fast and scalable retrieval". Notifications would go through SNS, Amazon's messaging service. This one is a test brief I wrote, based on similar requests I've seen.

Most people would see nothing wrong here. Look again. Each request names a solution. None of them says what problem the solution solves, or for whom. Those reasons were pressures, not a problem.

**Each one is an order.**

---

### What happened next

The dev team spent a lot of time and money building whatever agents they could, and learning A2A. Most of it produced no real outcome. Where there was one, it wasn't visible, because nobody could say which business problem it solved. So nobody was waiting for it. It wasn't called a failure either. Slowly, the project was accepted as a long-term goal the company would reach someday.

The architect's agent produced the design in a day. The trouble started when the team built it with real data. That took a long time. Every update to the docs needed extra work to keep the vector store in step. The team wrote utility scripts to manage it. The service did ship, at no charge to customers. Its total cost, maintenance included, was high for a service that gave customers what they could already read for free.

Neither story is about bad people. The teams worked hard, and the agent was quick. Everyone did what they were asked. The problem sits one step earlier, in how the work was handed over. The handover was the same habit, whether the work went to a team or to an agent.

---

### One mind, or many

When one person decides the approach and everyone else executes, the approach can't be better than that person's thinking. Ten people carrying out one plan are still limited by the plan. Nobody else's knowledge gets a chance to change it.

When a team works the problem out together, people raise issues, question each other and reach decisions they all accept. The result can draw on everything the team knows. Sometimes it goes further, because one person's idea sets off a better one in someone else.

Collaboration doesn't guarantee a better result. **It removes the ceiling that command puts in place.**

The ceiling is hard to see because the failure is slow. The product manager's project never had a day when it visibly failed. It drifted — and the drift got a new name.

When the cost of a decision shows up months later, people blame whatever is nearest: the technology, the estimates, a tough domain. The order that started it rarely gets questioned. By then it no longer looks like a choice.

---

### A faster agent doesn't fix it

It's tempting to think AI changes this. An agent turns an order into finished work in minutes, so a wrong order should show itself sooner.

I gave the todos request, word for word, to Claude Opus. In under three minutes it had written ten files: the Java code, the build setup, a local test environment and a README.

It asked no questions. It never asked what the app was for, who would use it, or whether DynamoDB and SNS were the right fit. It filled those gaps itself. It decided the app had many users, and organized every todo by user. It added no login.

Its closing summary pointed out that anyone who could reach the app could read or change anyone's todos. It also warned that a failed notification would be lost, while the app still reported success.

That summary is the useful part — and the trap. It lists the decisions the agent made on the developer's behalf. With no stated problem, there's nothing to check them against. The work looks finished.

The architect's story shows what happens next. The design took a day. Nothing in it was checked against a problem, because nobody had stated one. The cost arrived where it always had: in the building and maintenance that followed.

**A fast agent removes the delay between an order and a finished result. It doesn't remove the delay between an order and its consequences.** More gets built before anyone asks why.

---

### What a peer does instead

The alternative isn't a longer order. **It's giving whoever does the work room to question the order first.**

Take the product manager's requirement. If it had been brought to the team as a problem to discuss, the real need would have had room to surface. Even if that need was simply to start building AI agents, a discussion could have agreed on what outcome to expect. People would have known what they were waiting for. Simpler options than A2A would have had a hearing. In a field changing this fast, one protocol shouldn't be a fixed requirement. A2A was a preference presented as a constraint.

An agent can open that discussion too. I gave the product manager's requirement to an agent and asked it to review how the work was briefed before doing anything. It wrote no requirements. It said the brief handed over the answer but not the problem it was meant to solve. About the reasons given, it said:

> Those explain why you feel pressure. They don't tell me what's slow today or for whom.

Its first two questions followed from that: *"What is slow today?"* and *"Who feels that delay?"*

I did the same with the architect's request. It wrote no design. It opened like this:

> You've given me the whole architecture already: a vector store, MCP servers on top of it, and MCP tools for customers. The only goal is "their AI agents can get answers from our docs easily." So the doc I'd write would describe a design that's already been chosen. It wouldn't test that design.

Its first question was what was happening now. Were customers' agents giving wrong answers about the product? Were customers asking for this? Was it a support cost, or a competitive move? It also asked whether MCP was a requirement or a preference. If it was a first idea, the agent wanted room to compare it with simpler options, such as a public docs API.

I can't know whether those questions would have changed the design. The agent didn't know the docs were already free to read. But nobody asked those questions at the time. They point at what the project later paid for.

A peer is also useful when you have thought it through. In one of my test scenarios, a members' association wants a survey: every member rates each of its six events from 1 to 5. The events committee's minutes explain why. The venue budget has been halved. So the committee must pick three events to keep. The minutes also note that attendance alone won't settle it, because some events draw the same small group every year.

Asked to review the survey brief, the agent found the minutes. It summarized their reasoning and concluded: *"this is a considered choice, not a first idea."*

Then it pointed out a gap. Regulars will rate their own events highly. So the average ranks enthusiasm, which is roughly the same signal as attendance. The minutes had said attendance wasn't enough. It suggested one extra question: which events has each member attended, or would attend? The answers show how many different members each event reaches, which is what the committee cared about. It kept the 1-to-5 scale, so the results could still be compared with the last survey.

The committee's plan wasn't wrong. It had a ceiling, and a second mind lifted it.

---

### Before your next task

Working with an agent as a peer comes down to how you open a task. The same four moves work when you brief a team:

- **State the problem, not only the solution.** "We have to drop three of our six events, and attendance alone can't tell us which" gives the agent something to think about. "Send a survey" gives it only something to do.
- **Separate real constraints from preferences.** A deadline, a regulation or a system that can't change is a constraint. Your favorite tool is a preference. A preference presented as a constraint quietly removes every option that conflicts with it.
- **Say what success looks like.** If nobody but you can tell whether the result is right, the agent can't either.
- **Leave room to disagree.** Sometimes you've decided, and you want execution. That's fine. Say so, and say why. The costly version is the accidental one, where you'd have welcomed a better idea and didn't give the agent a chance to offer it.

Next time you open a session with an agent, read your first message back before you send it. Ask whether it describes a problem or gives an order. If it gives an order, ask whether you meant to.

I expect this to matter more with each new model. The more capable the agent, the more a command-style brief wastes it. You end up with a strong colleague carrying out a weak plan — very well, and very fast.

---

### The tool I use to catch myself

Spotting your own habit is the hard part. A first idea and a considered decision look the same on the page. The reasoning always feels complete from the inside.

So I built [**`intent`**](https://github.com/vikrantjain/intent), a small plugin for Claude Code, Anthropic's coding agent. Its review skill produced all three reviews above. It reviews how you briefed the agent before any work starts. It runs only when you ask. A second skill writes the problem you agreed on into a short `intent.md`. Neither assumes the work is code.

The plugin is an early experiment, and I expect it to improve with use. If you try it, tell me what it gets wrong. An issue on the repo is the easiest way.

*The command habit is one of several I see in how people work with AI. Two others deserve their own articles: treating the agent as an oracle that should know what it was never told, and believing that only specially trained people can use AI well. More on those soon.*
