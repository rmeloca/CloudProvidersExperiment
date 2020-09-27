from libcloud.storage.types import Provider
from libcloud.storage.providers import get_driver

STORAGE_ACC_NAME = "experimento"
SECRET_KEY = "Bsm9hts00DsMXBnPPPCtk6c/JajtHqGDGyOufvEJ84AqU5CVUVy87Nt09Vz2sptq/7JiWblC5BBYp+QQMWG9dg=="


cls = get_driver(Provider.AZURE_BLOBS)
driver = cls(key=STORAGE_ACC_NAME, secret=SECRET_KEY)


bucketName = "downloadfilesconteiner"
bucket = driver.get_container(container_name=bucketName)
for obj in bucket.list_objects():
	bucket.delete_object(obj)
driver.delete_container(bucket)


for api in ["nativa", "multicloud"]:
	for linguagem in ["java", "python"]:
		for fileSize in ["155", "310", "620", "1240", "2480"]:
			bucketName = api + "-azure-" + linguagem + "-upload-" + fileSize
			#driver.create_container(bucketName)
			bucket = driver.get_container(container_name=bucketName)
			for obj in bucket.list_objects():
				bucket.delete_object(obj)
			driver.delete_container(bucket)
