<overview>
Complete reference for Drupal.org case study format based on analysis of published case studies. Use this to ensure all sections meet Drupal.org standards.
</overview>

<metadata_fields>
## Required Metadata

| Field | Description | Example |
|-------|-------------|---------|
| Title | Engaging, descriptive title | "Setting the Stage for the 2025 World Men's Handball Championship" |
| Author | Drupal.org organization | adesso SE |
| Client | End client organization | German Handball Federation (DHB) |
| Sector | Industry category | Government, Sports, Healthcare, Education, E-commerce |
| Drupal Version | Major version | 10.x or 11.x |
| Completion Date | Project launch | December 2024 |
| Team Members | Drupal.org usernames | itothegore, smorales, philipps |
| Project URL | Live site link | https://energieatlas.bayern.de |
</metadata_fields>

<section_formats>
## Executive Summary

**Length**: 2-3 sentences
**Purpose**: Hook the reader, establish context
**Structure**: Client + Challenge + Solution approach

**Example**:
```
The German Handball Federation (DHB) partnered with adesso SE to create a fresh,
dynamic, and user-friendly website for fans and stakeholders ahead of the 2025
World Men's Handball Championship. The platform combines modern design with
powerful content management to deliver real-time updates and engaging experiences.
```

## Why Drupal Was Chosen

**Length**: 3-5 paragraphs
**Purpose**: Justify Drupal selection with concrete reasons
**Structure**: Each paragraph covers one key reason

**Common Themes**:
- Modular architecture and flexibility
- Content management capabilities (Paragraphs, workflows)
- Accessibility compliance (WCAG 2.1)
- API-first and integration capabilities
- Scalability and performance
- Community and long-term support
- Security track record

**Example Paragraph**:
```
Drupal's modular architecture was essential for this project. The Paragraphs
module enabled the editorial team to build rich, flexible layouts without
developer intervention. Combined with custom paragraph types for event
calendars and player profiles, content editors gained unprecedented control
over the site's presentation.
```

## Project Description

**Structure**: Three distinct subsections

### Goals
**Format**: Bullet list (3-5 items)
**Content**: High-level objectives

```
- Create a modern, responsive platform for championship information
- Enable real-time updates for match schedules and results
- Provide seamless integration with ticketing systems
- Ensure WCAG 2.1 AA accessibility compliance
- Support multilingual content for international audiences
```

### Requirements
**Format**: Bullet list (3-5 items)
**Content**: Technical and functional requirements

```
- High-traffic handling for peak event days (100k+ concurrent users)
- Integration with external player database APIs
- Advanced search functionality with Solr
- Multi-stage content approval workflow
- Mobile-first responsive design
```

### Outcome
**Format**: Narrative paragraph
**Content**: Results and achievements

```
The new platform launched successfully in December 2024, providing fans with
comprehensive championship coverage. The flexible content architecture enabled
the editorial team to publish real-time match updates, while the robust
infrastructure handled traffic spikes of over 150,000 concurrent users during
key matches. User engagement increased by 40% compared to the previous platform.
```

## Key Features & Technologies

**Structure**: Categorized subsections with explanations

**Categories**:
- Content Management (Paragraphs, Editorial workflows)
- Search & Discovery (Solr, Faceted search)
- Design & Frontend (Theme, CSS framework)
- Integration (APIs, External systems)
- Performance (Caching, CDN)
- Accessibility & SEO (WCAG, Meta tags)

**Example**:
```
### Content Management with Paragraphs

The Paragraphs module serves as the foundation for flexible content creation.
Custom paragraph types include:
- Hero banners with video backgrounds
- Event calendars with filtering
- Player profile cards with statistics
- News article layouts with related content

### Advanced Search with Solr

Apache Solr integration provides fast, faceted search across all content types.
Features include:
- Autocomplete suggestions
- Filtered search by date, category, and team
- Highlighted search results
- Search analytics for content optimization
```

## Technical Specifications

**Format**: Table or structured list with links

```
| Component | Details |
|-----------|---------|
| Drupal Version | 11.x |
| Key Modules | [Paragraphs](https://drupal.org/project/paragraphs), [Search API Solr](https://drupal.org/project/search_api_solr), [Migrate API](https://drupal.org/project/migrate_plus) |
| Theme | Custom theme based on Bootstrap 5 |
| Infrastructure | Docker-based deployment, 8-server cluster |
| Development | DDEV local environment, GitLab CI/CD |
```
</section_formats>

<writing_guidelines>
## Tone & Style

- **Professional**: Third-person, formal but engaging
- **Specific**: Use concrete examples and module names
- **Balanced**: Highlight achievements without overselling
- **Technical**: Include enough detail for developers
- **Accessible**: Readable by non-technical stakeholders

## Module References

Always link to Drupal.org module pages:
```
[Paragraphs](https://drupal.org/project/paragraphs)
[Search API](https://drupal.org/project/search_api)
[Migrate Plus](https://drupal.org/project/migrate_plus)
```

## Metrics & Outcomes

Include concrete numbers where possible:
- Traffic/performance metrics
- User engagement improvements
- Development timeline
- Team size
- Content volume

## Avoid

- Marketing buzzwords without substance
- Vague claims ("greatly improved")
- Focusing only on technology without business value
- Neglecting the "Why Drupal" justification
- Missing team attribution
</writing_guidelines>

<common_modules>
## Frequently Featured Modules

| Module | Use Case |
|--------|----------|
| Paragraphs | Flexible content architecture |
| Search API Solr | Advanced search |
| Migrate Plus/Tools | Content migration |
| REST/JSON:API | API integrations |
| Focal Point | Image cropping |
| Metatag | SEO optimization |
| Redirect | URL management |
| Pathauto | Clean URLs |
| Webform | Form building |
| Layout Builder | Page layouts |
| Media Library | Asset management |
| Content Moderation | Editorial workflows |
| Simple Sitemap | SEO sitemaps |
| Google Tag | Analytics |
</common_modules>
