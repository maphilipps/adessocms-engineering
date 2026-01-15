---
name: ai-backend
description: Build AI-powered backends with Vercel AI SDK. Use for streaming responses, tool calling, structured outputs, and multi-provider AI integration.
---

# AI Backend Development

## Tech Stack
- **AI SDK** (Vercel) for AI integration
- **OpenAI, Anthropic, Google** providers
- **Next.js API Routes** for endpoints
- **Zod** for schema validation

## Core Concepts

### Provider Setup

```tsx
// lib/ai.ts
import { openai } from '@ai-sdk/openai'
import { anthropic } from '@ai-sdk/anthropic'
import { google } from '@ai-sdk/google'

export const models = {
  'gpt-4o': openai('gpt-4o'),
  'gpt-4o-mini': openai('gpt-4o-mini'),
  'claude-sonnet': anthropic('claude-sonnet-4-20250514'),
  'gemini-pro': google('gemini-2.0-flash-001'),
}
```

### Text Generation

```tsx
import { generateText } from 'ai'
import { openai } from '@ai-sdk/openai'

const result = await generateText({
  model: openai('gpt-4o'),
  prompt: 'Explain quantum computing in one paragraph.',
})

console.log(result.text)
```

### Streaming Responses

```tsx
// app/api/chat/route.ts
import { streamText } from 'ai'
import { openai } from '@ai-sdk/openai'

export async function POST(req: Request) {
  const { messages } = await req.json()

  const result = streamText({
    model: openai('gpt-4o'),
    system: 'You are a helpful assistant.',
    messages,
  })

  return result.toDataStreamResponse()
}
```

### Structured Output

```tsx
import { generateObject } from 'ai'
import { openai } from '@ai-sdk/openai'
import { z } from 'zod'

const recipeSchema = z.object({
  name: z.string(),
  ingredients: z.array(z.object({
    name: z.string(),
    amount: z.string(),
  })),
  steps: z.array(z.string()),
})

const result = await generateObject({
  model: openai('gpt-4o'),
  schema: recipeSchema,
  prompt: 'Generate a recipe for chocolate chip cookies.',
})

// result.object is typed as { name, ingredients, steps }
```

### Tool Calling

```tsx
import { generateText, tool } from 'ai'
import { openai } from '@ai-sdk/openai'
import { z } from 'zod'

const result = await generateText({
  model: openai('gpt-4o'),
  prompt: 'What is the weather in San Francisco?',
  tools: {
    getWeather: tool({
      description: 'Get the current weather for a location',
      parameters: z.object({
        location: z.string().describe('City name'),
      }),
      execute: async ({ location }) => {
        // Call weather API
        return { temperature: 72, condition: 'sunny' }
      },
    }),
  },
})
```

### Multi-Step Tool Calls

```tsx
import { generateText } from 'ai'
import { openai } from '@ai-sdk/openai'

const result = await generateText({
  model: openai('gpt-4o'),
  prompt: 'Book a flight from NYC to LA for next Monday',
  tools: { searchFlights, bookFlight, getCalendar },
  maxSteps: 5, // Allow multiple tool call rounds
})

// result.steps contains all intermediate steps
for (const step of result.steps) {
  console.log(step.toolCalls)
  console.log(step.toolResults)
}
```

### Streaming with Tools

```tsx
import { streamText } from 'ai'
import { openai } from '@ai-sdk/openai'

const result = streamText({
  model: openai('gpt-4o'),
  prompt: 'Calculate 15% tip on $85',
  tools: {
    calculate: tool({
      parameters: z.object({ expression: z.string() }),
      execute: async ({ expression }) => eval(expression),
    }),
  },
  onStepFinish: ({ toolCalls, toolResults }) => {
    console.log('Tool called:', toolCalls)
  },
})

for await (const part of result.fullStream) {
  if (part.type === 'text-delta') {
    process.stdout.write(part.textDelta)
  }
}
```

### Chat API Route (Complete)

```tsx
// app/api/chat/route.ts
import { streamText, tool } from 'ai'
import { openai } from '@ai-sdk/openai'
import { z } from 'zod'

export const maxDuration = 30

export async function POST(req: Request) {
  const { messages } = await req.json()

  const result = streamText({
    model: openai('gpt-4o'),
    system: `You are a helpful assistant. Today is ${new Date().toDateString()}.`,
    messages,
    tools: {
      getWeather: tool({
        description: 'Get weather for a location',
        parameters: z.object({
          location: z.string(),
        }),
        execute: async ({ location }) => {
          // Call weather API
          return { temp: 72, condition: 'sunny' }
        },
      }),
    },
    maxSteps: 3,
  })

  return result.toDataStreamResponse()
}
```

### RAG (Retrieval Augmented Generation)

```tsx
import { embed, generateText } from 'ai'
import { openai } from '@ai-sdk/openai'

// 1. Embed user query
const { embedding } = await embed({
  model: openai.embedding('text-embedding-3-small'),
  value: userQuery,
})

// 2. Search vector database
const docs = await vectorDB.search(embedding, { limit: 5 })

// 3. Generate with context
const result = await generateText({
  model: openai('gpt-4o'),
  system: `Answer based on these documents:\n${docs.map(d => d.content).join('\n')}`,
  prompt: userQuery,
})
```

### Agents

```tsx
import { generateText, tool } from 'ai'
import { openai } from '@ai-sdk/openai'

const result = await generateText({
  model: openai('gpt-4o'),
  system: `You are a research assistant. Use tools to find and analyze information.`,
  prompt: 'Research the top 3 competitors in the AI assistant market',
  tools: {
    webSearch: tool({ ... }),
    readUrl: tool({ ... }),
    saveNote: tool({ ... }),
  },
  maxSteps: 10,
  onStepFinish: ({ text, toolCalls }) => {
    console.log('Step:', { text, toolCalls })
  },
})
```

## Environment Variables

```env
OPENAI_API_KEY=sk-...
ANTHROPIC_API_KEY=sk-ant-...
GOOGLE_GENERATIVE_AI_API_KEY=...
```

## Error Handling

```tsx
import { generateText, APICallError } from 'ai'

try {
  const result = await generateText({ ... })
} catch (error) {
  if (error instanceof APICallError) {
    console.error('API Error:', error.message)
    console.error('Status:', error.statusCode)
  }
  throw error
}
```

## Best Practices

### Model Selection
| Use Case | Model |
|----------|-------|
| Fast, cheap | gpt-4o-mini, claude-haiku |
| High quality | gpt-4o, claude-sonnet |
| Vision | gpt-4o, claude-sonnet |
| Long context | claude-sonnet (200K) |

### Streaming Best Practices
- Always use `streamText` for chat UIs
- Set appropriate `maxDuration` for Vercel
- Use `onStepFinish` for logging
- Return `toDataStreamResponse()` for useChat compatibility

### Tool Design
- Keep tool descriptions concise but clear
- Use Zod `.describe()` for parameter hints
- Return structured data, not formatted strings
- Handle errors gracefully in execute functions

## MCP Integration

Use `ai-elements` MCP server for:
- Component examples and usage
- Best practices for AI interfaces
- Streaming patterns
