<script>
    import ButtonComponent from "$lib/widget/button.svelte";
    import {
        preselectedOption,
        noDataModelDeleted,
        urlCheckModelsUploaded,
        urlHost,
    } from "$lib/const";

    var result = "";

    let selected = 0;
    /**
     * @type {any[]}
     */
    var listOfModels = [];
    var modelToDelete = "";

    async function getModels() {
        try {
            const response = await fetch(urlCheckModelsUploaded, {
                method: "GET",
                cache: "no-cache",
                headers: {
                    "Content-Type": "application/json",
                    "Allow-Access-Control-Origin": "*",
                },
            });
            const jsonData = await response.json();
            listOfModels = jsonData.Response.Models;
        } catch (error) {
            console.log(error);
        }
    }

    async function deleteModel() {
        if (selected == 0) {
            alert("Please, select a model to delete.");
        } else {
            modelToDelete = listOfModels[selected - 1];
            try {
                const response = await fetch(
                    urlHost + "/models/" + modelToDelete,
                    {
                        method: "DELETE",
                        cache: "no-cache",
                        headers: {
                            "Content-Type": "application/json",
                            "Allow-Access-Control-Origin": "*",
                        },
                    }
                );
                const jsonData = await response.json();
                readJson(jsonData);
                getModels();
            } catch (error) {
                console.log(error);
            }
        }
    }

    /**
     * @param {any} json
     */
    function readJson(json) {
        console.log(json);
        result = json.Response.Result;
    }

    getModels();
</script>

<div class="grid">
    <div class="opColumn">
        <h2 class="opTitle">Delete Model</h2>
        <p class="opDescription">
            Delete a model and all the file related to it. In order to do so,
            please select one of the models in the dropdown menu below and click
            on the "Delete" button.
        </p>
        <div class="opQueryColumn">
            <section id="selectModeltoDelete" class="selection">
                <label id="selectOpLabel" for="selectOp" class="selectionLabel"
                    >Model to Delete:
                </label>
                <select class="selectionSelect" id="selectOp" bind:value={selected}>
                    <option value={0} selected>{preselectedOption}</option>
                    {#each listOfModels as option, i}<option value={i + 1}
                            >{option}</option
                        >{/each}
                </select>
            </section>
            <ButtonComponent on:click={deleteModel} text="Delete" />
        </div>
    </div>
    <div class="opColumn">
        <h2 class="opTitle">Result Deletion</h2>
        {#if result == ""}
            <pre class="opResultPre">{noDataModelDeleted}</pre>
        {:else}
            <p class="opResultP">{result}</p>
        {/if}
    </div>
</div>


