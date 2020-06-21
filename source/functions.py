import hashlib
import boto3
from botocore.exceptions import ClientError
import os
def put_link(fullUrl,dynamodb=None):
    if not dynamodb:
        dynamodb = boto3.resource('dynamodb', region_name=os.environ['REGION'])
    fullUrl_hash=hashlib.md5(fullUrl.encode()).hexdigest()

    table = dynamodb.Table('shortlink')
    response = table.put_item(
       Item={
            'id': fullUrl_hash,
            'link': fullUrl,
        }
    )
    if response["ResponseMetadata"]["HTTPStatusCode"]==200:
        return fullUrl_hash
    else:
        return "ERROR, call to system administrator"

def get_link(id, dynamodb=None):
    if not dynamodb:
        dynamodb = boto3.resource('dynamodb', region_name=os.environ['REGION'])

    table = dynamodb.Table('shortlink')

    try:
        response = table.get_item(Key={'id': id})
    except ClientError as e:
        print(e.response['Error']['Message'])
    else:
        return response['Item']['link']

if __name__ == '__main__':
    put_link("http://127.0.0.1:8888/create")
    get_link("b067947c66f92ca65f5ff0577645f09b")