# Universal UX & Visual Standards

**ABOUTME:** Comprehensive UX and visual design standards for personal and professional applications
**ABOUTME:** Version 2.0 - Generalized standards with personal and professional theme variants

## Table of Contents

1. [Overview](#1-overview)
2. [Design Principles](#2-design-principles)
3. [Color System](#3-color-system)
4. [Typography](#4-typography)
5. [Spacing & Layout](#5-spacing--layout)
6. [Component Standards](#6-component-standards)
7. [Interaction Patterns](#7-interaction-patterns)
8. [Accessibility Requirements](#8-accessibility-requirements)
9. [Implementation Guidelines](#9-implementation-guidelines)
10. [Project Application](#10-project-application)

---

## 1. Overview

### 1.1 Purpose

These standards provide a unified design language for all applications, ensuring consistency across personal and professional projects while maintaining flexibility for context-specific customization. This document serves as a reference for AI coding agents to implement consistent, accessible, and modern user interfaces.

### 1.2 Scope

Applies to all projects including:
- Personal applications and tools
- Professional business applications  
- Data visualization and analytics platforms
- Web applications and dashboards
- Internal tools and utilities

### 1.3 Design System References

This system draws inspiration from and is compatible with:
- **Material Design 3** (Google) - Component patterns and accessibility
- **Tailwind CSS** - Utility-first approach and color system
- **Ant Design** - Enterprise-focused component library
- **Chakra UI** - Simple, modular component architecture
- **Apple Human Interface Guidelines** - User experience principles

### 1.4 AI Agent Implementation Notes

When implementing these standards:
- Use semantic HTML5 elements for accessibility
- Implement responsive design with mobile-first approach  
- Follow WCAG 2.1 AA accessibility guidelines
- Use CSS custom properties for theme switching
- Implement components with proper ARIA labels
- Use design tokens for consistent spacing and sizing

### 1.5 Compliance

All new projects must follow these standards. Existing projects should adopt these standards during major updates or redesigns.

---

## 2. Design Principles

### 2.1 Primary Principles

- **Clarity**: Information hierarchy must be immediately apparent
- **Efficiency**: Minimize cognitive load and clicks to complete tasks
- **Consistency**: UI patterns should be identical across all applications
- **Accessibility**: WCAG 2.1 AA compliance mandatory
- **Data-Forward**: Visualizations and insights take visual precedence
- **Professional**: Enterprise-appropriate styling for healthcare environments

### 2.2 Visual Language

- **Clean**: Minimalist approach with purposeful whitespace
- **Professional**: Business-appropriate for enterprise environments
- **Purposeful**: Every element serves a specific function
- **Context-Aware**: Support for personal vs professional styling themes

### 2.3 User Experience Priorities

1. **Task Completion**: Users accomplish goals with minimal friction
2. **Information Discovery**: Data insights are easily discoverable
3. **Context Awareness**: Users always understand their current location
4. **Error Prevention**: Design prevents user mistakes
5. **Performance**: Perceived and actual performance optimized

---

## 3. Color System

### 3.1 Theme Variants

#### 3.1.1 Personal Theme (Muted Light Blue & Earth Tones)

```css
/* Personal Theme - Muted & Light */
--primary: #7dd3fc;            /* Soft Sky Blue */
--primary-dark: #0ea5e9;       /* Medium Blue (hover) */
--secondary: #a3a3a3;          /* Warm Gray */
--accent: #d4d4aa;             /* Sage Green */

/* Earth Tone Accents */
--earth-warm: #d4a574;         /* Warm Sand */
--earth-cool: #94a3b8;         /* Cool Stone */
--earth-green: #a7c957;        /* Soft Moss */
--earth-brown: #a8a29e;        /* Warm Taupe */
```

#### 3.1.2 Professional Theme (Darker Blue & Green)

```css
/* Professional Theme - Darker & Bold */
--primary: #1e40af;            /* Deep Blue */
--primary-dark: #1e3a8a;       /* Darker Blue (hover) */
--secondary: #059669;          /* Professional Green */
--accent: #374151;             /* Charcoal */

/* Professional Accents */
--prof-teal: #0f766e;          /* Deep Teal */
--prof-slate: #475569;         /* Professional Slate */
--prof-emerald: #047857;       /* Deep Emerald */
--prof-navy: #1e293b;          /* Navy Blue */
```

### 3.2 Semantic Colors (Theme Neutral)

```css
/* Universal Status & Feedback */
--success-color: #10b981;      /* Green */
--warning-color: #f59e0b;      /* Amber */
--error-color: #ef4444;        /* Red */
--info-color: #3b82f6;         /* Blue */

/* Application Context */
--high-priority: #10b981;      /* Active/Important */
--medium-priority: #f59e0b;    /* Moderate */
--low-priority: #ef4444;       /* Inactive/Optional */
--neutral-priority: #6b7280;   /* Archived/Disabled */
```

### 3.3 Neutral Palette

```css
/* Grays (Tailwind-based) */
--gray-50: #f9fafb;            /* Background */
--gray-100: #f3f4f6;           /* Light Background */
--gray-200: #e5e7eb;           /* Borders */
--gray-300: #d1d5db;           /* Muted Borders */
--gray-400: #9ca3af;           /* Icons */
--gray-500: #6b7280;           /* Body Text */
--gray-600: #4b5563;           /* Headings */
--gray-700: #374151;           /* Dark Text */
--gray-800: #1f2937;           /* Primary Text */
--gray-900: #111827;           /* High Emphasis */
```

### 3.4 Data Visualization Palette

```css
/* Categorical (up to 12 categories) */
--cat-1: #0073E6;
--cat-2: #00ABA9;
--cat-3: #7DC36C;
--cat-4: #F1C232;
--cat-5: #E67C00;
--cat-6: #BE4D25;
--cat-7: #7030A0;
--cat-8: #004A7F;
--cat-9: #009A93;
--cat-10: #C3D69B;
--cat-11: #FFD966;
--cat-12: #F4B183;

/* Sequential (6 steps) */
--seq-1: #E6F2FF;
--seq-2: #B3D7FF;
--seq-3: #80BDFF;
--seq-4: #4DA3FF;
--seq-5: #1A88FF;
--seq-6: #0073E6;

/* Diverging (3 point) */
--div-low: #D83933;
--div-mid: #FFC107;
--div-high: #2E8540;
```

### 3.5 Context-Specific Colors

```css
/* Data Categories */
--category-1: #166534;         /* Green */
--category-2: #92400e;         /* Amber */
--category-3: #3730a3;         /* Indigo */
--category-4: #be185d;         /* Pink */
--category-5: #6b21a8;         /* Purple */

/* Data Status */
--active-data: #10b981;        /* Recently updated */
--static-data: #f59e0b;        /* Occasional updates */
--archived-data: #6b7280;      /* Archive only */
--deprecated-data: #ef4444;    /* Needs attention */
```

---

## 4. Typography

### 4.1 Font Families

```css
/* Primary: Modern, clean, excellent readability */
--font-primary: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;

/* Alternative: Open Sans (legacy support) */
--font-alt: 'Open Sans', sans-serif;

/* Secondary: Technical contexts */
--font-secondary: 'Roboto', sans-serif;

/* Monospace: Code, data, technical */
--font-mono: 'JetBrains Mono', Menlo, Monaco, 'Courier New', monospace;
```

### 4.2 Typography Scale

```css
/* Headers */
--text-4xl: 32px;              /* Page Titles */
--text-3xl: 28px;              /* Section Headers */
--text-2xl: 24px;              /* Component Headers */
--text-xl: 18px;               /* Sub-headers */

/* Body Text */
--text-lg: 16px;               /* Large Body */
--text-base: 14px;             /* Default Body */
--text-sm: 13px;               /* Small Body */
--text-xs: 12px;               /* Captions */
--text-2xs: 11px;              /* Fine Print */
```

### 4.3 Font Weights

```css
--font-light: 300;             /* Supporting text */
--font-normal: 400;            /* Body text */
--font-medium: 500;            /* Emphasis */
--font-semibold: 600;          /* Sub-headers */
--font-bold: 700;              /* Headers */
```

### 4.4 Line Heights

```css
--leading-tight: 1.25;         /* Headers */
--leading-snug: 1.375;         /* Sub-headers */
--leading-normal: 1.5;         /* Body text */
--leading-relaxed: 1.625;      /* Long-form content */
```

---

## 5. Spacing & Layout

### 5.1 Spacing System

```css
/* Base Unit: 8px for consistent rhythm */
--space-1: 4px;                /* 0.5 units */
--space-2: 8px;                /* 1 unit - base */
--space-3: 12px;               /* 1.5 units */
--space-4: 16px;               /* 2 units */
--space-5: 20px;               /* 2.5 units */
--space-6: 24px;               /* 3 units */
--space-8: 32px;               /* 4 units */
--space-10: 40px;              /* 5 units */
--space-12: 48px;              /* 6 units */
--space-16: 64px;              /* 8 units */

/* Named Spacing */
--space-xs: 4px;
--space-sm: 8px;
--space-md: 16px;
--space-lg: 24px;
--space-xl: 32px;
--space-2xl: 48px;
```

### 5.2 Container Widths

```css
--container-sm: 576px;         /* Small devices */
--container-md: 768px;         /* Medium devices */
--container-lg: 992px;         /* Large devices */
--container-xl: 1200px;        /* Extra large devices */
--container-2xl: 1400px;       /* Maximum content width */
```

### 5.3 Border Radius

```css
--radius-none: 0px;
--radius-sm: 0.375rem;         /* 6px - buttons, small cards */
--radius-md: 0.5rem;           /* 8px - default components */
--radius-lg: 0.75rem;          /* 12px - cards, panels */
--radius-xl: 1rem;             /* 16px - large panels */
--radius-2xl: 1.5rem;          /* 24px - major components */
--radius-full: 9999px;         /* Pills, avatars */
```

### 5.4 Shadows

```css
--shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
--shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
--shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
--shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
```

### 5.5 Grid System

```css
/* 12-column responsive grid */
.grid-container {
  display: grid;
  grid-template-columns: repeat(12, 1fr);
  gap: var(--space-6);
}

/* Common spans */
.col-1 { grid-column: span 1; }
.col-2 { grid-column: span 2; }
.col-3 { grid-column: span 3; }
.col-4 { grid-column: span 4; }
.col-6 { grid-column: span 6; }
.col-8 { grid-column: span 8; }
.col-12 { grid-column: span 12; }
```

---

## 6. Component Standards

### 6.1 Navigation Components

#### Header Component
```css
.header {
  background: white;
  border-bottom: 1px solid var(--gray-200);
  padding: var(--space-4) var(--space-6);
  box-shadow: var(--shadow-sm);
  position: sticky;
  top: 0;
  z-index: 100;
}
```

#### Breadcrumbs
```css
.breadcrumb {
  font-size: var(--text-sm);
  color: var(--gray-600);
}

.breadcrumb-item.current {
  color: var(--gray-900);
  font-weight: var(--font-medium);
}
```

### 6.2 Data Display Components

#### KPI Cards
```css
.kpi-card {
  background: white;
  padding: var(--space-6);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-md);
  border-left: 4px solid var(--primary);
  transition: all 150ms ease;
}

.kpi-card:hover {
  box-shadow: var(--shadow-lg);
  transform: translateY(-2px);
}

.kpi-value {
  font-size: var(--text-4xl);
  font-weight: var(--font-bold);
  color: var(--gray-900);
  margin-bottom: var(--space-2);
}
```

#### Data Tables
```css
.data-table {
  width: 100%;
  border-collapse: collapse;
  background: white;
  border-radius: var(--radius-lg);
  overflow: hidden;
  box-shadow: var(--shadow-md);
}

.data-table th {
  background: var(--gray-50);
  padding: var(--space-4);
  text-align: left;
  font-weight: var(--font-semibold);
  color: var(--gray-700);
  border-bottom: 1px solid var(--gray-200);
}

.data-table td {
  padding: var(--space-4);
  border-bottom: 1px solid var(--gray-100);
}

.data-table tr:hover {
  background: var(--gray-50);
}
```

### 6.3 Form Components

#### Buttons
```css
.btn {
  border: none;
  cursor: pointer;
  font-family: inherit;
  font-size: var(--text-sm);
  font-weight: var(--font-medium);
  border-radius: var(--radius-md);
  padding: var(--space-2) var(--space-4);
  transition: all 150ms ease;
  white-space: nowrap;
}

.btn-primary {
  background: var(--primary);
  color: white;
}

.btn-primary:hover {
  background: var(--primary-dark);
}

.btn-secondary {
  background: var(--gray-200);
  color: var(--gray-700);
}

.btn-secondary:hover {
  background: var(--gray-300);
}
```

#### Form Inputs
```css
.form-input {
  padding: var(--space-2) var(--space-3);
  border: 1px solid var(--gray-300);
  border-radius: var(--radius-md);
  font-size: var(--text-base);
  background: white;
  transition: border-color 150ms ease;
}

.form-input:focus {
  outline: 2px solid var(--primary);
  outline-offset: 2px;
  border-color: var(--primary);
}
```

### 6.4 Status & Feedback Components

#### Status Badges
```css
.status-badge {
  padding: var(--space-1) var(--space-2);
  border-radius: var(--radius-sm);
  font-size: var(--text-xs);
  font-weight: var(--font-semibold);
  text-transform: uppercase;
  letter-spacing: 0.025em;
}

.status-badge.active {
  background: #dcfce7;
  color: #166534;
}

.status-badge.static {
  background: #fef3c7;
  color: #92400e;
}

.status-badge.vault {
  background: var(--gray-100);
  color: var(--gray-600);
}
```

#### Trend Indicators
```css
.trend-indicator {
  font-size: var(--text-sm);
  font-weight: var(--font-medium);
  padding: var(--space-1) var(--space-2);
  border-radius: var(--radius-sm);
}

.trend-indicator.positive {
  background: #dcfce7;
  color: #166534;
}

.trend-indicator.negative {
  background: #fee2e2;
  color: #991b1b;
}

.trend-indicator.neutral {
  background: var(--gray-100);
  color: var(--gray-600);
}
```

---

## 7. Interaction Patterns

### 7.1 Animation & Transitions

```css
/* Standard transitions */
--transition-fast: 150ms cubic-bezier(0.4, 0, 0.2, 1);
--transition-normal: 300ms cubic-bezier(0.4, 0, 0.2, 1);
--transition-slow: 500ms cubic-bezier(0.4, 0, 0.2, 1);

/* Hover states */
.interactive:hover {
  transform: translateY(-2px);
  box-shadow: var(--shadow-lg);
  transition: all var(--transition-fast);
}
```

### 7.2 Loading States

```css
.loading {
  opacity: 0.6;
  pointer-events: none;
  position: relative;
}

.loading::after {
  content: "";
  position: absolute;
  top: 50%;
  left: 50%;
  width: 20px;
  height: 20px;
  margin: -10px;
  border: 2px solid var(--primary);
  border-top-color: transparent;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}
```

### 7.3 Focus States

```css
.focusable:focus {
  outline: 2px solid var(--primary);
  outline-offset: 2px;
}

/* Remove default focus for mouse users */
.focusable:focus:not(:focus-visible) {
  outline: none;
}
```

### 7.4 Interactive Behaviors

- **Hover**: 150ms transition to elevated state
- **Click**: Immediate visual feedback
- **Drag**: Visual indicator of draggable state
- **Select**: Clear visual distinction from unselected
- **Disable**: Reduced opacity and no pointer events

---

## 8. Accessibility Requirements

### 8.1 Color & Contrast

- **Text Contrast**: Minimum 4.5:1 for normal text, 3:1 for large text (18px+)
- **Interactive Elements**: Minimum 3:1 contrast ratio
- **Color Independence**: Never use color as the only means of conveying information
- **Focus Indicators**: Visible focus indicators for all interactive elements

### 8.2 Typography

- **Minimum Size**: 14px for body text, 12px for supporting text
- **Relative Units**: Use rem/em for scalability
- **Line Height**: Minimum 1.5x for body text
- **Text Spacing**: Adequate spacing between lines and paragraphs

### 8.3 Keyboard Navigation

- **Tab Order**: Logical sequence through interactive elements
- **Skip Links**: Bypass navigation to main content
- **Keyboard Shortcuts**: Support standard browser shortcuts
- **Trapped Focus**: Proper modal and popup focus management

### 8.4 Screen Reader Support

- **Semantic HTML**: Use proper heading hierarchy (h1-h6)
- **ARIA Labels**: Descriptive labels for complex interfaces
- **Alt Text**: Descriptive alternatives for images and charts
- **Live Regions**: Announce dynamic content changes

### 8.5 WCAG 2.1 AA Compliance

All components must meet WCAG 2.1 AA standards:
- **Perceivable**: Information presentable in multiple ways
- **Operable**: Interface components operable by various input methods
- **Understandable**: Information and UI operation is understandable
- **Robust**: Content robust enough for assistive technologies

---

## 9. Implementation Guidelines

### 9.1 CSS Architecture

#### 9.1.1 Design Tokens (CSS Custom Properties)

```css
/* Design tokens - similar to Tailwind CSS approach */
:root {
  /* Personal theme (default) - inspired by Tailwind's sky palette */
  --primary: #7dd3fc;           /* Tailwind sky-300 */
  --primary-dark: #0ea5e9;      /* Tailwind sky-500 */
  --secondary: #a3a3a3;         /* Tailwind neutral-400 */
  
  /* Spacing scale - 8px base like Material Design */
  --space-1: 0.25rem;           /* 4px */
  --space-2: 0.5rem;            /* 8px */
  --space-3: 0.75rem;           /* 12px */
  --space-4: 1rem;              /* 16px */
  --space-6: 1.5rem;            /* 24px */
  --space-8: 2rem;              /* 32px */
  
  /* Typography scale - similar to Material Design Type Scale */
  --text-xs: 0.75rem;           /* 12px */
  --text-sm: 0.875rem;          /* 14px */
  --text-base: 1rem;            /* 16px */
  --text-lg: 1.125rem;          /* 18px */
  --text-xl: 1.25rem;           /* 20px */
  --text-2xl: 1.5rem;           /* 24px */
  
  /* Border radius - Tailwind-inspired */
  --radius-sm: 0.375rem;        /* 6px */
  --radius-md: 0.5rem;          /* 8px */
  --radius-lg: 0.75rem;         /* 12px */
  
  /* Shadows - Material Design elevation */
  --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
  --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1);
  --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1);
}

/* Professional theme override - inspired by Tailwind's blue/slate palette */
[data-theme="professional"] {
  --primary: #1e40af;           /* Tailwind blue-800 */
  --primary-dark: #1e3a8a;      /* Tailwind blue-900 */
  --secondary: #059669;         /* Tailwind emerald-600 */
}
```

#### 9.1.2 Component Architecture (BEM Methodology)

```css
/* Block Element Modifier (BEM) methodology */
.component {
  /* Base component styles */
}

.component__element {
  /* Element within component */
}

.component--modifier {
  /* Component variation */
}

/* Example: Button component */
.btn {
  /* Base button styles */
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: var(--space-2) var(--space-4);
  border-radius: var(--radius-md);
  font-weight: 500;
  transition: all 150ms ease;
}

.btn__icon {
  /* Icon within button */
  margin-right: var(--space-1);
}

.btn--primary {
  /* Primary button variant */
  background: var(--primary);
  color: white;
}

.btn--secondary {
  /* Secondary button variant */
  background: var(--gray-200);
  color: var(--gray-700);
}
```

### 9.2 Component Library Structure

#### 9.2.1 React Components (Material-UI/Chakra UI Pattern)

```javascript
// React component with proper TypeScript and accessibility
import React from 'react';
import { cn } from '@/lib/utils'; // Tailwind merge utility

interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: 'primary' | 'secondary' | 'outline';
  size?: 'sm' | 'md' | 'lg';
  children: React.ReactNode;
  loading?: boolean;
}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ variant = 'primary', size = 'md', children, loading, className, ...props }, ref) => {
    return (
      <button
        ref={ref}
        className={cn(
          // Base styles (similar to Tailwind/Shadcn approach)
          'inline-flex items-center justify-center rounded-md font-medium transition-colors',
          'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary',
          'disabled:pointer-events-none disabled:opacity-50',
          
          // Variant styles
          {
            'bg-primary text-white hover:bg-primary-dark': variant === 'primary',
            'bg-gray-200 text-gray-700 hover:bg-gray-300': variant === 'secondary',
            'border border-gray-300 bg-white hover:bg-gray-50': variant === 'outline',
          },
          
          // Size styles
          {
            'h-8 px-3 text-sm': size === 'sm',
            'h-10 px-4 text-base': size === 'md',
            'h-12 px-6 text-lg': size === 'lg',
          },
          
          className
        )}
        disabled={loading}
        {...props}
      >
        {loading && (
          <svg className="mr-2 h-4 w-4 animate-spin" viewBox="0 0 24 24">
            <circle
              className="opacity-25"
              cx="12"
              cy="12"
              r="10"
              stroke="currentColor"
              strokeWidth="4"
            />
            <path
              className="opacity-75"
              fill="currentColor"
              d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
            />
          </svg>
        )}
        {children}
      </button>
    );
  }
);

Button.displayName = 'Button';

export { Button, type ButtonProps };
```

#### 9.2.2 Vue Components (Ant Design Vue Pattern)

```vue
<template>
  <button
    :class="buttonClasses"
    :disabled="loading || disabled"
    v-bind="$attrs"
    @click="handleClick"
  >
    <LoadingIcon v-if="loading" class="mr-2" />
    <slot />
  </button>
</template>

<script setup lang="ts">
import { computed } from 'vue';

interface Props {
  variant?: 'primary' | 'secondary' | 'outline';
  size?: 'sm' | 'md' | 'lg';
  loading?: boolean;
  disabled?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  variant: 'primary',
  size: 'md',
  loading: false,
  disabled: false,
});

const emit = defineEmits<{
  click: [event: MouseEvent];
}>();

const buttonClasses = computed(() => [
  'btn',
  `btn--${props.variant}`,
  `btn--${props.size}`,
  { 'btn--loading': props.loading }
]);

const handleClick = (event: MouseEvent) => {
  if (!props.loading && !props.disabled) {
    emit('click', event);
  }
};
</script>
```

#### 9.2.3 Svelte Components (Carbon Design System Pattern)

```svelte
<script lang="ts">
  export let variant: 'primary' | 'secondary' | 'outline' = 'primary';
  export let size: 'sm' | 'md' | 'lg' = 'md';
  export let loading = false;
  export let disabled = false;
  
  $: buttonClass = [
    'btn',
    `btn--${variant}`,
    `btn--${size}`,
    loading && 'btn--loading'
  ].filter(Boolean).join(' ');
</script>

<button
  class={buttonClass}
  {disabled}
  on:click
  {...$$restProps}
>
  {#if loading}
    <div class="btn__spinner" />
  {/if}
  <slot />
</button>

<style>
  .btn {
    @apply inline-flex items-center justify-center rounded-md font-medium transition-colors;
    @apply focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary;
  }
  
  .btn--primary {
    @apply bg-primary text-white hover:bg-primary-dark;
  }
  
  .btn--secondary {
    @apply bg-gray-200 text-gray-700 hover:bg-gray-300;
  }
  
  .btn__spinner {
    @apply mr-2 h-4 w-4 animate-spin border-2 border-current border-t-transparent rounded-full;
  }
</style>
```

### 9.3 Responsive Design (Tailwind CSS Breakpoints)

```css
/* Mobile-first breakpoints - Tailwind CSS standard */
@media (min-width: 640px) { /* sm: Small devices */ }
@media (min-width: 768px) { /* md: Medium devices */ }
@media (min-width: 1024px) { /* lg: Large devices */ }
@media (min-width: 1280px) { /* xl: Extra large devices */ }
@media (min-width: 1536px) { /* 2xl: 2X large devices */ }

/* Layout adaptations using CSS Grid (similar to Material Design) */
.dashboard-grid {
  display: grid;
  gap: var(--space-6);
  grid-template-columns: 1fr;
}

/* Tablet layout */
@media (min-width: 768px) {
  .dashboard-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

/* Desktop layout */
@media (min-width: 1024px) {
  .dashboard-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}

/* Large desktop layout */
@media (min-width: 1280px) {
  .dashboard-grid {
    grid-template-columns: repeat(4, 1fr);
  }
}

/* Container queries for component-level responsiveness */
@container (min-width: 320px) {
  .card {
    padding: var(--space-4);
  }
}

@container (min-width: 640px) {
  .card {
    padding: var(--space-6);
  }
}
```

### 9.4 Dark Mode Support (Tailwind CSS Pattern)

```css
/* Dark mode using class-based strategy (like Tailwind) */
.dark {
  color-scheme: dark;
}

/* Dark mode color overrides */
.dark {
  --gray-50: #18181b;     /* zinc-900 */
  --gray-100: #27272a;    /* zinc-800 */
  --gray-200: #3f3f46;    /* zinc-700 */
  --gray-300: #52525b;    /* zinc-600 */
  --gray-400: #71717a;    /* zinc-500 */
  --gray-500: #a1a1aa;    /* zinc-400 */
  --gray-600: #d4d4d8;    /* zinc-300 */
  --gray-700: #e4e4e7;    /* zinc-200 */
  --gray-800: #f4f4f5;    /* zinc-100 */
  --gray-900: #fafafa;    /* zinc-50 */
}

/* Personal theme dark mode */
.dark[data-theme="personal"] {
  --primary: #0ea5e9;           /* Slightly darker sky blue */
  --primary-dark: #0284c7;      /* Even darker for contrast */
  --secondary: #71717a;         /* Muted gray */
}

/* Professional theme dark mode */
.dark[data-theme="professional"] {
  --primary: #3b82f6;           /* Brighter blue for dark bg */
  --primary-dark: #2563eb;      /* Slightly darker */
  --secondary: #10b981;         /* Bright emerald */
}

/* Auto dark mode detection */
@media (prefers-color-scheme: dark) {
  :root {
    /* Auto-apply dark mode if no manual preference */
  }
}
```

### 9.5 Framework Integration Examples

#### 9.5.1 Next.js + Tailwind CSS Setup

```javascript
// tailwind.config.js
module.exports = {
  content: ['./src/**/*.{js,ts,jsx,tsx,mdx}'],
  theme: {
    extend: {
      colors: {
        primary: 'var(--primary)',
        'primary-dark': 'var(--primary-dark)',
        secondary: 'var(--secondary)',
      },
      spacing: {
        'space-1': 'var(--space-1)',
        'space-2': 'var(--space-2)',
        'space-4': 'var(--space-4)',
        'space-6': 'var(--space-6)',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
  ],
};

// globals.css
@import 'tailwindcss/base';
@import 'tailwindcss/components';
@import 'tailwindcss/utilities';

:root {
  /* Design tokens defined here */
  --primary: #7dd3fc;
  --primary-dark: #0ea5e9;
  /* ... rest of tokens */
}
```

#### 9.5.2 Nuxt.js + UnoCSS Setup

```javascript
// nuxt.config.ts
export default defineNuxtConfig({
  modules: ['@unocss/nuxt'],
  unocss: {
    theme: {
      colors: {
        primary: 'var(--primary)',
        'primary-dark': 'var(--primary-dark)',
      },
    },
  },
});

// uno.config.ts
import { defineConfig } from 'unocss';

export default defineConfig({
  theme: {
    colors: {
      primary: 'var(--primary)',
      'primary-dark': 'var(--primary-dark)',
    },
  },
});
```

---

## 10. Project Application

### 10.1 Personal Applications

For personal projects and tools:
- Use personal theme (muted blues & earth tones)
- Apply relaxed, friendly interaction patterns
- Implement softer shadows and rounded corners
- Use earth tone accents for visual interest

### 10.2 Professional Applications

For business and client applications:
- Use professional theme (darker blues & greens)
- Apply crisp, efficient interaction patterns
- Implement sharp shadows and defined corners
- Use professional accent colors for hierarchy

### 10.3 Theme Selection

```javascript
// Theme switching implementation
const setTheme = (theme) => {
  document.documentElement.setAttribute('data-theme', theme);
  localStorage.setItem('theme', theme);
};

// Auto-detect based on context
const getDefaultTheme = () => {
  const domain = window.location.hostname;
  return domain.includes('work') || domain.includes('business') 
    ? 'professional' 
    : 'personal';
};
```

### 10.4 Mobile Applications

For mobile or responsive applications:
- Use mobile-first responsive breakpoints
- Implement touch-friendly sizing (44px minimum)
- Consider performance implications of animations
- Test with actual devices for usability

---

## 11. Version Control & Updates

### 11.1 Versioning

This document follows semantic versioning:
- **Major** (X.0.0): Breaking changes to existing standards
- **Minor** (0.X.0): New standards or components added
- **Patch** (0.0.X): Clarifications or minor adjustments

### 11.2 Implementation Timeline

- **Immediate**: Apply to all new projects
- **3 months**: Update major existing projects
- **6 months**: All projects should be compliant

### 11.3 Governance

- Standards updates require approval from design and development teams
- Regular review every 6 months
- User feedback incorporation quarterly
- Accessibility audit annually

---

**Document Version:** 1.0  
**Last Updated:** June 5, 2025  
**Next Review:** December 5, 2025  
**Maintained By:** LDA Design & Development Teams