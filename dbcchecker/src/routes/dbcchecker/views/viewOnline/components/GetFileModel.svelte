<script>
    import ButtonComponent from "$lib/widget/button.svelte";
    import {
        suffixNameInputFile,
        urlHost,
        urlCheckModelsUploaded,
        preselectedOption,
        noDataModelRetrieve,
        outputHtmlFileName,
    } from "$lib/const";
    import { saveAs } from "file-saver";

    let selected = 0;
    /**
     * @type {any[]}
     */
    var listOfModels = [];

    var modelName = "";
    var fileName = "";

    var resultInputText = "";
    var resultOutputHtml = "";
    var resultOutputText = "";

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

    async function retrieve() {
        prepareInput();
        getInput();
        getOutputHtml();
        getOutputText();
    }

    async function prepareInput() {
        modelName = listOfModels[selected - 1];
        fileName = modelName + suffixNameInputFile;
    }

    async function getInput() {
        try {
            const response = await fetch(
                urlHost + "/models/" + modelName + "/input/text/" + fileName,
                {
                    method: "GET",
                    cache: "no-cache",
                    headers: {
                        "Content-Type": "application/json",
                        "Allow-Access-Control-Origin": "*",
                    },
                }
            );
            const jsonData = await response.json();
            readJsonInput(jsonData);
        } catch (error) {
            console.log(error);
        }
    }

    async function getOutputHtml() {
        try {
            const response = await fetch(
                urlHost + "/models/" + modelName + "/output/html/" + outputHtmlFileName,
                {
                    method: "GET",
                    cache: "no-cache",
                    headers: {
                        "Content-Type": "application/json",
                        "Allow-Access-Control-Origin": "*",
                    },
                }
            );
            const jsonData = await response.json();
            readJsonOutputHtml(jsonData);
        } catch (error) {
            console.log(error);
        }
    }

    async function getOutputText() {
        try {
            const response = await fetch(
                urlHost + "/models/" + modelName + "/output/text/" + fileName,
                {
                    method: "GET",
                    cache: "no-cache",
                    headers: {
                        "Content-Type": "application/json",
                        "Allow-Access-Control-Origin": "*",
                    },
                }
            );
            const jsonData = await response.json();
            readJsonOutputText(jsonData);
        } catch (error) {
            console.log(error);
        }
    }

    /**
     * @param {any} json
     */
    function readJsonInput(json) {
        resultInputText = json.Response.Result;
    }
    /**
     * @param {any} json
     */
    function readJsonOutputHtml(json) {
        resultOutputHtml = json.Response.url;
    }
    /**
     * @param {any} json
     */
    function readJsonOutputText(json) {
        resultOutputText = json.Response.Result;
    }

    function openOutputHtml() {
        window.open(resultOutputHtml, "_blank");
    }

    function openOutputText() {
        window.open(resultOutputText, "_blank");
    }

    function saveInputText() {
        var content = resultInputText;
        var filename = modelName + "-Input.txt";

        var blob = new Blob([content], {
            type: "text/plain;charset=utf-8",
        });
        saveAs(blob, filename);
    }

    function saveOutputText() {
        var content = resultOutputText;
        var filename = modelName + "-Output.txt";

        var blob = new Blob([content], {
            type: "text/plain;charset=utf-8",
        });
        saveAs(blob, filename);
    }

    getModels();
</script>

<div class="grid">
    <div class="opColumn">
        <h2 class="opTitle">Get Model Files</h2>
        <p class="opDescription">
            Retrieve all the files related to the model selected. In order
            to do so, please select an existing model in the menu bewload anc
            click on the "Retrieve" button.
        </p>
        <form class="opForm">
            <label for="selectOpGetFile" class="opInputLabel"
                >Model Name</label
            >
                <select class="selectionSelect" id="selectOpGetFile" bind:value={selected}>
                    <option value={0} selected>{preselectedOption}</option>
                    {#each listOfModels as option, i}<option value={i + 1}
                            >{option}</option
                        >{/each}
                </select>
        </form>

        <ButtonComponent on:click={retrieve} text="Retrieve" />
    </div>
    <div class="opColumn">
        <h2>Files</h2>
        {#if resultInputText == "" && resultOutputHtml == "" && resultOutputText == ""}
            <pre class="opResultPre">{noDataModelRetrieve}</pre>
        {:else}
            <p><b>Model:</b> {modelName}</p>
            <div class="opResultColumn">
                <ButtonComponent on:click={saveInputText} text="Save Proverif File" />
                <ButtonComponent on:click={openOutputHtml} text="Open Proverif HTML Result" />
                <ButtonComponent on:click={openOutputText} text="Open Proverif Text Result" />
                <ButtonComponent on:click={saveOutputText} text="Save Proverif Text Result" />
            </div>
        {/if}
    </div>
</div>
