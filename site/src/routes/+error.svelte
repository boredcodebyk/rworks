<script lang="ts">
    import { page } from '$app/state';
</script>

<h1 class="text-9xl">{page.status}</h1>
<p class="text-7xl">{page.error?.message}</p>