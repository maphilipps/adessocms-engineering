<script setup lang="ts">
interface TimelineItem {
  date: string
  title: string
  description?: string
  status?: 'completed' | 'current' | 'pending'
}

interface Props {
  items: TimelineItem[]
}

defineProps<Props>()
</script>

<template>
  <div class="timeline">
    <div
      v-for="(item, index) in items"
      :key="index"
      class="timeline-item"
      :class="item.status"
    >
      <div class="date">{{ item.date }}</div>
      <div class="title">{{ item.title }}</div>
      <div v-if="item.description" class="description">{{ item.description }}</div>
    </div>
  </div>
</template>

<style scoped>
.timeline {
  position: relative;
  padding-left: 2rem;
  margin: 1.5rem 0;
}

.timeline::before {
  content: '';
  position: absolute;
  left: 0.5rem;
  top: 0;
  bottom: 0;
  width: 2px;
  background: var(--vp-c-divider);
}

.timeline-item {
  position: relative;
  padding-bottom: 1.5rem;
}

.timeline-item::before {
  content: '';
  position: absolute;
  left: -1.625rem;
  top: 0.25rem;
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: var(--vp-c-divider);
  border: 2px solid var(--vp-c-bg);
}

.timeline-item.completed::before {
  background: var(--adesso-green, #00A651);
}

.timeline-item.current::before {
  background: var(--adesso-orange, #F7941D);
  box-shadow: 0 0 0 4px rgba(247, 148, 29, 0.2);
}

.timeline-item.pending::before {
  background: var(--vp-c-divider);
}

.date {
  font-size: 0.75rem;
  color: var(--vp-c-text-2);
  margin-bottom: 0.25rem;
}

.title {
  font-weight: 600;
  margin-bottom: 0.25rem;
}

.description {
  font-size: 0.875rem;
  color: var(--vp-c-text-2);
}
</style>
