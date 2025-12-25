<script setup lang="ts">
interface Metric {
  value: number | string
  label: string
  status?: 'critical' | 'warning' | 'success' | 'info'
}

interface Props {
  metrics: Metric[]
}

defineProps<Props>()

const getStatusClass = (metric: Metric): string => {
  if (metric.status) return metric.status
  if (typeof metric.value !== 'number') return ''

  if (metric.value < 50) return 'red'
  if (metric.value < 75) return 'orange'
  return 'green'
}
</script>

<template>
  <div class="score-dashboard">
    <div
      v-for="(metric, index) in metrics"
      :key="index"
      class="metric"
      :class="getStatusClass(metric)"
    >
      <div class="metric-value">{{ metric.value }}</div>
      <div class="metric-label">{{ metric.label }}</div>
    </div>
  </div>
</template>

<style scoped>
.score-dashboard {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  gap: 1rem;
  margin: 1.5rem 0;
}

.metric {
  background: var(--vp-c-bg-soft);
  border-radius: 8px;
  padding: 1.25rem;
  text-align: center;
}

.metric-value {
  font-size: 2rem;
  font-weight: 700;
  color: var(--adesso-blue, #006EC7);
}

.metric-label {
  font-size: 0.875rem;
  color: var(--vp-c-text-2);
  margin-top: 0.25rem;
}

.metric.red .metric-value { color: var(--adesso-red, #E31937); }
.metric.orange .metric-value { color: var(--adesso-orange, #F7941D); }
.metric.green .metric-value { color: var(--adesso-green, #00A651); }
</style>
