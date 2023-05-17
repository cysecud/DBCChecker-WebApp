<svelte:head>
	<title>About</title>
	<meta name="description" content="About DBCChecker" />
</svelte:head>

<div class="text-column">
	<h1>Ops, you are OFFLINE!!</h1>
	<section>
		<p>
			It seems that DBCChecker is offline, please run DBCChecker as
			described below and retry.
			<br />
			If the tool is already running, this error may be caused by a network
			issue. Please restart the application and retry.
		</p>
	</section>

	<section>
		<h2 class="enphH2">Download DBCChecker</h2>
		<p>If you do not have the tool, please run:</p>
		<pre>$ git clone https://github.com/cysecud/DBCChecker.git</pre>
	</section>

	<section>
		<h2 class="enphH2">Run DBCChecker</h2>
		<p>
			In order to run the system execute, in the main directory, the
			following command:
		</p>
		<pre>docker compose up --build</pre>
		<p>
			On older systems where compose is not included with docker, use
			docker-compose.
		</p>
	</section>
</div>