Vops-alerts
===

This repo will contain all the alerts that we create using Terraform scripts. This will help us integrate with oncallbot that will restart pods automatically before paging the on-call resource.


1. Create Datadog monitors using terraform.

Quick Start
---
* Clone the repo
* Copy one of the working directories for your app `cp tap-analysis-portal <my-app-name>`
* Edit the existing file `mymonitor-definitions.auto.tfvars`. Set all values appropriately.
* Edit the `main.tf` file line 13. Set a unique path for your app to store Terraform states.
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