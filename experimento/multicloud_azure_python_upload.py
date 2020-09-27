from libcloud.storage.types import Provider
from libcloud.storage.providers import get_driver
import time
import sys

STORAGE_ACC_NAME = "experimento"
SECRET_KEY = "Bsm9hts00DsMXBnPPPCtk6c/JajtHqGDGyOufvEJ84AqU5CVUVy87Nt09Vz2sptq/7JiWblC5BBYp+QQMWG9dg=="


containerName = sys.argv[1]
nomeArquivo = sys.argv[2]
tempoMilis = 0
iniMilis = 0
fimMilis = 0


cls = get_driver(Provider.AZURE_BLOBS)
driver = cls(key=STORAGE_ACC_NAME, secret=SECRET_KEY)

##### create container #####
#driver.create_container(containerName)
container = driver.get_container(container_name=containerName)

##### upload container #####
iniMilis = time.time()
container.upload_object(nomeArquivo, object_name=nomeArquivo, extra=None, verify_hash=True)
fimMilis = time.time()
tempoMilis = fimMilis - iniMilis

sys.stdout.write(str(tempoMilis * 1000))

##### delete container #####
#obj = container.get_object(nomeArquivo)
#container.delete_object(obj)
#driver.delete_container(container)