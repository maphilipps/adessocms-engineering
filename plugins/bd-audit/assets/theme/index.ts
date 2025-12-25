/**
 * adesso VitePress Theme
 * Custom theme for BD-Audit Reports
 */

import DefaultTheme from 'vitepress/theme'
import type { Theme } from 'vitepress'
import './custom.css'

// Custom Components
import ScoreCard from './components/ScoreCard.vue'
import ScoreDashboard from './components/ScoreDashboard.vue'
import Timeline from './components/Timeline.vue'
import ProgressBar from './components/ProgressBar.vue'
import FeatureGrid from './components/FeatureGrid.vue'
import ComparisonTable from './components/ComparisonTable.vue'

export default {
  extends: DefaultTheme,
  enhanceApp({ app }) {
    // Register global components
    app.component('ScoreCard', ScoreCard)
    app.component('ScoreDashboard', ScoreDashboard)
    app.component('Timeline', Timeline)
    app.component('ProgressBar', ProgressBar)
    app.component('FeatureGrid', FeatureGrid)
    app.component('ComparisonTable', ComparisonTable)
  }
} satisfies Theme
