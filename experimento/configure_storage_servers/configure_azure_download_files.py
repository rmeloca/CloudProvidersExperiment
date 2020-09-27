from libcloud.storage.types import Provider
from libcloud.storage.providers import get_driver

STORAGE_ACC_NAME = "experimento"
SECRET_KEY = "Bsm9hts00DsMXBnPPPCtk6c/JajtHqGDGyOufvEJ84AqU5CVUVy87Nt09Vz2sptq/7JiWblC5BBYp+QQMWG9dg=="

cls = get_driver(Provider.AZURE_BLOBS)
driver = cls(key=STORAGE_ACC_NAME, secret=SECRET_KEY)

CONTAINER_NAME = "downloadfilesconteiner"
driver.create_container(CONTAINER_NAME)
container = driver.get_container(container_name=CONTAINER_NAME)
## TODO - verificar aqui se o conteiner foi criado corretamente.

for i in ["155", "310", "620", "1240", "2480"]:
    for j in ["nativa-azure-java-", "nativa-azure-python-", "multicloud-azure-java-", "multicloud-azure-python-"]:
        container.upload_object(i, object_name= j + i, extra=None, verify_hash=True)

## TODO - verificar aqui se os arquivos foram realmente enviados
##container.download_object(obj, nomeArquivoDownload, overwrite_existing=True, delete_on_failure=True)



