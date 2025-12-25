<script setup lang="ts">
interface Props {
  value: number
  max?: number
  status?: 'critical' | 'warning' | 'success' | 'info'
  showLabel?: boolean
}

const props = withDefaults(defineProps<Props>(), {
  max: 100,
  showLabel: true
})

const percentage = computed(() => Math.min(100, (props.value / props.max) * 100))

const computedStatus = computed(() => {
  if (props.status) return props.status
  if (percentage.value < 50) return 'critical'
  if (percentage.value < 75) return 'warning'
  return 'success'
})
</script>

<template>
  <div class="progress-container">
    <div v-if="showLabel" class="progress-label">
      <span>{{ value }}/{{ max }}</span>
      <span class="percentage">{{ Math.round(percentage) }}%</span>
    </div>
    <div class="progress-bar">
      <div
        class="fill"
        :class="computedStatus"
        :style="{ width: `${percentage}%` }"
      />
    </div>
  </div>
</template>

<style scoped>
.progress-container {
  margin: 0.5rem 0;
}

.progress-label {
  display: flex;
  justify-content: space-between;
  font-size: 0.875rem;
  margin-bottom: 0.25rem;
}

.percentage {
  font-weight: 600;
}

.progress-bar {
  height: 8px;
  background: var(--vp-c-bg-soft);
  border-radius: 4px;
  overflow: hidden;
}

.fill {
  height: 100%;
  border-radius: 4px;
  transition: width 0.3s ease;
}

.fill.critical { background: var(--adesso-red, #E31937); }
.fill.warning { background: var(--adesso-orange, #F7941D); }
.fill.success { background: var(--adesso-green, #00A651); }
.fill.info { background: var(--adesso-blue, #006EC7); }
</style>
