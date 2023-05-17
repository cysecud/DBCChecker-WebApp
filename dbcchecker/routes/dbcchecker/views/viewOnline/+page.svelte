<script>
	import View0 from "./components/CheckModelsUploaded.svelte";
	import View1 from "./components/NewVerification.svelte";
	import View2 from "./components/ModifyVerification.svelte";
	import View3 from "./components/GetFileModel.svelte";
	import View4 from "./components/DeleteModel.svelte";
    import { pageToolName } from "$lib/const";
	
	const views = [View0, View1, View2, View3, View4];

	let selected = 0;
	const preselectedOption = "-- Please, select an option --";
	const options = ["Check Uploaded Models", "New Verification", "Update Verification", "Retrieve Model Files", "Delete Model"];
</script>

<svelte:head>
	<title>{pageToolName}</title>
	<meta name="viewOnline" content={pageToolName} />
</svelte:head>

<section id=selectSection>
	<label id="selectOpLabel" for="selectOp">I want to:</label>
	<select id="selectOp" bind:value={selected}>
		<option value={0} selected>{preselectedOption}</option>
		{#each options as option, i}<option value={i + 1} selected
				>{option}</option
			>{/each}
	</select>
</section>

{#if selected > 0}
	<div id="viewOpComponent">
		<svelte:component this={views[selected - 1]} />
	</div>
{:else}
	<div id="noOpComponent" />
{/if}

<style>
	#selectSection {
		margin-top: 50px;
	}

	#selectOpLabel {
		font-weight: bold;
		margin-right: 30px;
	}

	#selectOp {
		width: max-content;
		font-size: medium;
	}

	#viewOpComponent {
		margin-top: 50px;
	}
</style>
