#!/bin/bash
set -eo pipefail

lambda_name="$1"

if [[ "$lambda_name" == "" ]];then lambda_name=color-lambda;fi

echo "create lambda alias LIVE"
newVersion=$(aws lambda publish-version --function-name $lambda_name --query Version --output text)
aws lambda create-alias --function-name=$lambda_name --name=live --function-version=$newVersion || aws lambda update-alias --function-name=$lambda_name --name=live --function-version=$newVersion