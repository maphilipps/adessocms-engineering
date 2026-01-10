# GitLab CI YAML Reference

## Grundstruktur

```yaml
stages:
  - build
  - test
  - deploy

variables:
  GLOBAL_VAR: "value"

default:
  image: php:8.3-cli
  before_script:
    - composer install

build:
  stage: build
  script:
    - composer build

test:
  stage: test
  script:
    - phpunit

deploy:
  stage: deploy
  script:
    - ./deploy.sh
  only:
    - main
```

---

## Jobs

```yaml
job_name:
  stage: test
  image: node:20
  variables:
    LOCAL_VAR: "value"
  before_script:
    - npm install
  script:
    - npm test
  after_script:
    - cleanup.sh
  allow_failure: false
  timeout: 1 hour
  tags:
    - docker
```

---

## Rules (Modern)

```yaml
deploy:
  rules:
    - if: $CI_COMMIT_BRANCH == "main"
      when: always
    - if: $CI_COMMIT_TAG
      when: always
    - when: never
```

### Common Rules

```yaml
# Nur auf main
- if: $CI_COMMIT_BRANCH == "main"

# Nur bei Tags
- if: $CI_COMMIT_TAG

# Merge Requests
- if: $CI_PIPELINE_SOURCE == "merge_request_event"

# Nicht auf Forks
- if: $CI_PROJECT_PATH == "group/project"
```

---

## Artifacts

```yaml
test:
  script:
    - phpunit --coverage-html coverage/
  artifacts:
    paths:
      - coverage/
    reports:
      coverage_report:
        coverage_format: cobertura
        path: coverage.xml
      junit: report.xml
    expire_in: 1 week
    when: always  # always, on_success, on_failure
```

---

## Cache

```yaml
default:
  cache:
    key: ${CI_COMMIT_REF_SLUG}
    paths:
      - vendor/
      - node_modules/
    policy: pull-push  # pull, push, pull-push

# Job-spezifischer Cache
test:
  cache:
    key: test-cache
    paths:
      - .cache/
```

---

## Services

```yaml
test:
  services:
    - name: mariadb:10.11
      alias: db
    - name: redis:7-alpine
  variables:
    MYSQL_DATABASE: test
    MYSQL_ROOT_PASSWORD: password
```

---

## Dependencies

```yaml
stages:
  - build
  - test

build:
  stage: build
  script: make build
  artifacts:
    paths:
      - dist/

test:
  stage: test
  needs: [build]  # Explizite Dependency
  script: make test
```

---

## Parallel Jobs

```yaml
test:
  parallel: 3
  script:
    - phpunit --testsuite=part$CI_NODE_INDEX

# Mit Matrix
test:
  parallel:
    matrix:
      - PHP_VERSION: ["8.1", "8.2", "8.3"]
        DB: ["mysql", "postgres"]
```

---

## Environments

```yaml
deploy_staging:
  stage: deploy
  script: deploy.sh
  environment:
    name: staging
    url: https://staging.example.com
  only:
    - develop

deploy_production:
  stage: deploy
  script: deploy.sh
  environment:
    name: production
    url: https://example.com
  when: manual
  only:
    - main
```

---

## Includes

```yaml
# Andere Dateien einbinden
include:
  - local: '.gitlab/ci/test.yml'
  - template: 'Security/SAST.gitlab-ci.yml'
  - project: 'group/shared-ci'
    file: '/templates/deploy.yml'
    ref: main
```

---

## Extends & Anchors

```yaml
# Template Job
.php_job: &php_defaults
  image: php:8.3
  before_script:
    - composer install

# Extend
test:
  extends: .php_job
  script:
    - phpunit

# Anchor verwenden
build:
  <<: *php_defaults
  script:
    - composer build
```

---

## Trigger

```yaml
# Downstream Pipeline triggern
trigger_child:
  trigger:
    project: group/child-project
    branch: main
    strategy: depend  # Warten auf Child
```
