#!/bin/env python3
import boto3

s3 = boto3.client('s3', region_name='us-east-1')
s3.create_bucket(Bucket='my-experts-alexkasd')
