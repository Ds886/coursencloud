#!/bin/sh
set -ux

B_NAME=dashash-ex07-plan
B_REGION=us-east-1


aws s3api delete-bucket --bucket "${B_NAME}" --region "${B_REGION}"
aws dynamodb delete-table --table-name "terraform-locking-${B_NAME}"  --region "${B_REGION}"
