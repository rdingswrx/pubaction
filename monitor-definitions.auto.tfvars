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

####### Reactive-foresee pod count monitor START #######

"id005" = { # Needs to be unique
    monitor_name    = "foresee prod pod count < 6"
    monitor_query   = "max(last_15m):avg:kubernetes_state.deployment.replicas_available{env:prod,kube_namespace:foresee,app:reactive-foresee} < 6"
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
        "openshift-deployment-name:reactive-foresee-deployment",
        "openshift-namespace:foresee",
        "recovery-timeout-minutes:25"]
  },
####### Reactive-foresee pod count monitor END #######

####### Foresee FTM : Queue size - AnnComplete monitor START #######

"id006" = { # Needs to be unique
    monitor_name    = "Foresee FTM : Queue size - AnnComplete"
    monitor_query   = "min(last_10m):avg:mq.anncomplete.qsize{env:prod} by {source} > 100000"
    alert_message   = <<EOF
    {{#is_alert}}
    The size of the AnnComplete queue has grown larger than an expected healthy size. 
    {{/is_alert}} 
    {{#is_alert_recovery}}
    The size of the AnnComplete queue is recovered. 
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
        "openshift-deployment-name:reactive-foresee-deployment",
        "openshift-namespace:foresee",
        "recovery-timeout-minutes:25"]
  },
####### Foresee FTM : Queue size - AnnComplete monitor END #######

"id008" = { # Needs to be unique
    monitor_name    = "prov-profile-repl prod pod count < 1"
    monitor_query   = "max(last_15m):avg:kubernetes_state.deployment.replicas_available{env:prod,kube_namespace:ssp,service:prov-profile-repl} < 1"
    alert_message   = <<EOF
    {{#is_alert}}
    prod prov-profile-repl has no pods running. Check the deployment in OpenShift. 
    {{/is_alert}} 
    {{#is_alert_recovery}}
    prod prov-profile-repl capacity is recovered. 
    {{/is_alert_recovery}} 
    {{#is_no_data}}This monitor is missing data and can no longer monitor the prov-profile-repl service. It's possible metrics are no longer being submitted. Check the OpenShift deployment still exists and is in good health. Make sure the metric and tags this monitor checks still matches the deployment. If there is no explanation for missing data, it could be the metrics are not being submitted to DataDog and you should reach out to the Voltron team.{{/is_no_data}}
    {{#is_no_data_recovery}}This monitor is no longer missing data.{{/is_no_data_recovery}}
    Playbook: https://secureworks.atlassian.net/wiki/spaces/VOLPLAY/pages/467878281271/

    notify: @webhook-oncallbot-prod
    EOF
    tag_list = [
        "autoremediation:yes", 
        "notify:oncallbot", 
        "env:prod", 
        "service:prov-profile-repl", 
        "playbook:yes",
        "openshift-deployment-name:prov-profile-repl",
        "openshift-namespace:ssp",
        "recovery-timeout-minutes:12"]
  },

####### VT service prod pod count monitor START #######

"id009" = { # Needs to be unique
    monitor_name    = "VT service prod pod count < 1"
    monitor_query   = "max(last_15m):avg:kubernetes_state.deployment.replicas_available{env:prod,kube_namespace:foresee,service:vt-service} < 1"
    alert_message   = <<EOF
    {{#is_alert}}
    prod vt-service has no pods running. Check the deployment in OpenShift.
    {{/is_alert}}
    {{#is_alert_recovery}}
    prod vt-service capacity is recovered.
    {{/is_alert_recovery}}
    {{#is_no_data}}This monitor is missing data and can no longer monitor the VT service. It's possible metrics are no longer being submitted. Check the OpenShift deployment still exists and is in good health. Make sure the metric and tags this monitor checks still matches the deployment. If there is no explanation for missing data, it could be the metrics are not being submitted to DataDog and you should reach out to the Voltron team.{{/is_no_data}}
 {{#is_no_data_recovery}}This monitor is no longer missing data.{{/is_no_data_recovery}}
    Playbook: https://secureworks.atlassian.net/wiki/spaces/VOLPLAY/pages/467878281271/

    notify: @webhook-oncallbot-prod
    EOF
    tag_list = [
        "autoremediation:yes",
        "notify:oncallbot",
        "env:prod",
        "service:vt-service",
        "playbook:yes",
        "openshift-deployment-name:vt-service-deployment",
        "openshift-namespace:foresee",
        "recovery-timeout-minutes:25"]
  },
####### VT service prod pod count monitor END #######

####### VT manager prod pod count monitor START #######

"id010" = { # Needs to be unique
    monitor_name    = "VT manager prod pod count < 1"
    monitor_query   = "max(last_15m):avg:kubernetes_state.deployment.replicas_available{env:prod,kube_namespace:foresee,service:vt-manager} < 1"
    alert_message   = <<EOF
    {{#is_alert}}
    prod vt-manager has no pods running. Check the deployment in OpenShift.
    {{/is_alert}}
    {{#is_alert_recovery}}
    prod vt-manager capacity is recovered.
    {{/is_alert_recovery}}
    {{#is_no_data}}This monitor is missing data and can no longer monitor the VT manager. It's possible metrics are no longer being submitted. Check the OpenShift deployment still exists and is in good health. Make sure the metric and tags this monitor checks still matches the deployment. If there is no explanation for missing data, it could be the metrics are not being submitted to DataDog and you should reach out to the Voltron team.{{/is_no_data}}
 {{#is_no_data_recovery}}This monitor is no longer missing data.{{/is_no_data_recovery}}
    Playbook: https://secureworks.atlassian.net/wiki/spaces/VOLPLAY/pages/467878281271/

    notify: @webhook-oncallbot-prod
    EOF
    tag_list = [
        "autoremediation:yes",
        "notify:oncallbot",
        "env:prod",
        "service:vt-manager",
        "playbook:yes",
        "openshift-deployment-name:vt-manager-deployment",
        "openshift-namespace:foresee",
        "recovery-timeout-minutes:25"]
  },
####### VT manager prod pod count monitor END #######

####### Whoisservice prod pod count monitor START #######

"id011" = { # Needs to be unique
    monitor_name    = "Whois service prod pod count < 1"
    monitor_query   = "max(last_15m):avg:kubernetes_state.deployment.replicas_available{env:prod,kube_namespace:foresee,service:whois-service} < 1"
    alert_message   = <<EOF
    {{#is_alert}}
    prod Whois service has no pods running. Check the deployment in OpenShift.
    {{/is_alert}}
    {{#is_alert_recovery}}
    prod Whois service capacity is recovered.
    {{/is_alert_recovery}}
    {{#is_no_data}}This monitor is missing data and can no longer monitor the Whois service. It's possible metrics are no longer being submitted. Check the OpenShift deployment still exists and is in good health. Make sure the metric and tags this monitor checks still matches the deployment. If there is no explanation for missing data, it could be the metrics are not being submitted to DataDog and you should reach out to the Voltron team.{{/is_no_data}}
 {{#is_no_data_recovery}}This monitor is no longer missing data.{{/is_no_data_recovery}}
    Playbook: https://secureworks.atlassian.net/wiki/spaces/VOLPLAY/pages/467878281271/

    notify: @webhook-oncallbot-prod
    EOF
    tag_list = [
        "autoremediation:yes",
        "notify:oncallbot",
        "env:prod",
        "service:whois-service",
        "playbook:yes",
        "openshift-deployment-name:whois-service-deployment",
        "openshift-namespace:foresee",
        "recovery-timeout-minutes:25"]
  },
####### Whoisservice prod pod count monitor END #######

####### Broadscanservice prod pod count monitor START #######

"id012" = { # Needs to be unique
    monitor_name    = "Broadscan service prod pod count < 1"
    monitor_query   = "max(last_15m):avg:kubernetes_state.deployment.replicas_available{env:prod,kube_namespace:foresee,service:broadscan-service} < 1"
    alert_message   = <<EOF
    {{#is_alert}}
    prod broadscan service has no pods running. Check the deployment in OpenShift.
    {{/is_alert}}
    {{#is_alert_recovery}}
    prod broadscan service capacity is recovered.
    {{/is_alert_recovery}}
    {{#is_no_data}}This monitor is missing data and can no longer monitor the broadscan service. It's possible metrics are no longer being submitted. Check the OpenShift deployment still exists and is in good health. Make sure the metric and tags this monitor checks still matches the deployment. If there is no explanation for missing data, it could be the metrics are not being submitted to DataDog and you should reach out to the Voltron team.{{/is_no_data}}
 {{#is_no_data_recovery}}This monitor is no longer missing data.{{/is_no_data_recovery}}
    Playbook: https://secureworks.atlassian.net/wiki/spaces/VOLPLAY/pages/467878281271/

    notify: @webhook-oncallbot-prod
    EOF
    tag_list = [
        "autoremediation:yes",
        "notify:oncallbot",
        "env:prod",
        "service:broadscan-service",
        "playbook:yes",
        "openshift-deployment-name:broadscan-service-deployment",
        "openshift-namespace:foresee",
        "recovery-timeout-minutes:25"]
  },
####### Broadscanservice prod pod count monitor END #######

####### Usecase annotator prod pod count monitor START #######

"id013" = { # Needs to be unique
    monitor_name    = "Usecase annotator prod pod count < 2"
    monitor_query   = "max(last_15m):avg:kubernetes_state.deployment.replicas_available{env:prod,kube_namespace:usecase,service:use-case-annotator} < 2"
    alert_message   = <<EOF
    {{#is_alert}}
    prod Usecaseannotator has less than 2 pods running. Check the deployment in OpenShift. 
    {{/is_alert}} 
    {{#is_alert_recovery}}
    prod Usecaseannotator capacity is recovered. 
    {{/is_alert_recovery}} 
    {{#is_no_data}}This monitor is missing data and can no longer monitor the usecase annotator service. It's possible metrics are no longer being submitted. Check the OpenShift deployment still exists and is in good health. Make sure the metric and tags this monitor checks still matches the deployment. If there is no explanation for missing data, it could be the metrics are not being submitted to DataDog and you should reach out to the Voltron team.{{/is_no_data}}
    {{#is_no_data_recovery}}This monitor is no longer missing data.{{/is_no_data_recovery}}
    Playbook: https://secureworks.atlassian.net/wiki/spaces/VOLPLAY/pages/467878281271/

    notify: @webhook-oncallbot-prod
    EOF
    tag_list = [
        "autoremediation:yes", 
        "notify:oncallbot", 
        "env:prod", 
        "service:use-case-annotator", 
        "playbook:yes",
        "openshift-deployment-name:use-case-annotator",
        "openshift-namespace:usecase",
        "recovery-timeout-minutes:25"]
  },
####### Usecase annotator prod pod count monitor END #######

####### Usecase annotator queue size monitor START #######

"id014" = { # Needs to be unique
    monitor_name    = "Queue Size - UseCaseAnnotator at broker"
    monitor_query   = "min(last_15m):avg:mq.usecaseannotator.qsize{env:prod} by {source} > 20000"
    alert_message   = <<EOF
    {{#is_alert}}
    The size of the Usecaseannotator queue has grown larger than an expected healthy size. 
    {{/is_alert}} 
    {{#is_alert_recovery}}
    The size of the Usecaseannotator queue is recovered. 
    {{/is_alert_recovery}} 
    {{#is_no_data}}This monitor is missing data and can no longer monitor the usecase annotator service. It's possible metrics are no longer being submitted. Check the OpenShift deployment still exists and is in good health. Make sure the metric and tags this monitor checks still matches the deployment. If there is no explanation for missing data, it could be the metrics are not being submitted to DataDog and you should reach out to the Voltron team.{{/is_no_data}}
    {{#is_no_data_recovery}}This monitor is no longer missing data.{{/is_no_data_recovery}}
    Playbook: https://secureworks.atlassian.net/wiki/spaces/VOLPLAY/pages/46825secase+Annotator

    notify: @webhook-oncallbot-prod
    EOF
    tag_list = [
        "autoremediation:yes", 
        "notify:oncallbot", 
        "env:prod", 
        "service:use-case-annotator", 
        "playbook:yes",
        "openshift-deployment-name:use-case-annotator",
        "openshift-namespace:usecase",
        "recovery-timeout-minutes:25"]
  },
####### Usecase annotator queue size monitor END #######

}
