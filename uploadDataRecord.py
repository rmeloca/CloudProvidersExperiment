from libcloud.storage.types import Provider
from libcloud.storage.providers import get_driver

ACCESS_ID = "AKIAJ5TVZPWOSYKRW4FQ"
SECRET_KEY = "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"


cls = get_driver(Provider.S3_US_WEST)
driver = cls(key=ACCESS_ID, secret=SECRET_KEY)

BUCKET_NAME = "experimentofile"
#driver.create_container(BUCKET_NAME)
bucket = driver.get_container(container_name=BUCKET_NAME)
bucket.upload_object("ExperimentDataRecord.zip", object_name="ExperimentDataRecord.zip", extra=None, verify_hash=True)
