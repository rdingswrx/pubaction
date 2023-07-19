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
    path    = "vectorops/dd-monitor/tap-analysis-portal-dd-monitors/terraform_state"
  }
}

# Configure the Datadog provider
provider "datadog" {
  api_key = var.datadog_api_key 
  app_key = var.datadog_app_key
}

resource "datadog_monitor" "my-dd-monitor" {
  name    = "${var.monitor_name}"
  type    = "query alert"
  query   = "${var.monitor_query}"
  message = "${var.alert_message}"
  
  notify_audit        = false # Notify if monitor is changed
  require_full_window = true # Evaluats a full window of x minutes before notifying
  notify_no_data      = "${var.should_notify_when_no_data}" # Notifies if there is no data for x minutes
  no_data_timeframe   = "${var.no_data_timeframe_minutes}"  # How many minutes to wait before no data notification
  include_tags        = true # Tags
  tags    = "${var.tag_list}"
  restricted_roles    = ["4364991c-c421-11ed-9d76-da7ad0900002"] #UUID for VOpsRole
}