# ⚠️ DEPRECATED — AICF Action v1 (aicf-action)

> **This GitHub Action is no longer maintained and has been retired.**
> > Deprecated: February 2026 | New Light Technologies, Inc. (NLT)
> >
> > ---
> >
> > ## AICF v2.0 is now available
> >
> > The AICF GitHub Action has been completely redesigned as part of **AICF v2.0**, rebuilt from the ground up on a modern serverless-native, cloud-agnostic architecture.
> >
> > **This repository is preserved for historical reference only. No new development will occur here. Do not use this action in new projects.**
> >
> > ### Why this action was retired
> >
> > This action depends on **Fugue.co** for post-deployment drift detection. Fugue.co was acquired by Snyk in 2023 and its standalone platform was subsequently shut down. The action cannot function without Fugue credentials, making it non-operational.
> >
> > Additionally, this action depends on **Regula** for policy rules, which was abandoned following the Fugue shutdown.
> >
> > At the time of retirement (February 2026):
> > - All 4 Fugue secret inputs (FUGUEENVIRONMENTID, FUGUECLIENTID, FUGUECLIENTSECRET, intervalinseconds) point to a dead service
> > - - Regula v0.8.0 is abandoned with no replacement support
> >   - - OPA v0.28.0 is 3+ years out of date
> >     - - Terraform v0.15.3 is 3+ years out of date
> >       - - Zero external forks; effectively no active community usage
> >        
> >         - ### What AICF v2.0 replaces this with
> >        
> >         - - **Drift Detection:** AWS Config + AWS Security Hub (native, FedRAMP GovCloud-compatible, no vendor dependency)
> >           - - **Policy Rules:** OPA v1.14 + Conftest + Checkov v3 (all actively maintained)
> >             - - **IaC:** SST v4 — serverless, cloud-native, AWS/Azure/GCP deployable
> >               - - **Compliance:** FedRAMP, CMMC 2.0, NIST SP 800-53, SOC2, PII, CIS
> >                 - - **Output:** OSCAL v1.2, SARIF, CycloneDX SBOM
> >                  
> >                   - ---
> >
> > ## Original v1 Description
> >
> > The AICF GitHub Action executed an AICF run which ran a pre-deployment policy check against Terraform infrastructure as code, deployed the terraform code in a cloud provider (AWS, Azure or GCP) and enabled drift detection upon completion of cloud resource build out.
> >
> > **NOTE:** This action is no longer functional due to Fugue.co and Regula being discontinued.
> >
> > ---
> >
> > ## Contact
> >
> > New Light Technologies, Inc. (NLT)
> > aicf@nltgis.com
> > https://newlighttechnologies.com/cybersecurity-services
