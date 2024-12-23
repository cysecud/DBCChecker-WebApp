<script>
    import ButtonComponent from "$lib/widget/button.svelte";
    import {
        verificationTypeBoth,
        checkModelsUploadedNoData,
        suffixNameInputFile,
        authExtensionFile,
        urlHost,
        errorFileUpload,
    } from "$lib/const";
    import { saveAs } from "file-saver";

    /** @type {any} */
    let filesJBF;

    /** @type {any} */
    let filesIntegrative;

    var modelName = "";
    var fileName = "";

    /**
     * @type {string | ArrayBuffer | null | undefined}
     */
    var jbfFileContent;
    /**
     * @type {string | ArrayBuffer | null | undefined}
     */
    var integrativeFileContent;

    var resultHtml = "";
    var resultText = "";

    async function submit() {
        prepareInput();
        try {
            const response = await fetch(
                urlHost + "/models/" + modelName + "/verify/" + fileName,
                {
                    method: "POST",
                    cache: "no-cache",
                    headers: {
                        "Content-Type": "application/json",
                        "Allow-Access-Control-Origin": "*",
                    },
                    body: JSON.stringify({
                        VerificationType: verificationTypeBoth,
                        DataJsonBigraph: jbfFileContent,
                        DataJsonIntegrative: integrativeFileContent,
                    }),
                }
            );
            if (response.status == 415) {
                alert(errorFileUpload);
            }
            const jsonData = await response.json();
            readJson(jsonData);
        } catch (error) {
            console.log(error);
        }
    }

    async function prepareInput() {
        fileName = modelName + suffixNameInputFile;
    }

    /**
     * @param {File} fileJBF
     */
    async function readJBFFile(fileJBF) {
        let reader = new FileReader();
        reader.readAsText(fileJBF);
        reader.onload = function () {
            jbfFileContent = reader.result;
            jbfFileContent = jbfFileContent?.toString().replaceAll("\n", " ");
        };
        reader.onerror = function () {
            console.log(reader.error);
        };
    }

    /**
     * @param {File} fileInt
     */
    async function readIntegrativeFile(fileInt) {
        let reader = new FileReader();
        reader.readAsText(fileInt);
        reader.onload = function () {
            integrativeFileContent = reader.result;
            integrativeFileContent = integrativeFileContent
                ?.toString()
                .replaceAll("\n", " ");
        };
        reader.onerror = function () {
            console.log(reader.error);
        };
    }

    /**
     * @param {any} json
     */
    function readJson(json) {
        var resultJson = json.Response;
        resultHtml = resultJson.OutputHtml;
        resultText = resultJson.OutputText.Result;
    }

    function open() {
        window.open(resultHtml, "_blank");
    }

    function save() {
        console.log(resultText);
        var content = resultText;
        var filename = modelName + "-Output.txt";

        var blob = new Blob([content], {
            type: "text/plain;charset=utf-8",
        });
        saveAs(blob, filename);
    }
</script>

<div class="grid">
    <div class="opColumn">
        <h2 class="opTitle">Verify</h2>
        <p class="opDescription">
            Verify a new system with DBCChecker. In order to do so, please fill
            the form below and upload the JBF files; then click the "Submit"
            button.
        </p>
        <form class="opForm">
            <label for="modelNameNewVerify" class="opInputLabel"
                >Model Name</label
            >
            <input
                id="modelNameNewVerify"
                class="opInputFormText"
                type="text"
                required
                bind:value={modelName}
            />
            <label for="jbfNameNewVerify" class="opInputLabel">JBF File</label>
            <input
                id="jbfNameNewVerify"
                class="opInputFormFile"
                type="file"
                accept={authExtensionFile.join(",")}
                required
                bind:files={filesJBF}
                on:change={() => readJBFFile(filesJBF[0])}
            />
            <label for="jbfIntNameNewVerify" class="opInputLabel"
                >Integrative File</label
            >
            <input
                id="jbfIntNameNewVerify"
                class="opInputFormFile"
                type="file"
                accept={authExtensionFile.join(",")}
                required
                bind:files={filesIntegrative}
                on:change={() => readIntegrativeFile(filesIntegrative[0])}
            />
        </form>

        <ButtonComponent on:click={submit} text="Submit" />
    </div>
    <div class="opColumn">
        <h2>Verification Result</h2>
        {#if resultHtml == "" && resultText == ""}
            <pre class="opResultPre">{checkModelsUploadedNoData}</pre>
        {:else}
            <p><b>Model:</b> {modelName}</p>
            <div class="opResultColumn">
                <ButtonComponent on:click={open} text="Open Results" />
                <ButtonComponent on:click={save} text="Save Results" />
            </div>
        {/if}
    </div>
</div>
