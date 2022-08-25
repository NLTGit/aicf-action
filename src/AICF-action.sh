#!/bin/bash

function aicfApply { 
    source /src/AICF-action-fugueRescan.sh
    export TF_CLI_CONFIG_FILE="/root/.terraform.rc"
    # Install OPA bin
    curl -L -o opa https://github.com/open-policy-agent/opa/releases/download/v${INPUT_OPAVERSION}/opa_linux_amd64_static && chmod +x opa && mv opa /usr/bin
    # Install regula script and libraries.
    mkdir -p /usr/bin/regula && curl -L "https://github.com/fugue/regula/archive/v${INPUT_REGULAVERSION}.tar.gz" | tar -xz --strip-components=1 -C /usr/bin/regula

    # Action
    # TF plan and OPA evaluation
    cd $GITHUB_WORKSPACE/${INPUT_TF_WORKDIR}
    terraform init -no-color && terraform plan -refresh-only -no-color
    terraform plan --out tfplan.binary -no-color && terraform show -json tfplan.binary -no-color > tfplan.json

    case "${INPUT_CLOUDPROVIDER}" in
        aws)
          opa eval --format pretty --input tfplan.json --data /usr/bin/regula/rego/lib --data /usr/bin/regula/rego/rules/tf/aws --data waivers.rego 'data.fugue.regula.report' | tee evaluate
          ;;
        gcp)
          opa eval --format pretty --input tfplan.json --data /usr/bin/regula/rego/lib --data /usr/bin/regula/rego/rules/tf/gcp --data waivers.rego 'data.fugue.regula.report' | tee evaluate
          ;;
        azure)
          opa eval --format pretty --input tfplan.json --data /usr/bin/regula/rego/lib --data /usr/bin/regula/rego/rules/tf/azure --data waivers.rego 'data.fugue.regula.report' | tee evaluate
          ;;
        *)
          echo -e "Error: Must provide a valid value for cloud provider"
          exit 1
          ;;
    esac
    
    TERRAFORM_FAILED=$(jq -r '.summary.rule_results.FAIL' "evaluate")
    if (("$TERRAFORM_FAILED" == 0)); then echo -e '\nTerraform resources plan PASSES OPA authorization!!\n'; else echo -e '\n!!! Terraform resources plan FAILS OPA authorization !!!\n' && exit 1; fi

    # TF apply, Fugue scan and re-baselining
    echo -e "\nTurn off Fugue drift detection.\n"
    curl -X PATCH "https://api.riskmanager.fugue.co/v0/environments/${INPUT_FUGUEENVIRONMENTID}" -u ${INPUT_FUGUECLIENTID}:${INPUT_FUGUECLIENTSECRET} -d '{"baseline_id": "","remediation": false}' && sleep 10
    terraform apply -auto-approve -no-color
    echo -e "\nTerraform apply completed!!\n"
    fugueRescan
    echo -e "\nFugue environment re-baselined, baseline enforcement and drift detection disabled!!\n"
}
