<script lang="ts">
    import { theme } from './themeStore';
    import { fade } from 'svelte/transition';

    export let content: string;
    export let position: 'top' | 'bottom' | 'left' | 'right' = 'top';

    let showTooltip = false;
    let triggerElement: HTMLElement;

    function show() {
        showTooltip = true;
    }

    function hide() {
        showTooltip = false;
    }

    $: tooltipClasses = (() => {
        let classes = 'absolute z-[9999] px-3 py-2 text-sm font-medium rounded-lg shadow-sm whitespace-pre-wrap';
        classes += ` ${$theme === 'dark' ? 'bg-gray-700 text-gray-200' : 'bg-gray-800 text-white'}`;

        switch (position) {
            case 'top':
                classes += ' bottom-full left-1/2 -translate-x-1/2 mb-2';
                break;
            case 'bottom':
                classes += ' top-full left-1/2 -translate-x-1/2 mt-2';
                break;
            case 'left':
                classes += ' right-full top-1/2 -translate-y-1/2 mr-2';
                break;
            case 'right':
                classes += ' left-full top-1/2 -translate-y-1/2 ml-2';
                break;
        }
        return classes;
    })();
</script>

<div
    class="relative inline-block"
    bind:this={triggerElement}
    on:mouseenter={show}
    on:mouseleave={hide}
    on:focusin={show}
    on:focusout={hide}
>
    <slot></slot>

    {#if showTooltip}
        <div
            class="{tooltipClasses}"
            transition:fade={{ duration: 100 }}
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
    {/if}
</div>

<style>
    /* Svelte transitions require global styles or a specific import */
    /* For fade transition, ensure svelte/transition is imported in script if not already */
</style>