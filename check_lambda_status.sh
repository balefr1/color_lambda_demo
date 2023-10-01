#!/bin/bash

set -xeuo pipefail
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin

function_name="$1"
region="$AWS_REGION"

STATE=$(aws lambda get-function --function-name "$function_name" --region $region --query 'Configuration.LastUpdateStatus' --output text)
while [[ "$STATE" == "InProgress" ]]
do
    echo "sleep 5sec ...."
    sleep 5s
    STATE=$(aws lambda get-function --function-name "$function_name" --region $region --query 'Configuration.LastUpdateStatus' --output text)
    echo $STATE
done