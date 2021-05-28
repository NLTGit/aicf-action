<img src="images/NLT_AICFLLogo.jpg">

**For help, email aicf@nltgis.com**

## What is AICF?
The Automated Infrastructure Compliance Framework is an open-source integrated pipeline for deploying and monitoring infrastructure. Specific features include:
* Pre-deployment policy checking using Open Policy Agent
* Post-deployment AWS/Azure drift detection using Fugue.co
* Terraform for Infrastructure-as-Code deployments

# AICF docker action

This GitHub Action executes an AICF run which runs a pre-deployment policy check against one's terraform infrastructure as code, deploys the terraform code in a cloud provider (aws, azure or gcp) and enables drifit detection upon completion of cloud resource build out. One glaring feature, not yet available, is the capability to manually trigger an action.  

We've worked around this by specifying the action trigger in the example workflow on a push to a non-default branch, i.e. "deployment". Therefore your "master" branch won't clutter with commits that are used to trigger actions.  

**Please ensure all of your Terraform "*.tf" files are in a repo top level folder called `terraform`.**    

To gain a better understanding of the AICF and how it can be an effective in tool for your organization, please visit: https://aifc.nltgis.com.  
<br />
<br />

## Inputs

### `tfcommand`
**Required** Terraform sub command to run.

### `cloudprovider`
**Required** Cloud provider TF will deploy to.

### `tf_workdir`
**Required** Working directory of terraform files in relation to top level repo directory. Default `terraform`.

### `terraformsha256`
**Required** Sha256 hash of TF binary. Default `5ce5834fd74e3368ad7bdaac847f973e66e61acae469ee86b88da4c6d9f933d4`.

### `terraformversion`
**Required** TF version. Default `0.15.3`.

### `intervalinseconds`
**Required** Fugue scan interval in seconds. Default `86400`.

### `regulaversion`
**Required** Version of Regula binary, Default `0.8.0`.

### `opaversion`
**Required** Version of Open Policy Agent. Default `0.28.0`.
<br />

## Secrets (must be predefined in GitHub repo secrets settings)

### `TERRAFORMCLOUDTOKEN`
**Required** Terraform cloud token

### `FUGUEENVIRONMENTID`
**Required** Fugue Environement specific ID

### `FUGUECLIENTID`
**Required** Fugue Client ID

### `FUGUECLIENTSECRET`
**Required** Fugue Client Secret
<br />

## Example usage

    # This workflow is triggered on pushes to the repository's deployment branch.
    name: Terraform-apply
    on:
    push:
        branches:
        - master
    pull_request:
        branches: 
        - master

    jobs:
    build:
        # Job name is Run
        runs-on: ubuntu-latest
        name: Run
        steps:
        - name: Repo checkout
        uses: actions/checkout@v2
        - name: AICF GitHub Action
        uses: nltgit/aicf-action@v1.22
        with:
            # tfcommands {apply or destroy}
            tfcommand: apply
            # cloudprovider {aws, azure, gps}
            cloudprovider: aws
            tf_workdir: "ecs-fargate"
            terraformcloudtoken: ${{ secrets.TF_API_TOKEN }}
            fugueenvironmentid: ${{ secrets.FUGUEENVIRONMENTID }}
            fugueclientid: ${{ secrets.FUGUECLIENTID }}
            fugueclientsecret: ${{ secrets.FUGUECLIENTSECRET }}
        env:
            TF_VAR_AWS_ACCESS_KEY: ${{ secrets.AWS_ACCESS_KEY_ID }}
            TF_VAR_AWS_SECRET_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
            TF_VAR_POSTGRES_PASSWORD: ${{ secrets.POSTGRES_PASSWORD }}
            TF_VAR_DNS_ACCESS_KEY: ${{ secrets.DNS_ACCESS_KEY }}
            TF_VAR_DNS_SECRET_KEY: ${{ secrets.DNS_SECRET_KEY }}
            TF_VAR_DATASTORE_READONLY_PASSWORD: ${{ secrets.DATASTORE_READONLY_PASSWORD }}
            TF_VAR_CKAN_SMTP_USER: ${{ secrets.CKAN_SMTP_USER }}
            TF_VAR_CKAN_SMTP_PASSWORD: ${{ secrets.CKAN_SMTP_PASSWORD }}
<br />

## Contributing
1) Clone repo  
2) Create new branch, make changes and commit and push to remote i.e. `git push --set-upstream origin new-branch`  
3) Log into GitHub and create pull request to the master branch

## Contact  
New Light Technologies, Inc.   
Carl Alleyne - carl.alleyne@nltgis.com
