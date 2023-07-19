output "monitor_url" {
  value = "https://app.datadoghq.com/monitors/${datadog_monitor.my-dd-monitor.id}"
}