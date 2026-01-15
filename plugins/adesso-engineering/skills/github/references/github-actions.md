# GitHub Actions Reference

## Grundstruktur

```yaml
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run tests
        run: npm test
```

---

## Trigger (on)

```yaml
on:
  # Push
  push:
    branches: [main, 'release/**']
    tags: ['v*']
    paths: ['src/**', '!src/docs/**']

  # Pull Request
  pull_request:
    branches: [main]
    types: [opened, synchronize, reopened]

  # Schedule (cron)
  schedule:
    - cron: '0 0 * * *'  # Täglich Mitternacht

  # Manuell
  workflow_dispatch:
    inputs:
      environment:
        description: 'Deployment environment'
        required: true
        default: 'staging'
        type: choice
        options:
          - staging
          - production

  # Von anderem Workflow
  workflow_call:
    inputs:
      config:
        required: true
        type: string
```

---

## Jobs

```yaml
jobs:
  build:
    name: Build Application
    runs-on: ubuntu-latest
    timeout-minutes: 30

    permissions:
      contents: read
      pull-requests: write

    env:
      NODE_ENV: production

    steps:
      - uses: actions/checkout@v4

      - name: Setup Node
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - run: npm ci
      - run: npm test
```

---

## Matrix Strategy

```yaml
jobs:
  test:
    strategy:
      fail-fast: false
      matrix:
        os: [ubuntu-latest, macos-latest]
        node: [18, 20, 22]
        exclude:
          - os: macos-latest
            node: 18
        include:
          - os: ubuntu-latest
            node: 20
            experimental: true

    runs-on: ${{ matrix.os }}
    steps:
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node }}
```

---

## Conditions

```yaml
steps:
  - name: Only on main
    if: github.ref == 'refs/heads/main'
    run: echo "On main"

  - name: Only on PR
    if: github.event_name == 'pull_request'
    run: echo "This is a PR"

  - name: On failure
    if: failure()
    run: echo "Previous step failed"

  - name: Always run
    if: always()
    run: echo "Always runs"
```

---

## Outputs

```yaml
jobs:
  job1:
    outputs:
      version: ${{ steps.version.outputs.value }}
    steps:
      - id: version
        run: echo "value=1.0.0" >> $GITHUB_OUTPUT

  job2:
    needs: job1
    steps:
      - run: echo "Version is ${{ needs.job1.outputs.version }}"
```

---

## Secrets & Variables

```yaml
steps:
  - name: Use secrets
    env:
      API_KEY: ${{ secrets.API_KEY }}
    run: ./deploy.sh

  - name: Use variables
    env:
      SITE_URL: ${{ vars.SITE_URL }}
    run: echo $SITE_URL
```

---

## Artifacts

```yaml
# Upload
- uses: actions/upload-artifact@v4
  with:
    name: coverage-report
    path: coverage/
    retention-days: 5

# Download
- uses: actions/download-artifact@v4
  with:
    name: coverage-report
    path: ./coverage
```

---

## Cache

```yaml
- uses: actions/cache@v3
  with:
    path: ~/.npm
    key: npm-${{ hashFiles('package-lock.json') }}
    restore-keys: |
      npm-
```

---

## Services

```yaml
jobs:
  test:
    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_PASSWORD: postgres
        ports:
          - 5432:5432
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
```

---

## Reusable Workflows

```yaml
# .github/workflows/deploy.yml
on:
  workflow_call:
    inputs:
      environment:
        required: true
        type: string
    secrets:
      deploy_key:
        required: true

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: ${{ inputs.environment }}
    steps:
      - run: ./deploy.sh
        env:
          KEY: ${{ secrets.deploy_key }}
```

```yaml
# Calling workflow
jobs:
  call-deploy:
    uses: ./.github/workflows/deploy.yml
    with:
      environment: staging
    secrets:
      deploy_key: ${{ secrets.DEPLOY_KEY }}
```

---

## Common Actions

| Action | Purpose |
|--------|---------|
| `actions/checkout@v4` | Checkout code |
| `actions/setup-node@v4` | Setup Node.js |
| `actions/setup-php@v2` | Setup PHP |
| `actions/cache@v3` | Cache dependencies |
| `actions/upload-artifact@v4` | Upload artifact |
| `actions/download-artifact@v4` | Download artifact |
