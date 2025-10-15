<script lang="ts">
  import { onMount } from 'svelte'
  export let items: any[] = []
  export let rowHeight = 48
  export let overscan = 5
  export let containerHeight = 600

  let scrollTop = 0
  let start = 0
  let end = 0
  let viewport: HTMLDivElement | null = null

  function update() {
    const s = scrollTop
    const visibleCount = Math.ceil(containerHeight / rowHeight)
    start = Math.max(0, Math.floor(s / rowHeight) - overscan)
    end = Math.min(items.length, start + visibleCount + overscan * 2)
  }

  function onScroll(e: Event) {
    scrollTop = (e.target as HTMLDivElement).scrollTop
    update()
  }

  onMount(() => {
    update()
    if (viewport) {
      // Try to adapt containerHeight to actual element if not explicitly set
      containerHeight = viewport.clientHeight || containerHeight
      update()
    }
  })
</script>

<style>
  .vr-container { overflow: auto; position: relative; }
  .vr-phantom { width: 1px; opacity: 0; }
  .vr-row { position: absolute; left: 0; right: 0; display: flex; }
</style>

<div bind:this={viewport} class="vr-container" on:scroll={onScroll} style="height:{containerHeight}px;">
  <div class="vr-phantom" style="height:{items.length * rowHeight}px"></div>
  {#each items.slice(start, end) as item, i}
    <div class="vr-row" style="transform: translateY({(start + i) * rowHeight}px); height:{rowHeight}px;">
      <slot {item} {i}></slot>
    </div>
  {/each}
</div>