"""Test lambda"""

import json
import os
import urllib.request


def handler(_event, _context):
    """Lambda handler to fetch external IP address"""
    url = os.environ.get("IP_CHECK_URL", "https://api.ipify.org?format=json")
    try:
        with urllib.request.urlopen(url, timeout=10) as r:
            body = r.read().decode()
    # pylint: disable=broad-except
    except Exception as e:
        print("error_fetching_ip:", e)
        return {"statusCode": 500, "body": json.dumps({"error": str(e)})}

    print("external_ip:", body)
    return {"statusCode": 200, "body": body}
