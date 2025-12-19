---
name: Spatie Data Patterns
description: Use this skill for Spatie Laravel Data DTO patterns, transformations, and validation. Triggers when creating or working with Data classes.
version: 1.0.0
---

# Spatie Data Patterns for BD-App

## Basic DTO

```php
namespace App\Data;

use Spatie\LaravelData\Data;
use Carbon\Carbon;

class ProjectData extends Data
{
    public function __construct(
        public readonly string $id,
        public readonly string $name,
        public readonly string $url,
        public readonly ?string $companyName,
        public readonly Carbon $createdAt,
    ) {}
}
```

## Nested DTOs

```php
use Spatie\LaravelData\Attributes\DataCollectionOf;
use Spatie\LaravelData\DataCollection;

class AuditReportData extends Data
{
    public function __construct(
        public readonly string $id,
        public readonly ReportStatus $status,
        public readonly ?QualificationData $qualification,
        #[DataCollectionOf(AgentRunData::class)]
        public readonly ?DataCollection $agentRuns,
    ) {}
}
```

## Lazy Properties

```php
use Spatie\LaravelData\Lazy;

class ProjectData extends Data
{
    public function __construct(
        public readonly string $id,
        public readonly Lazy|DataCollection $reports,
    ) {}

    public static function fromModel(Project $project): self
    {
        return new self(
            id: $project->id,
            reports: Lazy::create(fn() =>
                AuditReportData::collection($project->reports)
            ),
        );
    }
}
```

## Validation

```php
use Spatie\LaravelData\Attributes\Validation\{Required, Max, Url};

class CreateProjectData extends Data
{
    public function __construct(
        #[Required, Max(255)]
        public readonly string $name,

        #[Required, Url]
        public readonly string $url,
    ) {}
}
```

## Usage in Controllers

```php
public function show(Project $project): Response
{
    return Inertia::render('Projects/Show', [
        'project' => ProjectData::from($project),
    ]);
}

public function store(CreateProjectData $data): RedirectResponse
{
    $project = Project::create($data->all());
    return redirect()->route('projects.show', $project);
}
```
