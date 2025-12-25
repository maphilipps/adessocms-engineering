<script setup lang="ts">
interface Props {
  score: number
  label: string
  status?: 'critical' | 'warning' | 'success' | 'info'
  maxScore?: number
}

const props = withDefaults(defineProps<Props>(), {
  maxScore: 100,
  status: undefined
})

const computedStatus = computed(() => {
  if (props.status) return props.status
  const percentage = (props.score / props.maxScore) * 100
  if (percentage < 50) return 'critical'
  if (percentage < 75) return 'warning'
  return 'success'
})

const statusLabel = computed(() => {
  switch (computedStatus.value) {
    case 'critical': return 'Kritisch'
    case 'warning': return 'Verbesserungswürdig'
    case 'success': return 'Gut'
    case 'info': return 'Info'
    default: return ''
  }
})
</script>

<template>
  <div class="score-card" :class="computedStatus">
    <span class="score">{{ score }}</span>
    <span class="label">{{ label }}</span>
    <span class="status">{{ statusLabel }}</span>
  </div>
</template>

<style scoped>
.score-card {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1rem 1.25rem;
  border-radius: 8px;
  background: var(--vp-c-bg-soft);
  margin: 1rem 0;
}

.score {
  font-size: 2.5rem;
  font-weight: 700;
  line-height: 1;
}

.label {
  font-weight: 500;
  flex: 1;
}

.status {
  padding: 0.25rem 0.75rem;
  border-radius: 999px;
  font-size: 0.75rem;
  font-weight: 600;
  text-transform: uppercase;
}

.critical {
  border-left: 4px solid var(--adesso-red, #E31937);
}
.critical .score { color: var(--adesso-red, #E31937); }
.critical .status {
  background: rgba(227, 25, 55, 0.14);
  color: var(--adesso-red, #E31937);
}

.warning {
  border-left: 4px solid var(--adesso-orange, #F7941D);
}
.warning .score { color: var(--adesso-orange, #F7941D); }
.warning .status {
  background: rgba(247, 148, 29, 0.14);
  color: var(--adesso-orange, #F7941D);
}

.success {
  border-left: 4px solid var(--adesso-green, #00A651);
}
.success .score { color: var(--adesso-green, #00A651); }
.success .status {
  background: rgba(0, 166, 81, 0.14);
  color: var(--adesso-green, #00A651);
}

.info {
  border-left: 4px solid var(--adesso-blue, #006EC7);
}
.info .score { color: var(--adesso-blue, #006EC7); }
.info .status {
  background: rgba(0, 110, 199, 0.14);
  color: var(--adesso-blue, #006EC7);
}
</style>
