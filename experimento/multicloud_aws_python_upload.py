from libcloud.storage.types import Provider
from libcloud.storage.providers import get_driver
import time
import sys

ACCESS_ID = "AKIAJ5TVZPWOSYKRW4FQ"
SECRET_KEY = "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"


bucketName = sys.argv[1]
nomeArquivo = sys.argv[2]
tempoMilis = 0
iniMilis = 0
fimMilis = 0


cls = get_driver(Provider.S3_US_WEST)
driver = cls(key=ACCESS_ID, secret=SECRET_KEY)

##### create container #####
#driver.create_container(bucketName)
bucket = driver.get_container(container_name=bucketName)

##### upload container #####
iniMilis = time.time()
bucket.upload_object(nomeArquivo, object_name=nomeArquivo, extra=None, verify_hash=True)
fimMilis = time.time()
tempoMilis = fimMilis - iniMilis

sys.stdout.write(str(tempoMilis * 1000))

##### delete container #####
#obj = bucket.get_object(nomeArquivo)
#bucket.delete_object(obj)
#driver.delete_container(bucket)
