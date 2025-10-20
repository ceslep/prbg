<script lang="ts">
  export let rows: number = 6;
  export let columns: number = 4;
  export let headerWidth: string = '33%';
  export let theme: 'dark' | 'light' = 'dark';
  // Optional column widths as strings like ['25%','25%','25%','25%']
  export let columnWidths: string[] | null = null;
</script>

<style>
  .skeleton { background: linear-gradient(90deg, var(--s1) 25%, var(--s2) 37%, var(--s1) 63%); background-size: 600% 100%; animation: shimmer 1.2s ease infinite; }
  @keyframes shimmer { 0%{background-position:100% 0} 100%{background-position:-100% 0} }
  .skeleton-block { background: var(--block); border-radius: 6px; }
  .skeleton-container { background: var(--bg); padding: 16px; border-radius: 8px; }
  .skeleton-rows { display: flex; flex-direction: column; gap: 12px; }
  .skeleton-row { display:flex; gap:12px; align-items:center; }
  .skeleton-header { height: 20px; margin-bottom:12px; }
  .skeleton-cell { height:14px; border-radius:4px; }

  .spinner {
    border: 3px solid rgba(255, 255, 255, 0.3);
    border-radius: 50%;
    border-top: 3px solid #3498db;
    width: 20px;
    height: 20px;
    -webkit-animation: spin 1s linear infinite;
    animation: spin 1s linear infinite;
    position: absolute;
    top: 10px;
    right: 10px;
  }

  @-webkit-keyframes spin {
    0% { -webkit-transform: rotate(0deg); }
    100% { -webkit-transform: rotate(360deg); }
  }

  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }
</style>

<div class="skeleton-container" style="--bg: {theme === 'dark' ? '#0f172a' : '#f8fafc'}; --block: {theme === 'dark' ? '#374151' : '#e5e7eb'}; --s1: {theme === 'dark' ? '#2d3748' : '#e2e8f0'}; --s2: {theme === 'dark' ? '#4a5568' : '#cbd5e1'}; position: relative;">
  <div class="spinner"></div>
  <div class="skeleton skeleton-block skeleton-header" style="width:{headerWidth};"></div>
  <div class="skeleton-rows">
    {#each Array(rows) as _, r}
      <div class="skeleton-row">
        {#if columnWidths}
          {#each columnWidths as w}
            <div class="skeleton skeleton-block skeleton-cell" style="width:{w};"></div>
          {/each}
        {:else}
          {#each Array(columns) as _, c}
            <div class="skeleton skeleton-block skeleton-cell" style="flex: 1;"></div>
          {/each}
        {/if}
      </div>
    {/each}
  </div>
</div>