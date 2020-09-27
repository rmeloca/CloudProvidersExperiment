#!/bin/bash

if [ "$(whoami)" != 'root' ]; then
    echo "You have no permission to run $0 as non-root user."
    exit 1;
fi

cd /experimento/configure_storage_servers

cp ../gerarArquivos.c .

######################## gerar arquivos ##############################
gcc gerarArquivos.c -o gerarArquivos
./gerarArquivos

######################## AWS - criar conteiner para o download e copiar arquivos para dentro deste conteiner ##############################
python configure_aws_download_files.py

######################## AWS - criar conteineres para upload ##############################
python create_aws_upload_containers.py

######################## Azure - criar conteineres para upload ##############################
python create_azure_upload_containers.py

######################## Azure - criar conteiner para o download e copiar arquivos para dentro deste conteiner ##############################
python configure_azure_download_files.py