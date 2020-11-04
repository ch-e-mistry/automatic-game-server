#!/bin/bash
WEBHOOK_LINK="https://outlook.office.com/webhook/8e2683ac-4ffc-46ca-b9e0-2ae33150db87@b41b72d0-4e9f-4c26-8a69-f949f367c91d/IncomingWebhook/3a17a7306074494abf99f520b663325f/6bdf8381-4c28-4e97-b720-3c3752a8e5bd"
custom_variable=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
#custom_variable="1.2.3.4"
curl -H 'Content-Type: application/json' -d '{"text": "Hey! You can play Counter Strike: Global Offensive here:

'"$custom_variable"'

Enjoy it :)"}'  $WEBHOOK_LINK