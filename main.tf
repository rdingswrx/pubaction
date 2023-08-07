terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }

  backend "consul" {
    address = "consul.aws.secureworks.com"
    scheme  = "https"
    lock    = true
    # tf_state_consul_path needs to be unique for your app
    path    = "vectorops/dd-monitors/vectorops-alerts-project/terraform_state"
  }
}

variable "datadog_api_key" {
  type = string
}

variable "datadog_app_key" {
  type = string
}

variable "dd-monitor-definitions" {
  type = map(object({
    monitor_name    = string
    monitor_query   = string
    alert_message   = string
    tag_list        = list(string)
  }))
}

# Configure the Datadog provider
provider "datadog" {
  api_key = var.datadog_api_key 
  app_key = var.datadog_app_key
}

resource "datadog_monitor" "monitor-definitions" {
  for_each = var.dd-monitor-definitions

  name    = each.value.monitor_name
  type    = "query alert"
  query   = each.value.monitor_query
  message = each.value.alert_message
  
  notify_audit        = false # Notify if monitor is changed
  require_full_window = true # Evaluats a full window of x minutes before notifying
  include_tags        = true # Tags
  tags    = each.value.tag_list
  restricted_roles    = ["4364991c-c421-11ed-9d76-da7ad0900002"] #UUID for VOpsRole
}