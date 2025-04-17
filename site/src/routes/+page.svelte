<script>

  import { db } from "$lib";
  import moment from "moment";

</script>

<svelte:head>
  <title>home</title>
</svelte:head>

<h1>Hello There</h1>

<div class="py-2">
    {#if db.length != 0}
      {#each db as post}
        <p>
          [{moment(post.date).format("MMMM Do YYYY")}] |
          <a href={post.link}>{post.name}</a>
        </p>
      {/each}
    {:else}
      <p>Come back later</p>
    {/if}
  </div>

