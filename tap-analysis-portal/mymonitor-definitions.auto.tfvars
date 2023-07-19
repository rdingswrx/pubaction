monitor_name    = "tap-analysis-portal pilot pod count < 1"
monitor_query   = "max(last_1m):sum:kubernetes_state.container.ready{kube_namespace:tap,env:pilot,service:analysis-portal} < 1"
alert_message   = <<EOF
TAP analysis portal service has less than 1 pod available in pilot for at least the last 10 minutes.

This monitor will try to autoremediate by restarting the pods using oncallbot. 

If restart does not help, oncallbot will notify the correct on-call resource using PagerDuty.

Playbook:https://secureworks.atlassian.net/wiki/spaces/VOLPLAY/pages/467710346247/

notify:@webhook-oncallbot-pilot

EOF
tag_list = [
    "autoremediation:yes", 
    "notify:oncallbot", 
    "env:pilot", 
    "service:analysis-portal", 
    "playbook:yes",
    "openshift-deployment-name:analysis-portal-202208-1",
    "openshift-namespace:tap",
    "recovery-timeout-minutes:2"]