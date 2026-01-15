---
name: nextjs-frontend
description: Build Next.js frontend with App Router, Server Components, ShadCN UI, and Tailwind CSS. Use when creating pages, layouts, components, and client-side interactivity.
---

# Next.js Frontend Development

## Tech Stack
- **Next.js 15** with App Router
- **React 19** with Server Components
- **ShadCN UI** for component library
- **Tailwind CSS** for styling
- **TypeScript** for type safety

## Core Concepts

### App Router Structure
```
app/
  layout.tsx        # Root layout (required)
  page.tsx          # Home page
  loading.tsx       # Loading UI (Suspense boundary)
  error.tsx         # Error boundary
  not-found.tsx     # 404 page
  globals.css       # Global styles

  (marketing)/      # Route group (no URL segment)
    about/
      page.tsx

  dashboard/
    layout.tsx      # Nested layout
    page.tsx
    settings/
      page.tsx
    [userId]/       # Dynamic segment
      page.tsx

  api/
    chat/
      route.ts      # API route
```

### Server vs Client Components

**Server Components (default):**
- Direct data fetching with async/await
- Access to secrets and server-only code
- No JavaScript sent to client

```tsx
// Server Component - no directive needed
async function ProductList() {
  const products = await db.products.findMany()
  return (
    <ul>
      {products.map(p => <li key={p.id}>{p.name}</li>)}
    </ul>
  )
}
```

**Client Components:**
```tsx
'use client'

import { useState } from 'react'
import { Button } from '@/components/ui/button'

export function Counter() {
  const [count, setCount] = useState(0)
  return (
    <Button onClick={() => setCount(c => c + 1)}>
      Count: {count}
    </Button>
  )
}
```

### ShadCN UI Components

Install components via CLI:
```bash
npx shadcn@latest add button card dialog
```

Usage:
```tsx
import { Button } from '@/components/ui/button'
import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card'

export function Feature() {
  return (
    <Card>
      <CardHeader>
        <CardTitle>Feature Title</CardTitle>
      </CardHeader>
      <CardContent>
        <p>Content here</p>
        <Button>Action</Button>
      </CardContent>
    </Card>
  )
}
```

### Tailwind CSS Patterns

```tsx
// Responsive design
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">

// Dark mode
<div className="bg-white dark:bg-gray-900 text-gray-900 dark:text-white">

// Container with padding
<main className="container mx-auto px-4 py-8">

// Flexbox centering
<div className="flex items-center justify-center min-h-screen">

// Typography
<h1 className="text-3xl font-bold tracking-tight">
<p className="text-muted-foreground">
```

### Data Fetching

**In Server Components:**
```tsx
async function UserProfile({ userId }: { userId: string }) {
  const user = await prisma.user.findUnique({ where: { id: userId } })
  if (!user) notFound()
  return <Profile user={user} />
}
```

**With loading states:**
```tsx
// app/dashboard/loading.tsx
import { Skeleton } from '@/components/ui/skeleton'

export default function Loading() {
  return <Skeleton className="h-[200px] w-full" />
}
```

### Forms with Server Actions

```tsx
// actions.ts
'use server'

import { revalidatePath } from 'next/cache'
import { z } from 'zod'

const schema = z.object({
  title: z.string().min(1).max(100),
})

export async function createPost(formData: FormData) {
  const parsed = schema.safeParse({
    title: formData.get('title'),
  })

  if (!parsed.success) {
    return { error: parsed.error.flatten() }
  }

  await db.post.create({ data: parsed.data })
  revalidatePath('/posts')
  return { success: true }
}
```

```tsx
// form.tsx
'use client'

import { useActionState } from 'react'
import { createPost } from './actions'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'

export function CreatePostForm() {
  const [state, action, pending] = useActionState(createPost, null)

  return (
    <form action={action}>
      <Input name="title" placeholder="Post title" />
      {state?.error && <p className="text-red-500">{state.error}</p>}
      <Button type="submit" disabled={pending}>
        {pending ? 'Creating...' : 'Create Post'}
      </Button>
    </form>
  )
}
```

### Metadata & SEO

```tsx
import { Metadata } from 'next'

export const metadata: Metadata = {
  title: 'Dashboard | My App',
  description: 'Manage your content',
}

// Dynamic metadata
export async function generateMetadata({ params }): Promise<Metadata> {
  const post = await getPost(params.id)
  return {
    title: post.title,
    openGraph: {
      images: [post.image],
    },
  }
}
```

### Image & Font Optimization

```tsx
import Image from 'next/image'
import { Inter } from 'next/font/google'

const inter = Inter({ subsets: ['latin'] })

export default function Page() {
  return (
    <div className={inter.className}>
      <Image
        src="/hero.jpg"
        alt="Hero"
        width={1200}
        height={600}
        priority
      />
    </div>
  )
}
```

### File Conventions

| File | Purpose |
|------|---------|
| `page.tsx` | Route page component |
| `layout.tsx` | Shared layout wrapper |
| `loading.tsx` | Loading UI (Suspense) |
| `error.tsx` | Error boundary |
| `not-found.tsx` | 404 page |
| `route.ts` | API endpoint |
| `template.tsx` | Re-mounted layout |
| `default.tsx` | Parallel route fallback |

## Best Practices

### Component Organization
```
components/
  ui/               # ShadCN components
  features/         # Feature-specific
    dashboard/
    auth/
  shared/           # Shared across features
```

### TypeScript Patterns
```tsx
// Page props
type PageProps = {
  params: Promise<{ id: string }>
  searchParams: Promise<{ [key: string]: string | undefined }>
}

export default async function Page({ params, searchParams }: PageProps) {
  const { id } = await params
  const { sort } = await searchParams
  // ...
}
```

### Environment Variables
```env
# Server-only (never exposed to browser)
DATABASE_URL=...
API_SECRET=...

# Client-side (exposed to browser)
NEXT_PUBLIC_APP_URL=...
```

## MCP Integration

Use `shadcn` MCP server to:
- Add new components: `add_component button`
- Get component source: `get_component card`
- List available components: `list_components`
