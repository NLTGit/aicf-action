#!/bin/bash

function aicfDestroy {
    source /src/AICF-action-fugueRescan.sh
    # TF destroy
    export TF_CLI_CONFIG_FILE="/root/.terraform.rc"
    
    cd $GITHUB_WORKSPACE
    echo -e "\nTurn off Fugue drift detection.\n"
    curl -X PATCH "https://api.riskmanager.fugue.co/v0/environments/${INPUT_FUGUEENVIRONMENTID}" -u ${INPUT_FUGUECLIENTID}:${INPUT_FUGUECLIENTSECRET} -d '{"baseline_id": "","remediation": false}' && sleep 10
    terraform init -no-color
    terraform destroy -auto-approve -no-color
    fugueRescan
    echo -e "\nTerraform environment destroyed and fugue environment re-baselined!!\n"
}