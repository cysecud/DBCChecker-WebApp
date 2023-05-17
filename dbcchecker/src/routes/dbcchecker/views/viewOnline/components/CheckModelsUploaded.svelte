<script>
    import ButtonComponent from "$lib/widget/button.svelte";
    import { checkModelsUploadedNoData, urlCheckModelsUploaded } from "$lib/const";
    
    /**
     * @type {[string] | []}
     */
    var result = []

    async function submit() {
        try {
            const response = await fetch(urlCheckModelsUploaded, {
                method: "GET", // GET, POST, PUT, DELETE, etc.
                // mode: "no-cors", // no-cors, *cors, same-origin
                cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
                headers: {
                    "Content-Type": "application/json",
                    "Allow-Access-Control-Origin": "*",
                },
            });
            const jsonData = await response.json();
            readJson(jsonData)
        } catch (error) {
            console.log(error);
        }
    }

    /**
     * @param {any} json
     */
    function readJson(json) {
        var jsonArr = json.Response.Models;
        result = jsonArr;
    }
</script>

<div class="grid">
    <div class="opColumn">
        <h2 class="opTitle">Check Models Uploaded</h2>
        <p class="opDescription">
            Check which models are uploaded in the server. In order to do so,
            please click on the submit button below.
        </p>
        <ButtonComponent on:click={submit} text="Submit" />
    </div>
    <div class="opColumn">
        <h2 class="opTitle">Models Uploaded</h2>
        {#if result.length == 0}
            <pre class="opResultPre">{checkModelsUploadedNoData}</pre>
        {:else}
            {#each result as i}
                <p class="opResultP"><b>&gt;</b> {i}</p>
            {/each}
        {/if}
    </div>
</div>
