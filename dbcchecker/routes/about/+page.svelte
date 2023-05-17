<svelte:head>
	<title>About</title>
	<meta name="description" content="About DBCChecker" />
</svelte:head>

<div class="text-column">
	<h1>About DBCChecker</h1>

	<p>
		This is a <a href="https://github.com/cysecud/DBCChecker" target="_blank">DBCChecker</a>.
		You can try this tool by simply check the <a href="/dbcchecker">dedicated page</a>
		in this application.
	</p>

	<p>
		<b>DBCChecker</b> is a tool aiming to verify security properties of systems obtained
		by composition of containers. From the configuration of a container-based system and 
		an abstract description of the interface behaviour of each container, the tool builds a
		formal model of the overall system, which can be verified in 
		<a href="https://bblanche.gitlabpages.inria.fr/proverif/" target="_blank">ProVerif</a>
		(an automatic symbolic protocol verifier),
		to check that the overall system satisfies the required properties. The system can be
		described in a specification language capable to express at once the interfaces and 
		connections of containers and the relevant behavioural aspects of their interfaces, called
		JSON Bigraph Format (JBF), and inspired by previous formal models, based on bigraphs, for
		containerized architectures.
	</p>
</div>
