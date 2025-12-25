#!/usr/bin/env node

/**
 * Wappalyzer MCP Server for BD-Audit Plugin
 *
 * Provides technology detection capabilities for website audits.
 * Uses the Wappalyzer API to identify CMS, frameworks, and technologies.
 */

import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from '@modelcontextprotocol/sdk/types.js';

const WAPPALYZER_API_KEY = process.env.WAPPALYZER_API_KEY;
const WAPPALYZER_API_URL = 'https://api.wappalyzer.com/v2/lookup';

/**
 * Detect technologies for a given URL using Wappalyzer API
 */
async function detectTechnologies(url) {
  if (!WAPPALYZER_API_KEY) {
    // Fallback to basic detection without API
    return await detectTechnologiesBasic(url);
  }

  try {
    const response = await fetch(`${WAPPALYZER_API_URL}?urls=${encodeURIComponent(url)}`, {
      headers: {
        'x-api-key': WAPPALYZER_API_KEY,
      },
    });

    if (!response.ok) {
      throw new Error(`Wappalyzer API error: ${response.status}`);
    }

    const data = await response.json();
    return formatWappalyzerResponse(data);
  } catch (error) {
    console.error('Wappalyzer API error:', error);
    return await detectTechnologiesBasic(url);
  }
}

/**
 * Basic technology detection without API (fallback)
 */
async function detectTechnologiesBasic(url) {
  try {
    const response = await fetch(url, {
      headers: {
        'User-Agent': 'Mozilla/5.0 (compatible; adesso-bd-audit/1.0)',
      },
    });

    const html = await response.text();
    const headers = Object.fromEntries(response.headers);

    const detected = {
      url,
      technologies: [],
      headers: extractRelevantHeaders(headers),
    };

    // CMS Detection Patterns
    const cmsPatterns = [
      { name: 'Drupal', category: 'CMS', patterns: [/Drupal/i, /sites\/default\/files/i, /drupal\.js/i] },
      { name: 'WordPress', category: 'CMS', patterns: [/wp-content/i, /wp-includes/i, /WordPress/i] },
      { name: 'TYPO3', category: 'CMS', patterns: [/typo3/i, /typo3conf/i, /TYPO3/] },
      { name: 'Joomla', category: 'CMS', patterns: [/Joomla/i, /\/media\/jui\//i] },
      { name: 'Shopware', category: 'E-Commerce', patterns: [/shopware/i, /\/theme\/Frontend\//i] },
      { name: 'Magento', category: 'E-Commerce', patterns: [/Magento/i, /mage\/cookies\.js/i] },
      { name: 'Contentful', category: 'CMS', patterns: [/contentful/i, /cdn\.contentful\.com/i] },
      { name: 'Storyblok', category: 'CMS', patterns: [/storyblok/i, /a\.storyblok\.com/i] },
    ];

    // Framework Detection
    const frameworkPatterns = [
      { name: 'React', category: 'JavaScript Framework', patterns: [/react/i, /_react/i, /ReactDOM/i] },
      { name: 'Vue.js', category: 'JavaScript Framework', patterns: [/vue\.js/i, /Vue\./i, /vue\.runtime/i] },
      { name: 'Angular', category: 'JavaScript Framework', patterns: [/angular/i, /ng-version/i] },
      { name: 'Next.js', category: 'JavaScript Framework', patterns: [/_next/i, /next\/static/i] },
      { name: 'Nuxt.js', category: 'JavaScript Framework', patterns: [/_nuxt/i, /nuxt/i] },
      { name: 'jQuery', category: 'JavaScript Library', patterns: [/jquery/i, /jQuery/] },
      { name: 'Bootstrap', category: 'CSS Framework', patterns: [/bootstrap/i, /Bootstrap/] },
      { name: 'Tailwind CSS', category: 'CSS Framework', patterns: [/tailwindcss/i, /tailwind/i] },
    ];

    // Analytics Detection
    const analyticsPatterns = [
      { name: 'Google Analytics', category: 'Analytics', patterns: [/google-analytics\.com/i, /gtag/i, /ga\.js/i] },
      { name: 'Google Tag Manager', category: 'Tag Manager', patterns: [/googletagmanager\.com/i, /gtm\.js/i] },
      { name: 'Matomo', category: 'Analytics', patterns: [/matomo/i, /piwik/i] },
      { name: 'Hotjar', category: 'Analytics', patterns: [/hotjar/i, /static\.hotjar\.com/i] },
    ];

    // Server Detection
    const serverPatterns = [
      { name: 'Apache', category: 'Web Server', headerCheck: (h) => h['server']?.includes('Apache') },
      { name: 'nginx', category: 'Web Server', headerCheck: (h) => h['server']?.includes('nginx') },
      { name: 'Varnish', category: 'Cache', headerCheck: (h) => h['via']?.includes('varnish') || h['x-varnish'] },
      { name: 'Cloudflare', category: 'CDN', headerCheck: (h) => h['cf-ray'] || h['server']?.includes('cloudflare') },
    ];

    // Check all patterns
    [...cmsPatterns, ...frameworkPatterns, ...analyticsPatterns].forEach(({ name, category, patterns }) => {
      for (const pattern of patterns) {
        if (pattern.test(html)) {
          detected.technologies.push({ name, category, confidence: 80 });
          break;
        }
      }
    });

    // Check server headers
    serverPatterns.forEach(({ name, category, headerCheck }) => {
      if (headerCheck(headers)) {
        detected.technologies.push({ name, category, confidence: 100 });
      }
    });

    // Remove duplicates
    detected.technologies = [...new Map(detected.technologies.map(t => [t.name, t])).values()];

    return detected;
  } catch (error) {
    return {
      url,
      error: `Detection failed: ${error.message}`,
      technologies: [],
    };
  }
}

/**
 * Extract relevant headers for analysis
 */
function extractRelevantHeaders(headers) {
  const relevant = [
    'server', 'x-powered-by', 'x-generator', 'x-drupal-cache',
    'x-varnish', 'cf-ray', 'x-cdn', 'content-type',
  ];

  return Object.fromEntries(
    Object.entries(headers).filter(([key]) =>
      relevant.some(r => key.toLowerCase().includes(r))
    )
  );
}

/**
 * Format Wappalyzer API response
 */
function formatWappalyzerResponse(data) {
  if (!data || !data[0]) {
    return { technologies: [], error: 'No data returned' };
  }

  const result = data[0];
  return {
    url: result.url,
    technologies: (result.technologies || []).map(tech => ({
      name: tech.name,
      category: tech.categories?.[0]?.name || 'Unknown',
      version: tech.version || null,
      confidence: tech.confidence || 100,
      website: tech.website || null,
    })),
    meta: {
      language: result.meta?.language,
      title: result.title,
    },
  };
}

// Create MCP Server
const server = new Server(
  {
    name: 'wappalyzer',
    version: '1.0.0',
  },
  {
    capabilities: {
      tools: {},
    },
  }
);

// List available tools
server.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: [
    {
      name: 'detect_technologies',
      description: 'Detect technologies used on a website (CMS, frameworks, analytics, etc.)',
      inputSchema: {
        type: 'object',
        properties: {
          url: {
            type: 'string',
            description: 'The URL to analyze (e.g., https://example.com)',
          },
        },
        required: ['url'],
      },
    },
    {
      name: 'detect_cms',
      description: 'Detect the Content Management System (CMS) used on a website',
      inputSchema: {
        type: 'object',
        properties: {
          url: {
            type: 'string',
            description: 'The URL to analyze',
          },
        },
        required: ['url'],
      },
    },
    {
      name: 'compare_technologies',
      description: 'Compare technologies between two websites',
      inputSchema: {
        type: 'object',
        properties: {
          url1: {
            type: 'string',
            description: 'First URL to analyze',
          },
          url2: {
            type: 'string',
            description: 'Second URL to analyze',
          },
        },
        required: ['url1', 'url2'],
      },
    },
  ],
}));

// Handle tool calls
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;

  switch (name) {
    case 'detect_technologies': {
      const result = await detectTechnologies(args.url);
      return {
        content: [
          {
            type: 'text',
            text: JSON.stringify(result, null, 2),
          },
        ],
      };
    }

    case 'detect_cms': {
      const result = await detectTechnologies(args.url);
      const cmsCategories = ['CMS', 'E-Commerce', 'Blog', 'Wiki'];
      const cms = result.technologies?.filter(t =>
        cmsCategories.some(cat => t.category?.toLowerCase().includes(cat.toLowerCase()))
      ) || [];

      return {
        content: [
          {
            type: 'text',
            text: JSON.stringify({
              url: args.url,
              cms: cms.length > 0 ? cms[0] : null,
              allCms: cms,
            }, null, 2),
          },
        ],
      };
    }

    case 'compare_technologies': {
      const [result1, result2] = await Promise.all([
        detectTechnologies(args.url1),
        detectTechnologies(args.url2),
      ]);

      const tech1Names = new Set(result1.technologies?.map(t => t.name) || []);
      const tech2Names = new Set(result2.technologies?.map(t => t.name) || []);

      const common = [...tech1Names].filter(t => tech2Names.has(t));
      const only1 = [...tech1Names].filter(t => !tech2Names.has(t));
      const only2 = [...tech2Names].filter(t => !tech1Names.has(t));

      return {
        content: [
          {
            type: 'text',
            text: JSON.stringify({
              url1: args.url1,
              url2: args.url2,
              common,
              onlyInUrl1: only1,
              onlyInUrl2: only2,
              details: {
                url1: result1,
                url2: result2,
              },
            }, null, 2),
          },
        ],
      };
    }

    default:
      throw new Error(`Unknown tool: ${name}`);
  }
});

// Start server
async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  console.error('Wappalyzer MCP Server running on stdio');
}

main().catch(console.error);
