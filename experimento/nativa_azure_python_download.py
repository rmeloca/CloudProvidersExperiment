from azure.storage.blob import BlobService
import time
import sys

STORAGE_ACC_NAME = "experimento"
SECRET_KEY = "Bsm9hts00DsMXBnPPPCtk6c/JajtHqGDGyOufvEJ84AqU5CVUVy87Nt09Vz2sptq/7JiWblC5BBYp+QQMWG9dg=="


containerName = sys.argv[1]
nomeArquivo = sys.argv[2]
nomeArquivoDownload = "download"
tempoMilis = 0
iniMilis = 0
fimMilis = 0


blob_service = BlobService(STORAGE_ACC_NAME, SECRET_KEY)

##### download container #####
iniMilis = time.time()
blob = blob_service.get_blob_to_path(containerName, nomeArquivo, nomeArquivoDownload)
fimMilis = time.time()
tempoMilis = fimMilis - iniMilis

sys.stdout.write(str(tempoMilis * 1000))