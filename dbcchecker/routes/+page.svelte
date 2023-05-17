<script>
    import { appName, pageToolName } from '$lib/const';
	// import logo from '$lib/images/DBCCheckerVideoLogoGrande.mp4';
	import logo from '/DBCCheckerVideoLogoGrande.mp4';
</script>

<svelte:head>
	<title>DBCChecker</title>
	<meta name="description" content={pageToolName}/>
</svelte:head>

<section>
	<h1>
		<span class="logo">
			<picture>
				<img src={logo} alt={appName}/>
			</picture>
		</span>
		a Container Composition<br/>Checking Tool
	</h1>
</section>

<style>
	section {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		flex: 0.6;
	}

	h1 {
		width: 100%;
	}

	.logo {
		display: block;
		position: relative;
		width: 100%;
		height: 100%;

	}

	.logo img {
		position: relative;
		width: 40%;
		height: 40%;
		display: block;
		margin-left: auto;
		margin-right: auto;
	}
</style>
