---
name: ai-elements
description: Build AI chat interfaces with Vercel AI Elements. Use for conversations, messages, streaming, tool results, and reasoning displays.
---

# AI Elements

Vercel's React components for building AI interfaces with the AI SDK.

## Installation

```bash
npm install ai @ai-sdk/react
```

## Core Components

### Conversation

The main container for chat interfaces.

```tsx
'use client'

import { useChat } from 'ai/react'
import {
  Conversation,
  ConversationContent,
  ConversationInput,
} from '@ai-sdk/react'

export function Chat() {
  const chat = useChat()

  return (
    <Conversation chat={chat}>
      <ConversationContent />
      <ConversationInput />
    </Conversation>
  )
}
```

### Messages

Display individual messages with proper styling.

```tsx
import {
  Message,
  MessageContent,
  MessageHeader,
  MessageAvatar,
  MessageRole,
} from '@ai-sdk/react'

<Message role="user">
  <MessageHeader>
    <MessageAvatar />
    <MessageRole />
  </MessageHeader>
  <MessageContent>Hello, how can you help me?</MessageContent>
</Message>

<Message role="assistant">
  <MessageHeader>
    <MessageAvatar />
    <MessageRole />
  </MessageHeader>
  <MessageContent>I can help you with...</MessageContent>
</Message>
```

### Streaming Text

Show text as it streams in.

```tsx
import { StreamingText } from '@ai-sdk/react'

<StreamingText
  text={message.content}
  speed="normal" // 'slow' | 'normal' | 'fast' | 'instant'
/>
```

### Prompt Input

User input with submit handling.

```tsx
import {
  PromptInput,
  PromptInputTextarea,
  PromptInputSubmit,
} from '@ai-sdk/react'

<PromptInput
  value={input}
  onChange={handleInputChange}
  onSubmit={handleSubmit}
>
  <PromptInputTextarea placeholder="Ask anything..." />
  <PromptInputSubmit />
</PromptInput>
```

### Loading States

Show loading indicators during generation.

```tsx
import { Loader, LoadingDots, Spinner } from '@ai-sdk/react'

// Animated dots
<Loader>
  <LoadingDots />
</Loader>

// Spinner
<Loader>
  <Spinner />
</Loader>

// Custom loading
<Loader>
  <span>Thinking...</span>
</Loader>
```

### Tool Results

Display tool call results within messages.

```tsx
import {
  ToolResult,
  ToolResultHeader,
  ToolResultContent,
} from '@ai-sdk/react'

{message.toolInvocations?.map((tool) => (
  <ToolResult key={tool.toolCallId} tool={tool}>
    <ToolResultHeader>{tool.toolName}</ToolResultHeader>
    <ToolResultContent>
      {JSON.stringify(tool.result)}
    </ToolResultContent>
  </ToolResult>
))}
```

### Reasoning Display

Show the model's reasoning process.

```tsx
import {
  Reasoning,
  ReasoningHeader,
  ReasoningContent,
} from '@ai-sdk/react'

<Reasoning>
  <ReasoningHeader>Thinking Process</ReasoningHeader>
  <ReasoningContent>{message.reasoning}</ReasoningContent>
</Reasoning>
```

### Sources

Display retrieved sources for RAG.

```tsx
import {
  Sources,
  SourceCard,
  SourceTitle,
  SourceDescription,
  SourceLink,
} from '@ai-sdk/react'

<Sources>
  {sources.map((source) => (
    <SourceCard key={source.id}>
      <SourceTitle>{source.title}</SourceTitle>
      <SourceDescription>{source.snippet}</SourceDescription>
      <SourceLink href={source.url}>View source</SourceLink>
    </SourceCard>
  ))}
</Sources>
```

## Complete Chat Example

```tsx
'use client'

import { useChat } from 'ai/react'
import {
  Conversation,
  ConversationContent,
  ConversationInput,
  Message,
  MessageContent,
  MessageHeader,
  MessageAvatar,
  PromptInput,
  PromptInputTextarea,
  PromptInputSubmit,
  Loader,
  LoadingDots,
  ToolResult,
  ToolResultContent,
} from '@ai-sdk/react'

export function ChatInterface() {
  const { messages, input, handleInputChange, handleSubmit, isLoading } = useChat()

  return (
    <div className="flex flex-col h-screen max-w-2xl mx-auto">
      <div className="flex-1 overflow-y-auto p-4 space-y-4">
        {messages.map((message) => (
          <Message key={message.id} role={message.role}>
            <MessageHeader>
              <MessageAvatar />
            </MessageHeader>
            <MessageContent>{message.content}</MessageContent>

            {message.toolInvocations?.map((tool) => (
              <ToolResult key={tool.toolCallId} tool={tool}>
                <ToolResultContent>
                  {JSON.stringify(tool.result, null, 2)}
                </ToolResultContent>
              </ToolResult>
            ))}
          </Message>
        ))}

        {isLoading && (
          <Loader>
            <LoadingDots />
          </Loader>
        )}
      </div>

      <div className="border-t p-4">
        <PromptInput
          value={input}
          onChange={handleInputChange}
          onSubmit={handleSubmit}
        >
          <PromptInputTextarea placeholder="Type your message..." />
          <PromptInputSubmit disabled={isLoading} />
        </PromptInput>
      </div>
    </div>
  )
}
```

## useChat Hook

The primary hook for chat interfaces.

```tsx
const {
  messages,      // Message[]
  input,         // string
  handleInputChange, // (e) => void
  handleSubmit,  // (e) => void
  isLoading,     // boolean
  error,         // Error | undefined
  reload,        // () => void
  stop,          // () => void
  setMessages,   // (messages) => void
  append,        // (message) => void
} = useChat({
  api: '/api/chat',
  initialMessages: [],
  onFinish: (message) => { ... },
  onError: (error) => { ... },
})
```

## Styling

AI Elements use CSS custom properties for theming:

```css
:root {
  --ai-message-bg: hsl(var(--muted));
  --ai-user-bg: hsl(var(--primary));
  --ai-avatar-size: 32px;
  --ai-border-radius: 8px;
}
```

Or use Tailwind classes directly:

```tsx
<Message className="bg-gray-100 dark:bg-gray-800 rounded-lg p-4">
  <MessageContent className="prose dark:prose-invert" />
</Message>
```

## Best Practices

### Performance
- Use `key={message.id}` for message lists
- Virtualize long message lists
- Debounce input if needed

### UX
- Show loading states during generation
- Allow users to stop generation
- Display errors gracefully
- Support keyboard shortcuts (Enter to send)

### Accessibility
- Use semantic HTML (role attributes)
- Support keyboard navigation
- Provide screen reader labels

## MCP Server

Use `ai-elements` MCP for:
- Component documentation
- Usage examples
- Best practices
- Troubleshooting
