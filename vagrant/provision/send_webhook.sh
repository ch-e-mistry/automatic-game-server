#!/bin/bash
#todo Replace webhook url
WEBHOOK_LINK="https://outlook.office.com/webhook/YOUR_INCOMING_WEBHOOK_URL"
custom_variable=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
#custom_variable="1.2.3.4"
curl -H 'Content-Type: application/json' -d '{"text": "Hey! You can play Counter Strike: Global Offensive here:

'"$custom_variable"'

Enjoy it :)"}'  $WEBHOOK_LINK