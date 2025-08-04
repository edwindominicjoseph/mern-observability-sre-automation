#!/bin/bash

export PATH=$PATH:{{ watchdog_pm2_path }}

URL="{{ watchdog_api_url }}"
LOG="{{ watchdog_log_path }}"
EXPECTED="{{ watchdog_expected_content }}"
PM2_PROCESS="{{ watchdog_pm2_process }}"
SLACK_WEBHOOK="{{ watchdog_slack_webhook }}"
TIMESTAMP=$(date)

if ! curl --silent --fail "$URL" | grep -q "$EXPECTED"; then
    echo "$TIMESTAMP: ❌ API unhealthy. Restarting PM2..." >> "$LOG"
    pm2 restart "$PM2_PROCESS"

    if [[ ! -z "$SLACK_WEBHOOK" ]]; then
      curl -X POST -H 'Content-type: application/json' --data \
        "{\"text\":\"🚨 Watchdog Alert: API unhealthy at $TIMESTAMP. PM2 restarted.\"}" \
        "$SLACK_WEBHOOK"
    fi
else
    echo "$TIMESTAMP: ✅ API healthy." >> "$LOG"
fi
