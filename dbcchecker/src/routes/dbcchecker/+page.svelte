<script>
	import { onMount } from "svelte";
	import ViewOffline from "./views/viewOffline/+page.svelte";
	import ViewOnline from "./views/viewOnline/+page.svelte";
    import { appName, urlCheckModelsUploaded } from "$lib/const";

	let serverOnline = -1;

	onMount(async () => {
		checkDockerOnline();
	});

	function checkDockerOnline() {
		fetch(urlCheckModelsUploaded, { mode: "no-cors" })
			.then((r) => {
				console.log(r);
				serverOnline = 1;
			})
			.catch((e) => {
				console.log(e);
				serverOnline = 0;
			});
	}
</script>

<svelte:head>
	<title>{appName}</title>
	<meta name="tool" content={appName} />
</svelte:head>

{#if serverOnline == -1}
	<div id="viewloading" />
{:else if serverOnline == 0}
	<div id="viewoffline">
		<svelte:component this={ViewOffline} />
	</div>
{:else}
	<div id="viewoffline">
		<svelte:component this={ViewOnline} />
	</div>
{/if}
