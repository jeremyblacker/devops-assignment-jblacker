import json

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'headers' : {
            'content-type' : 'text/html',
        },
        'body': '<html><body>' + event['requestContext']['http']['sourceIp'] + '</body></html>'
    }
