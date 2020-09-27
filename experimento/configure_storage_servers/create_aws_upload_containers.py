from libcloud.storage.types import Provider
from libcloud.storage.providers import get_driver

ACCESS_ID = "AKIAJ5TVZPWOSYKRW4FQ"
SECRET_KEY = "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"

cls = get_driver(Provider.S3_US_WEST)
driver = cls(key=ACCESS_ID, secret=SECRET_KEY)


##### create containers to receive uploads #####
for api in ["nativa", "multicloud"]:
    for linguagem in ["java", "python"]:
        for fileSize in ["155", "310", "620", "1240", "2480"]:
            bucketName = api + "-aws-" + linguagem + "-upload-" + fileSize
            driver.create_container(bucketName)
            bucket = driver.get_container(container_name=bucketName)
            ### TODO verificar aqui se o conteiner foi corretamente criado