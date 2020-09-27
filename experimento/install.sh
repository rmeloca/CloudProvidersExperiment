#!/bin/bash

if [ "$(whoami)" != 'root' ]; then
    echo "You have no permission to run $0 as non-root user."
    exit 1;
fi

rm -f /experimento -R
mkdir /experimento
cp * /experimento -R
cd /experimento

######################## gerar arquivos ##############################
gcc gerarArquivos.c -o gerarArquivos
./gerarArquivos

cp 155 310 620 1240 2480 nativa_aws_java_download/src/main/java/arquivos/
cp 155 310 620 1240 2480 nativa_aws_java_upload/src/main/java/arquivos/
cp 155 310 620 1240 2480 nativa_azure_java_download/src/main/java/arquivos/
cp 155 310 620 1240 2480 nativa_azure_java_upload/src/main/java/arquivos/

cp 155 310 620 1240 2480 multicloud_aws_java_download/src/main/java/arquivos/
cp 155 310 620 1240 2480 multicloud_aws_java_upload/src/main/java/arquivos/
cp 155 310 620 1240 2480 multicloud_azure_java_download/src/main/java/arquivos/
cp 155 310 620 1240 2480 multicloud_azure_java_upload/src/main/java/arquivos/

######################## recompilar ##############################
cd nativa_aws_java_download/
mvn clean dependency:copy-dependencies package
cd ..

cd nativa_aws_java_upload/
mvn clean dependency:copy-dependencies package
cd ..

cd nativa_azure_java_download/
mvn clean dependency:copy-dependencies package
cd ..

cd nativa_azure_java_upload/
mvn clean dependency:copy-dependencies package
cd ..


cd multicloud_aws_java_download/
mvn clean dependency:copy-dependencies package
cd ..

cd multicloud_aws_java_upload/
mvn clean dependency:copy-dependencies package
cd ..

cd multicloud_azure_java_download/
mvn clean dependency:copy-dependencies package
cd ..

cd multicloud_azure_java_upload/
mvn clean dependency:copy-dependencies package
cd ..