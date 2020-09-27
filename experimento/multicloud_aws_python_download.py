from libcloud.storage.types import Provider
from libcloud.storage.providers import get_driver
import time
import sys

ACCESS_ID = "AKIAJ5TVZPWOSYKRW4FQ"
SECRET_KEY = "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"


bucketName = sys.argv[1]
nomeArquivo = sys.argv[2]
nomeArquivoDownload = "download"
tempoMilis = 0
iniMilis = 0
fimMilis = 0


cls = get_driver(Provider.S3_US_WEST)
driver = cls(key=ACCESS_ID, secret=SECRET_KEY)

bucket = driver.get_container(container_name=bucketName)

##### download container #####
iniMilis = time.time()
obj = bucket.get_object(nomeArquivo)
bucket.download_object(obj, nomeArquivoDownload, overwrite_existing=True, delete_on_failure=True)
fimMilis = time.time()
tempoMilis = fimMilis - iniMilis

sys.stdout.write(str(tempoMilis * 1000))
