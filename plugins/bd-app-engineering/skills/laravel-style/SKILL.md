---
name: Laravel Style Guide
description: Use this skill for Laravel coding standards and conventions. Triggers when writing or reviewing Laravel code.
version: 1.0.0
---

# Laravel Style Guide for BD-App

## PHP Standards

- PSR-12 coding style
- PHP 8.4 features (readonly, enums, attributes)
- Type hints on all parameters and returns
- Strict types declared

## Controllers

```php
// Thin controllers - delegate to Actions
public function store(CreateProjectRequest $request): RedirectResponse
{
    $project = CreateProjectAction::run($request->validated());

    return redirect()
        ->route('projects.show', $project)
        ->with('success', 'Project created!');
}
```

## Actions

```php
// Single responsibility
class CreateProjectAction
{
    public static function run(array $data): Project
    {
        return Project::create($data);
    }
}
```

## Models

```php
class Project extends Model
{
    use HasUuids;

    protected $fillable = ['name', 'url', 'company_name'];

    protected $casts = [
        'instructions' => 'array',
    ];

    public function reports(): HasMany
    {
        return $this->hasMany(AuditReport::class);
    }
}
```

## Jobs

```php
class TriggerAgentJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public int $tries = 3;
    public int $timeout = 300;

    public function handle(): void
    {
        // Implementation
    }
}
```

## Events

```php
class AgentCompleted implements ShouldBroadcast
{
    public function broadcastOn(): array
    {
        return [new PrivateChannel('reports.'.$this->reportId)];
    }
}
```

## Testing

```php
public function test_can_create_project(): void
{
    $user = User::factory()->create();

    $response = $this->actingAs($user)
        ->post('/projects', [
            'name' => 'Test Project',
            'url' => 'https://example.com',
        ]);

    $response->assertRedirect();
    $this->assertDatabaseHas('projects', ['name' => 'Test Project']);
}
```
