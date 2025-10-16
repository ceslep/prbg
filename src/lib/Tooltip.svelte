<script lang="ts">
    import { theme } from './themeStore';
    import { fade } from 'svelte/transition';
    import { onMount, onDestroy, tick } from 'svelte';

    export let content: string | null;
    export let position: 'top' | 'bottom' | 'left' | 'right' = 'top';

    let showTooltip = false;
    let triggerElement: HTMLElement;
    let tooltipElement: HTMLDivElement;
    let portalTarget: HTMLElement;

    // Svelte action to move element to portalTarget
    function portal(node: HTMLElement, target: HTMLElement) {
        target.appendChild(node);
        return {
            destroy() {
                if (target.contains(node)) {
                    target.removeChild(node);
                }
            }
        };
    }

    onMount(() => {
        portalTarget = document.body;
    });

    onDestroy(() => {
        // No need to remove portalTarget from body, as the action handles node removal
    });

    async function show() {
        showTooltip = true;
        await tick(); // Wait for the tooltip to be rendered in the DOM
        positionTooltip();
    }

    function hide() {
        showTooltip = false;
    }

    function positionTooltip() {
        if (!triggerElement || !tooltipElement) return;

        const triggerRect = triggerElement.getBoundingClientRect();
        const tooltipRect = tooltipElement.getBoundingClientRect();

        let top = 0;
        let left = 0;

        switch (position) {
            case 'top':
                top = triggerRect.top - tooltipRect.height - 8; // 8px for spacing
                left = triggerRect.left + (triggerRect.width / 2) - (tooltipRect.width / 2);
                break;
            case 'bottom':
                top = triggerRect.bottom + 8; // 8px for spacing
                left = triggerRect.left + (triggerRect.width / 2) - (tooltipRect.width / 2);
                break;
            case 'left':
                top = triggerRect.top + (triggerRect.height / 2) - (tooltipRect.height / 2);
                left = triggerRect.left - tooltipRect.width - 8; // 8px for spacing
                break;
            case 'right':
                top = triggerRect.top + (triggerRect.height / 2) - (tooltipRect.height / 2);
                left = triggerRect.right + 8; // 8px for spacing
                break;
        }

        // Ensure tooltip stays within viewport
        const viewportWidth = window.innerWidth || document.documentElement.clientWidth;
        const viewportHeight = window.innerHeight || document.documentElement.clientHeight;

        if (left < 0) left = 0;
        if (top < 0) top = 0;
        if (left + tooltipRect.width > viewportWidth) left = viewportWidth - tooltipRect.width;
        if (top + tooltipRect.height > viewportHeight) top = viewportHeight - tooltipRect.height;

        tooltipElement.style.top = `${top + window.scrollY}px`;
        tooltipElement.style.left = `${left + window.scrollX}px`;
        tooltipElement.style.position = 'absolute';
    }

    $: tooltipClasses = (() => {
        let classes = 'z-[9999] px-3 py-2 text-sm font-medium rounded-lg shadow-sm whitespace-pre-wrap';
        classes += ` ${$theme === 'dark' ? 'bg-gray-700 text-gray-200' : 'bg-gray-800 text-white'}`;
        return classes;
    })();

    // Re-position tooltip on scroll or resize
    function handleScrollOrResize() {
        if (showTooltip) {
            positionTooltip();
        }
    }

    onMount(() => {
        window.addEventListener('scroll', handleScrollOrResize, true);
        window.addEventListener('resize', handleScrollOrResize);
    });

    onDestroy(() => {
        window.removeEventListener('scroll', handleScrollOrResize, true);
        window.removeEventListener('resize', handleScrollOrResize);
    });

    // Reactive statement to re-position tooltip if content or position changes while visible
    $: if (showTooltip && (content || position)) {
        positionTooltip();
    }
</script>

<div class="relative inline-block" role="group"
    bind:this={triggerElement}
    on:mouseenter={show}
    on:mouseleave={hide}
    on:focusin={show}
    on:focusout={hide}
>
    <slot></slot>
</div>

{#if showTooltip}
    <div use:portal={portalTarget}>
        <div
            bind:this={tooltipElement}
            class="{tooltipClasses}"
            transition:fade={{ duration: 100 }}
            style="position: absolute;"
        >
            {content}
            <!-- Arrow for the tooltip -->
            <div class="absolute w-2 h-2 rotate-45
                        {$theme === 'dark' ? 'bg-gray-700' : 'bg-gray-800'}"
                 class:bottom-[-4px]={position === 'top'}
                 class:top-[-4px]={position === 'bottom'}
                 class:right-[-4px]={position === 'left'}
                 class:left-[-4px]={position === 'right'}
            ></div>
        </div>
    </div>
{/if}

<style>
    /* Svelte transitions require global styles or a specific import */
    /* For fade transition, ensure svelte/transition is imported in script if not already */
</style>