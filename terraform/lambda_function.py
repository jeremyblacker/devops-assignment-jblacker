import json

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'headers' : {
            'Content-Type' : 'text/html',
        },
        'body': '<html><body>' + event['requestContext']['http']['sourceIp'] + '</body></html>'
    }
