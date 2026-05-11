import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

REQUIRED_TAGS = [
    "Name",
    "Owner", 
    "ContactEmail",
    "Application",
    "Project",
    "ProjectEndDate"
]

def handler(event, context):
    try:
        logger.info(f"Received event: {json.dumps(event)}")
        
        tags = event.get("tags", {})
        
        missing_tags = [tag for tag in REQUIRED_TAGS if tag not in tags]
        present_tags = [tag for tag in REQUIRED_TAGS if tag in tags]
        
        if missing_tags:
            return {
                "statusCode": 400,
                "body": json.dumps({
                    "status"       : "FAILED",
                    "message"      : "Missing mandatory tags!",
                    "missing_tags" : missing_tags,
                    "present_tags" : present_tags
                }, indent=2)
            }

        return {
            "statusCode": 200,
            "body": json.dumps({
                "status"      : "PASSED",
                "message"     : "All mandatory tags are present!",
                "validated"   : tags
            }, indent=2)
        }

    except Exception as e:
        logger.error(f"Error: {str(e)}")
        return {
            "statusCode": 500,
            "body": json.dumps({
                "error": str(e)
            })
        }