---
name: Inertia.js Patterns
description: Use this skill for Inertia.js implementation patterns, form handling, and Laravel-React integration. Triggers when working with Inertia pages, forms, or navigation.
version: 1.0.0
---

# Inertia.js Patterns for BD-App

## Core Principle

Inertia replaces REST APIs. Data flows as page props, not API responses.

## Page Structure

```tsx
import { Head, usePage } from '@inertiajs/react';

interface Props {
    project: ProjectData;
    report?: AuditReportData;
}

export default function Show({ project, report }: Props) {
    return (
        <>
            <Head title={project.name} />
            <div className="container mx-auto py-8">
                {/* Content */}
            </div>
        </>
    );
}
```

## Form Handling

```tsx
import { useForm } from '@inertiajs/react';

function CreateForm() {
    const { data, setData, post, processing, errors } = useForm({
        name: '',
        url: '',
    });

    const submit = (e: React.FormEvent) => {
        e.preventDefault();
        post('/projects');
    };

    return (
        <form onSubmit={submit}>
            <Input
                value={data.name}
                onChange={e => setData('name', e.target.value)}
                error={errors.name}
            />
            <Button disabled={processing}>Create</Button>
        </form>
    );
}
```

## Partial Reloads

```tsx
// Reload specific props only
router.reload({ only: ['report', 'agentRuns'] });

// Preserve scroll and state
router.reload({
    only: ['notifications'],
    preserveScroll: true,
    preserveState: true,
});
```

## Live Updates with Echo

```tsx
useEffect(() => {
    const channel = window.Echo.private(`reports.${reportId}`);

    channel.listen('AgentCompleted', () => {
        router.reload({ only: ['report', 'agentRuns'] });
    });

    return () => channel.stopListening('AgentCompleted');
}, [reportId]);
```

## Anti-Patterns

❌ Using fetch/axios for data
❌ Creating REST API endpoints
❌ Manual state for server data
❌ Missing prop types
