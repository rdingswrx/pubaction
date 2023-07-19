variable "datadog_api_key" {
  type = string
}

variable "datadog_app_key" {
  type = string
}

variable "monitor_name" {
  type = string
}

variable "monitor_query" {
  type = string
}

variable "alert_message" {
  type = string
}

variable "should_notify_when_no_data" {
  type = bool
  default = false
}

variable "no_data_timeframe_minutes" {
  type = number
  default = 120
}

variable "tag_list" {
  type = list(string)
}