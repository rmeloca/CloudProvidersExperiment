from libcloud.storage.types import Provider
from libcloud.storage.providers import get_driver

ACCESS_ID = "AKIAJ5TVZPWOSYKRW4FQ"
SECRET_KEY = "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"


cls = get_driver(Provider.S3_US_WEST)
driver = cls(key=ACCESS_ID, secret=SECRET_KEY)

bucket = driver.get_container(container_name="experimentofile")

obj = bucket.get_object("experimento.zip")
bucket.download_object(obj, "experimento.zip", overwrite_existing=True, delete_on_failure=True)