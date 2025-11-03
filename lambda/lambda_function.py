import json
import boto3
import urllib3
import gzip

http = urllib3.PoolManager()
s3 = boto3.client('s3')

def lambda_handler(event, context):
    for record in event['Records']:
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']
        if not key.endswith('.csv'):
            continue

        response = s3.get_object(Bucket=bucket, Key=key)
        content = response['Body'].read().decode('utf-8')

        endpoint = f"https://{context.env['OPENSEARCH_ENDPOINT']}/{context.env['INDEX_NAME']}/_doc/"
        for line in content.splitlines()[1:]:
            fields = line.split(',')
            doc = {"asset": fields[0], "status": fields[1], "score": fields[2]}
            http.request("POST", endpoint, body=json.dumps(doc), headers={"Content-Type": "application/json"})
