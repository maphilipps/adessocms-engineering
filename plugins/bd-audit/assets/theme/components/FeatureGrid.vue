<script setup lang="ts">
interface Feature {
  icon: string
  title: string
  description: string
}

interface Props {
  features: Feature[]
}

defineProps<Props>()
</script>

<template>
  <div class="feature-grid">
    <div v-for="(feature, index) in features" :key="index" class="feature-card">
      <div class="icon">{{ feature.icon }}</div>
      <div class="title">{{ feature.title }}</div>
      <div class="description">{{ feature.description }}</div>
    </div>
  </div>
</template>

<style scoped>
.feature-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
  margin: 1.5rem 0;
}

.feature-card {
  background: var(--vp-c-bg-soft);
  border-radius: 12px;
  padding: 1.5rem;
  transition: transform 0.2s, box-shadow 0.2s;
}

.feature-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
}

.icon {
  font-size: 2rem;
  margin-bottom: 0.75rem;
}

.title {
  font-weight: 600;
  font-size: 1.1rem;
  margin-bottom: 0.5rem;
}

.description {
  font-size: 0.875rem;
  color: var(--vp-c-text-2);
}
</style>
