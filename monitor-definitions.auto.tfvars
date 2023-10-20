dd-monitor-definitions = {
  ####### TAP analysis portal pod count monitor START #######
  "id001" = { # Needs to be unique
    monitor_name    = "analysis-portal - pod count < 1" # Follow the format: <service> - <alert summary>
    # The query to be used by the monitor.
    monitor_query   = "max(last_1m):sum:kubernetes_state.container.ready{kube_namespace:tap,env:prod,service:analysis-portal} < 1"
    # The message sent when alert is fired
    alert_message   = <<EOF
    TAP analysis portal service has less than 1 pod available in prod for at least the last 10 minutes.

    This monitor will try to autoremediate by restarting the pods using oncallbot. 

    If restart does not help, oncallbot will notify the on-call resource using PagerDuty.

    Playbook:https://secureworks.atlassian.net/wiki/spaces/VOLPLAY/pages/467710346247/

    notify:@webhook-oncallbot-prod

    EOF
    # List of tags for the monitor
    tag_list = [
        "autoremediation:yes", 
        "notify:oncallbot", 
        "env:prod", 
        "service:analysis-portal", 
        "playbook:yes",
        "openshift-deployment-name:analysis-portal-202208-1",
        "openshift-namespace:tap",
        "recovery-timeout-minutes:2"]
  },
  ####### TAP analysis portal pod count monitor END #######


  ####### SSP pod count monitor START #######
  "id002" = { # Needs to be unique
    monitor_name    = "prov-inventory pilot pod count < 1"
    monitor_query   = "max(last_15m):avg:kubernetes_state.deployment.replicas_available{env:pilot,kube_namespace:ssp,service:prov-inventory} < 1"
    alert_message   = <<EOF
    {{#is_alert}}
    pilot prov-inventory has no pods running. Check the deployment in OpenShift. 
    {{/is_alert}} 
    {{#is_alert_recovery}}
    pilot prov-inventory capacity is recovered. 
    {{/is_alert_recovery}} 
    {{#is_no_data}}This monitor is missing data and can no longer monitor the prov-inventory service. It's possible metrics are no longer being submitted. Check the OpenShift deployment still exists and is in good health. Make sure the metric and tags this monitor checks still matches the deployment. If there is no explanation for missing data, it could be the metrics are not being submitted to DataDog and you should reach out to the Voltron team.{{/is_no_data}}
    {{#is_no_data_recovery}}This monitor is no longer missing data.{{/is_no_data_recovery}}
    Playbook: https://secureworks.atlassian.net/wiki/spaces/VOLPLAY/pages/467878281271/

    notify: @webhook-oncallbot-pilot 
    EOF
    tag_list = [
        "autoremediation:yes", 
        "notify:oncallbot", 
        "env:pilot", 
        "service:prov-inventory", 
        "playbook:yes",
        "openshift-deployment-name:prov-inventory",
        "openshift-namespace:ssp",
        "recovery-timeout-minutes:12"]
  },
  "id003" = { # Needs to be unique
    monitor_name    = "prov-inventory prod pod count < 1"
    monitor_query   = "max(last_15m):avg:kubernetes_state.deployment.replicas_available{env:prod,kube_namespace:ssp,service:prov-inventory} < 1"
    alert_message   = <<EOF
    {{#is_alert}}
    prod prov-inventory has no pods running. Check the deployment in OpenShift. 
    {{/is_alert}} 
    {{#is_alert_recovery}}
    prod prov-inventory capacity is recovered. 
    {{/is_alert_recovery}} 
    {{#is_no_data}}This monitor is missing data and can no longer monitor the prov-inventory service. It's possible metrics are no longer being submitted. Check the OpenShift deployment still exists and is in good health. Make sure the metric and tags this monitor checks still matches the deployment. If there is no explanation for missing data, it could be the metrics are not being submitted to DataDog and you should reach out to the Voltron team.{{/is_no_data}}
    {{#is_no_data_recovery}}This monitor is no longer missing data.{{/is_no_data_recovery}}
    Playbook: https://secureworks.atlassian.net/wiki/spaces/VOLPLAY/pages/467878281271/

    notify: @webhook-oncallbot-prod
    EOF
    tag_list = [
        "autoremediation:yes", 
        "notify:oncallbot", 
        "env:prod", 
        "service:prov-inventory", 
        "playbook:yes",
        "openshift-deployment-name:prov-inventory",
        "openshift-namespace:ssp",
        "recovery-timeout-minutes:12"]
  },
  "id004" = { # Needs to be unique
    monitor_name    = "prov-profile-ui prod pod count < 1"
    monitor_query   = "max(last_15m):avg:kubernetes_state.deployment.replicas_available{env:prod,kube_namespace:ssp,service:prov-profile-ui} < 1"
    alert_message   = <<EOF
    {{#is_alert}}
    prod prov-profile-ui has no pods running. Check the deployment in OpenShift. 
    {{/is_alert}} 
    {{#is_alert_recovery}}
    prod prov-profile-ui capacity is recovered. 
    {{/is_alert_recovery}} 
    {{#is_no_data}}This monitor is missing data and can no longer monitor the prov-profile-ui service. It's possible metrics are no longer being submitted. Check the OpenShift deployment still exists and is in good health. Make sure the metric and tags this monitor checks still matches the deployment. If there is no explanation for missing data, it could be the metrics are not being submitted to DataDog and you should reach out to the Voltron team.{{/is_no_data}}
    {{#is_no_data_recovery}}This monitor is no longer missing data.{{/is_no_data_recovery}}
    Playbook: https://secureworks.atlassian.net/wiki/spaces/VOLPLAY/pages/467878281271/

    notify: @webhook-oncallbot-prod
    EOF
    tag_list = [
        "autoremediation:yes", 
        "notify:oncallbot", 
        "env:prod", 
        "service:prov-profile-ui", 
        "playbook:yes",
        "openshift-deployment-name:prov-profile-ui",
        "openshift-namespace:ssp",
        "recovery-timeout-minutes:12"]
  },
  ####### SSP pod count monitor END #######

"id005" = { # Needs to be unique
    monitor_name    = "foresee prod pod count < 8"
    monitor_query   = "max(last_15m):sum:kubernetes_state.container.ready{kube_cluster_name:okd-useast1-prod,kube_namespace:foresee,app:reactive-foresee} by {app}.rollup(avg, 60).fill(null) < 6"
    alert_message   = <<EOF
    {{#is_alert}}
    prod reactive-foresee has less than 6 pods running. Check the deployment in OpenShift. 
    {{/is_alert}} 
    {{#is_alert_recovery}}
    prod reactive-foresee capacity is recovered. 
    {{/is_alert_recovery}} 
    {{#is_no_data}}This monitor is missing data and can no longer monitor the reactive-foresee service. It's possible metrics are no longer being submitted. Check the OpenShift deployment still exists and is in good health. Make sure the metric and tags this monitor checks still matches the deployment. If there is no explanation for missing data, it could be the metrics are not being submitted to DataDog and you should reach out to the Voltron team.{{/is_no_data}}
    {{#is_no_data_recovery}}This monitor is no longer missing data.{{/is_no_data_recovery}}
    Playbook: https://secureworks.atlassian.net/wiki/spaces/VOLPLAY/pages/467878281271/

    notify: @webhook-oncallbot-prod
    EOF
    tag_list = [
        "autoremediation:yes", 
        "notify:oncallbot", 
        "env:prod", 
        "service:reactive-foresee", 
        "playbook:yes",
        "openshift-deployment-name:reactive-foresee",
        "openshift-namespace:foresee",
        "recovery-timeout-minutes:30"]
  },
}
