#!/bin/bash

SQS_PACKAGE_VERSION=$(node -p -e "require('./lambdas/sqs-target/package.json').version")
EVENT_BRIDGE_PACKAGE_VERSION=$(node -p -e "require('./lambdas/sqs-target/package.json').version")

cd ./lambdas/sqs-target
zip -r ../../packages/sqs-target.zip ./

cd ../../lambdas/trigger-eventbridge
zip -r ../../packages/trigger-eventbridge.zip ./

cd ../../

aws s3api put-object --bucket hackett-inc-deployment-artifacts --key lambdas/sqs-target-$SQS_PACKAGE_VERSION.zip --body packages/sqs-target.zip
aws s3api put-object --bucket hackett-inc-deployment-artifacts --key lambdas/trigger-eventbridge-$EVENT_BRIDGE_PACKAGE_VERSION.zip --body packages/trigger-eventbridge.zip