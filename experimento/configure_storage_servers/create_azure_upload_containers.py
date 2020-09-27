from libcloud.storage.types import Provider
from libcloud.storage.providers import get_driver

STORAGE_ACC_NAME = "experimento"
SECRET_KEY = "Bsm9hts00DsMXBnPPPCtk6c/JajtHqGDGyOufvEJ84AqU5CVUVy87Nt09Vz2sptq/7JiWblC5BBYp+QQMWG9dg=="

cls = get_driver(Provider.AZURE_BLOBS)
driver = cls(key=STORAGE_ACC_NAME, secret=SECRET_KEY)

##### create containers to receive uploads #####
for api in ["nativa", "multicloud"]:
    for linguagem in ["java", "python"]:
        for fileSize in ["155", "310", "620", "1240", "2480"]:
            containerName = api + "-azure-" + linguagem + "-upload-" + fileSize
            driver.create_container(containerName)
            bucket = driver.get_container(container_name=containerName)
            ### TODO verificar aqui se o conteiner foi corretamente criado