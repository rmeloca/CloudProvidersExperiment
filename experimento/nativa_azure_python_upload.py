from azure.storage.blob import BlobService
import time
import sys

STORAGE_ACC_NAME = "experimento"
SECRET_KEY = "Bsm9hts00DsMXBnPPPCtk6c/JajtHqGDGyOufvEJ84AqU5CVUVy87Nt09Vz2sptq/7JiWblC5BBYp+QQMWG9dg=="


containerName = sys.argv[1]
nomeArquivo = sys.argv[2]
tempoMilis = 0
iniMilis = 0
fimMilis = 0


blob_service = BlobService(STORAGE_ACC_NAME, SECRET_KEY)

##### create container #####
#blob_service.create_container(container_name=containerName, x_ms_blob_public_access="blob")

##### upload container #####
iniMilis = time.time()
blob_service.put_block_blob_from_path(containerName, nomeArquivo, nomeArquivo)
fimMilis = time.time()
tempoMilis = fimMilis - iniMilis

sys.stdout.write(str(tempoMilis * 1000))

##### delete container #####
#blob_service.delete_container(container_name=containerName)