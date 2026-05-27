import sys
import boto3
import csv
import io
import logging
from awsglue.utils import getResolvedOptions

# Setup logging
logging.basicConfig()
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

# Get job arguments
args = getResolvedOptions(sys.argv, ["BUCKET_NAME"])
BUCKET_NAME = args["BUCKET_NAME"]

s3 = boto3.client("s3")

def main():
    try:
        # Read file from S3
        logger.info(f"Reading input file from S3: {BUCKET_NAME}/input/data.csv")
        response = s3.get_object(Bucket=BUCKET_NAME, Key="input/data.csv")
        content = response["Body"].read().decode("utf-8")

        # Transform — convert names to uppercase
        reader = csv.DictReader(io.StringIO(content))
        rows = []
        for row in reader:
            row["name"] = row["name"].upper()
            rows.append(row)

        # Write transformed file back to S3
        output = io.StringIO()
        writer = csv.DictWriter(output, fieldnames=["name", "age"])
        writer.writeheader()
        writer.writerows(rows)

        s3.put_object(
            Bucket=BUCKET_NAME,
            Key="output/glue-data.csv",
            Body=output.getvalue()
        )

        logger.info("Glue transformation complete! Output written to output/glue-data.csv")

    except Exception as e:
        logger.error(f"Error: {str(e)}")
        raise

if __name__ == "__main__":
    main()