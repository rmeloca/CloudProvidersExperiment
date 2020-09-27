from libcloud.storage.types import Provider
from libcloud.storage.providers import get_driver

ACCESS_ID = "AKIAJ5TVZPWOSYKRW4FQ"
SECRET_KEY = "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"


cls = get_driver(Provider.S3_US_WEST)
driver = cls(key=ACCESS_ID, secret=SECRET_KEY)

BUCKET_NAME = "downloadfilesconteiner"
driver.create_container(BUCKET_NAME)      
bucket = driver.get_container(container_name=BUCKET_NAME)
## TODO - verificar aqui se o conteiner foi criado corretamente.

for i in ["155", "310", "620", "1240", "2480"]:
    for j in ["nativa-aws-java-", "nativa-aws-python-", "multicloud-aws-java-", "multicloud-aws-python-"]:
        bucket.upload_object(i, object_name= j + i, extra=None, verify_hash=True)

## TODO - verificar aqui se os arquivos foram realmente enviados
##bucket.download_object(obj, nomeArquivoDownload, overwrite_existing=True, delete_on_failure=True)
        
# for j in ["NativoAWSJava", "NativoAWSPython", "NativoAzureJava", "NativoAzurePython", "MulticloudAWSJava", "MulticloudAWSPython", "MulticloudAzureJava", "MulticloudAzurePython"]: