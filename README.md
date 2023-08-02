Vops-alerts
===

This repo will contain all the alerts that we create using Terraform scripts. This will help us integrate with oncallbot that will restart pods automatically before paging the on-call resource.


1. Create Datadog monitors using terraform.

Quick Start
---
* Define your monitor in Terraform:
    * Clone the repo: `git clone ssh://git@bitbucket-prod.aws.secureworks.com:7999/vops/vops-alerts.git`
    * Create a new branch: `git checkout -b <branch-name>`
    * Edit the existing file `monitor-definitions.auto.tfvars`.
        * This file has definitions for all applications in the format of a map (or dict).
        * Copy any monitor definition. Monitor definition is enclosed within the format:
        ```
        "id<a-number>":{
            <var-name>: value,
            .
            .
        },
        ```
        * Change the id `"id<a-number>"`. Add one to it from the last monitor. Ensure this is unique for your monitor.
        * Change all the variable values inside the monitor definition as per your application.
    * Check-in the code and push to remote: `git push --set-upstream origin win-agent`
    * Open PR. Wait for approval.
* Apply changes to create monitor:
    * Once PR is approved, follow steps below to apply the changes to create the monitor.
    * Login to [vault web UI](https://vault.aws.secureworks.com/ui/vault/secrets). Copy your CLI token.
    * Run following commands retrieve Datadog keys from Vault and set them as env variables.
        
        Pilot (used for testing oncallbot):
        ```
        $ vault login
        $ export TF_VAR_datadog_api_key=$(vault kv get --field datadog_api_key_base64_encoded vops/oncallbot/pilot | base64 -d)
        $
        $ export TF_VAR_datadog_app_key=$(vault kv get --field datadog_application_key_base64_encoded vops/oncallbot/pilot | base64 -d)
        ```
        Prod:
        ```
        $ vault login
        $ export TF_VAR_datadog_api_key=$(vault kv get --field datadog_api_key_base64_encoded vops/oncallbot/prod | base64 -d)
        $
        $ export TF_VAR_datadog_app_key=$(vault kv get --field datadog_application_key_base64_encoded vops/oncallbot/prod | base64 -d)
        ```
    * Verify the env variables
    `$ echo $TF_VAR_datadog_api_key $TF_VAR_datadog_app_key`
    * Run the following commands to create the monitor in Datadog
        ```
        $ terraform init # Only needed once
        $ terraform apply -auto-approve
        ```
    * The output of above command should give the URL to access the monitor from a browser