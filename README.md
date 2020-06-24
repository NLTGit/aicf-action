<img src="images/NLT_AICFLLogo.jpg">

**For help, email aicf@nltgis.com**

## What is AICF?
The Automated Infrastructure Compliance Framework is an open-source integrated pipeline for deploying and monitoring infrastructure. Specific features include:
* Pre-deployment policy checking using Open Policy Agent
* Post-deployment AWS/Azure drift detection using Fugue.co
* Terraform for Infrastructure-as-Code deployments

## Technical Summary
AICF is the confluence of several technologies and tools such as Open Policy Agent, Terraform and Fugue. It can be build upon any CI/CD toolset of one's choosing. Currently, we have examples of AICF that are built on 1) AWS Codepipeline and AWS Codebuild and 2) Github actions. Use of each detailed below.

## GitHub Actions Deployment/installation overview
GitHub Actions is essentailly GitHub's implementation of continuous integration (CI) and continuous deployment (CD) tools. They help you automate your software development workflows and are executed directly in the repo of one's choosing. One develops an Action in a public repo and publishes to the GitHub Marketplace. Then, someone creates a workflow yaml file for that action in the top level of their repo. Actions can be triggered pretty much in any number of ways that one can perform git commands on a repo such as push to a branch, commiting to a brach, create a pull request, creating an issue in a repo's project, etc. One glaring feature, not yet available, is the capability to manually trigger an action.

We've worked around this by specifying the action trigger in the example workflow on a push to a non-default branch such as "deployment". Therefore your "master" brunch won't clutter with commits that are used to trigger actions.

To implement the AICF action please visint the aicf-action marketplace page at: 
The readme for the aicf-action is located at:


# AICF docker action

This action prints "Hello World" or "Hello" + the name of a person to greet to the log.

## Inputs

### `who-to-greet`

**Required** The name of the person to greet. Default `"World"`.

## Secrets (must be predefined in repo settings)

### `TERRAFORMCLOUDTOKEN`
Terraform cloud token

### `FUGUEENVIRONMENTID`
Fugue Environement specific ID

### `FUGUECLIENTID`
Fugue Client ID

### `FUGUECLIENTSECRET`
Fugue Client Secret

## Example usage
  
    name: AICF run v1
    # This workflow is triggered on pushes to the repository's deployment branch.
    on:
    push:
        branches:
        - deployment

    jobs:
    build:
        # Job name is Run
        runs-on: ubuntu-latest
        name: Run
        steps:
        - name: Repo checkout
            uses: actions/checkout@master
        - name: AICF GitHub Action
            uses: nltgit/aicf-action@master
            with:
                # tfcommands {apply or destroy}
                tfcommand: apply
                # cloudprovider {aws, azure, gps}
                cloudprovider: aws
                terraformcloudtoken: ${{ secrets.TERRAFORMCLOUDTOKEN }}
                fugueenvironmentid: ${{ secrets.FUGUEENVIRONMENTID }}
                fugueclientid: ${{ secrets.FUGUECLIENTID }}
                fugueclientsecret: ${{ secrets.FUGUECLIENTSECRET }}


## Contributing
1) Clone repo  
2) Create new branch, make changes and commit and push to remote i.e. `git push --set-upstream origin new-branch`  
3) Log into GitHub and create pull request to the master branch

## Contact  
New Light Technologies, Inc.   
Carl Alleyne - carl.alleyne@nltgis.com  

