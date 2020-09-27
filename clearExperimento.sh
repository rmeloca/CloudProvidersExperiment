#!/bin/bash

if [ "$(whoami)" != 'root' ]; then
    echo "You have no permission to run $0 as non-root user."
    exit 1;
fi

cd experimento
######################## deletar arquivos ##############################
find -iname '155' -exec rm {} \;
find -iname '310' -exec rm {} \;
find -iname '620' -exec rm {} \;
find -iname '1240' -exec rm {} \;
find -iname '2480' -exec rm {} \;
find -iname 'gerarArquivos' -exec rm {} \;

######################## clean ##############################
cd nativa_aws_java_download/
mvn clean
cd ..

cd nativa_aws_java_upload/
mvn clean
cd ..

cd nativa_azure_java_download/
mvn clean
cd ..

cd nativa_azure_java_upload/
mvn clean
cd ..


cd multicloud_aws_java_download/
mvn clean
cd ..

cd multicloud_aws_java_upload/
mvn clean
cd ..

cd multicloud_azure_java_download/
mvn clean
cd ..

cd multicloud_azure_java_upload/
mvn clean
cd ..