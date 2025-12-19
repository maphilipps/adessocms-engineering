---
name: Claude Agent SDK
description: Use this skill when developing Node.js agents with the Claude Agent SDK. Triggers for agent creation, tool implementation, or worker debugging.
version: 1.0.0
---

# Claude Agent SDK for BD-App

## Worker Architecture

```
┌─────────────────────────────────────────┐
│  Node.js Worker                         │
│  ┌───────────────────────────────────┐ │
│  │ BRPOP agent:requests              │ │
│  │         ↓                         │ │
│  │ Load Agent Config                 │ │
│  │         ↓                         │ │
│  │ Claude SDK (messages.create)      │ │
│  │         ↓                         │ │
│  │ Zod Schema Validation             │ │
│  │         ↓                         │ │
│  │ LPUSH agent:results:{id}          │ │
│  └───────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

## Agent Config

```typescript
// worker/src/agents/config.ts
export const agents = {
  'tech-stack-detector': {
    id: 'tech-stack-detector',
    name: 'Tech Stack Detector',
    phase: 3,
    model: 'claude-sonnet-4-20250514',
    systemPrompt: `You are a technology analyst...`,
    tools: ['wappalyzer', 'lighthouse', 'web-fetch'],
    outputSchema: techStackSchema,
  },
};
```

## Output Schema (Zod)

```typescript
// worker/src/schemas/outputs.ts
import { z } from 'zod';

export const techStackSchema = z.object({
  cms: z.object({
    name: z.string(),
    version: z.string().optional(),
    confidence: z.number(),
  }).optional(),
  frontend: z.object({
    framework: z.string().optional(),
    cssFramework: z.string().optional(),
  }),
});
```

## Tool Implementation

```typescript
// worker/src/tools/wappalyzer.ts
export const wappalyzerTool = {
  name: 'wappalyzer',
  description: 'Detect technologies on a website',
  input_schema: {
    type: 'object',
    properties: {
      url: { type: 'string' },
    },
    required: ['url'],
  },
};

export async function executeWappalyzer(input: { url: string }) {
  // Implementation
}
```

## Available Tools

- `wappalyzer` - Tech stack detection
- `lighthouse` - Performance/a11y audit
- `puppeteer` - Browser automation
- `web-fetch` - Fetch webpage content

## Progress Updates

```typescript
await redis.publish(
  `agent:progress:${requestId}`,
  JSON.stringify({ progress: 50, message: 'Analyzing...' })
);
```
