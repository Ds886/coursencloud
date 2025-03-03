#!/bin/sh
set -ux

B_NAME=dashash-ex07-plan


aws s3api create-bucket --bucket "${B_NAME}" --region us-east-1
aws dynamodb create-table --table-name "terraform-locking-${B_NAME}" --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1
