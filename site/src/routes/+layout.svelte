<script lang="ts">
	import '../app.css';
	
	let { children } = $props();
</script>

<svelte:head>
	<link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🗃️</text></svg>">
</svelte:head>

<div
  class="bg-blue-100 h-dvh selection:text-blue-100 selection:bg-indigo-700 sm:px-20 lg:px-60 px-10 py-10 flex flex-col overflow-auto"
>
  <p>r works // boredcodebyk</p>
  <div class="flex flex-row gap-2 py-2">
    <a href="/">Home</a>
    <a href="https://github.com/boredcodebyk/rworks" target="_blank">GitHub</a>
  </div>

{@render children()}
</div>