#!/bin/bash

function fugueRescan {
    cd $GITHUB_WORKSPACE
    echo -e "\nRescan environment and grab new scan id.\n"
    content=$(curl -X POST "https://api.riskmanager.fugue.co/v0/scans?environment_id=${INPUT_FUGUEENVIRONMENTID}" -u ${INPUT_FUGUECLIENTID}:${INPUT_FUGUECLIENTSECRET})
    Fugue_scan_id=$(jq -r '.id' <<< "$content")
    echo -e "$Fugue_scan_id"
    str="does not belong to environment"
    content="does not belong to environment"
    while [[ $content == *$str* ]]; do echo -e "Bad request message is expected. Waiting for Fugue scan to finish....\n"; content=$(curl -X PATCH "https://api.riskmanager.fugue.co/v0/environments/${INPUT_FUGUEENVIRONMENTID}" -u ${INPUT_FUGUECLIENTID}:${INPUT_FUGUECLIENTSECRET} -d '{"baseline_id": "'$Fugue_scan_id'","scan_interval": "'$INPUT_INTERVALINSECONDS'","remediation": false}'); echo -e "\n$content\n"; sleep 5; done
}