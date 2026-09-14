import json


def handler(event, context):
    """Return a basic response that can be replaced with YMCA application logic."""
    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps({"message": "YMCA Lambda is running"}),
    }