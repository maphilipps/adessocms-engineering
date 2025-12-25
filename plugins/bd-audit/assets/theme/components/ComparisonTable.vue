<script setup lang="ts">
interface Props {
  headers: string[]
  rows: Array<{
    label: string
    values: Array<boolean | string | 'partial'>
  }>
}

defineProps<Props>()

const getValueDisplay = (value: boolean | string | 'partial'): string => {
  if (value === true) return '✓'
  if (value === false) return '✗'
  if (value === 'partial') return '◐'
  return String(value)
}

const getValueClass = (value: boolean | string | 'partial'): string => {
  if (value === true) return 'check'
  if (value === false) return 'cross'
  if (value === 'partial') return 'partial'
  return ''
}
</script>

<template>
  <div class="comparison-table">
    <table>
      <thead>
        <tr>
          <th></th>
          <th v-for="(header, index) in headers" :key="index">{{ header }}</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(row, rowIndex) in rows" :key="rowIndex">
          <td>{{ row.label }}</td>
          <td
            v-for="(value, colIndex) in row.values"
            :key="colIndex"
            :class="getValueClass(value)"
          >
            {{ getValueDisplay(value) }}
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<style scoped>
.comparison-table {
  overflow-x: auto;
  margin: 1.5rem 0;
}

table {
  width: 100%;
  border-collapse: collapse;
}

th {
  background: var(--adesso-blue, #006EC7);
  color: white;
  font-weight: 600;
  text-align: center;
  padding: 0.75rem 1rem;
}

th:first-child {
  text-align: left;
  position: sticky;
  left: 0;
  z-index: 1;
}

td {
  padding: 0.75rem 1rem;
  border-bottom: 1px solid var(--vp-c-divider);
  text-align: center;
}

td:first-child {
  text-align: left;
  font-weight: 500;
  position: sticky;
  left: 0;
  background: var(--vp-c-bg);
  z-index: 1;
}

tr:hover td {
  background: var(--vp-c-bg-soft);
}

tr:hover td:first-child {
  background: var(--vp-c-bg-soft);
}

.check {
  color: var(--adesso-green, #00A651);
  font-size: 1.25rem;
  font-weight: bold;
}

.cross {
  color: var(--adesso-red, #E31937);
  font-size: 1.25rem;
  font-weight: bold;
}

.partial {
  color: var(--adesso-orange, #F7941D);
  font-size: 1.25rem;
}
</style>
