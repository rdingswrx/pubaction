Vops-alerts
===

This repo will contain all the alerts that we create using Terraform scripts. This will help us integrate with oncallbot that will restart pods automatically before paging the on-call resource.

Quick Start
---
* Define your monitor in Terraform:
    * Clone this repo: `git clone ssh://git@bitbucket-prod.aws.secureworks.com:7999/vops/vops-alerts.git`
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
        * Change the id `"id<a-number>"`.
          * MUST Ensure this is unique for your monitor. Do not change this once you set it. This ID is used by terraform to track changes to tf state. Suggestion is to increment (i.e. +1) from the last monitor definition
        * Change all the variable values inside the monitor definition as per your application.
          * Please ensure that the following tags are correctly set:
            ```
            "env:prod", 
            "service:analysis-portal", 
            "playbook:yes",
            "openshift-deployment-name:analysis-portal-202208-1", # The deployment name that oncallbot will use to restart pods
            "openshift-namespace:tap", # The namespace in OKD that oncallbot will use to restart pods
            "recovery-timeout-minutes:12" # Time in minutes before oncallbot decide if the application is healthy after the restart or not
            ```
          * Please also ensure the following:
            * `service` tag in the tag_list must match the `service` in the monitor_name
            * `env` tag in monitor_query and the `env` tag in the tag_list must match
            * `namespace` name in the monitor_query and in the tag_list must match.
    * Check-in the code and push to remote: `git push --set-upstream origin <branch-name>`
    * Open PR. Wait for approval.
    * Merge the PR in bitbucket web UI.
* Apply changes to create monitor:
    * Once PR is approved and merged, follow steps below to apply the changes to create the monitor.
        * Switch to the main branch: `git checkout main`
        * Login to [vault web UI](https://vault.aws.secureworks.com/ui/vault/secrets). Copy your CLI token.
        * Run following commands to retrieve Datadog keys from Vault and set them as env variables.
            Prod:
            ```
            $ vault login
            $ export TF_VAR_datadog_api_key=$(vault kv get --field datadog_api_key_base64_encoded vops/oncallbot/prod | base64 -d)
            $
            $ export TF_VAR_datadog_app_key=$(vault kv get --field datadog_application_key_base64_encoded vops/oncallbot/prod | base64 -d)
            ```
            Pilot (used for testing oncallbot):
            ```
            $ vault login
            $ export TF_VAR_datadog_api_key=$(vault kv get --field datadog_api_key_base64_encoded vops/oncallbot/pilot | base64 -d)
            $
            $ export TF_VAR_datadog_app_key=$(vault kv get --field datadog_application_key_base64_encoded vops/oncallbot/pilot | base64 -d)
            ```
        * Verify the env variables
        `$ echo $TF_VAR_datadog_api_key $TF_VAR_datadog_app_key`
        * Run the following commands to create the monitor in Datadog
            ```
            $ terraform init # Only needed once
            $ terraform plan
            ```
            #### IMPORTANT: Please pause and review the output from the previous terraform command to confirm that the change is only for the monitor that you edited/created ####
            ```
            $ terraform apply -auto-approve
            ```