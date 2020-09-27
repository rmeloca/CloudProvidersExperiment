#!/bin/bash

api=$1
plataforma=$2
linguagem=$3
acao=$4
fileSize=$5


if [ "$(whoami)" != 'root' ]; then
    echo "You have no permission to run $0 as non-root user."
    exit 1;
fi

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ] || [ -z $4 ] || [ -z $5 ]; then
	echo "Usage: sh "$0" <api> <plataforma> <linguagem> <acao> <fileSize>"
   exit
fi

if [ $api != "nativa" ] && [ $api != "multicloud" ]; then
	echo "Argumento 1: nativa ou multicloud"
	exit
fi

if [ $plataforma != "aws" ] && [ $plataforma != "azure" ]; then
	echo "Argumento 2: aws ou azure"
	exit
fi

if [ $linguagem != "java" ] && [ $linguagem != "python" ]; then
	echo "Argumento 3: java ou python"
	exit
fi

if [ $acao != "upload" ] && [ $acao != "download" ]; then
	echo "Argumento 4: upload ou download"
	exit
fi

if [ $fileSize != "155" ] && [ $fileSize != "310" ] && [ $fileSize != "620" ] && [ $fileSize != "1240" ] && [ $fileSize != "2480" ]; then
	echo "Argumento 5: 155, 310, 620, 1240 ou 2480"
	exit
fi

if [ $acao = "download" ]; then
	containerName="downloadfilesconteiner"
	nomeArquivo="$api-$plataforma-$linguagem-"$fileSize
else
	containerName="$api-$plataforma-$linguagem-$acao-$fileSize"
	nomeArquivo=$(($fileSize))
fi

cd /experimento

i=1
tempo=0
cpu=0
ram=0
echo "*******************************************"
echo "$api_$plataforma_$linguagem_$acao_$fileSize"
echo "*******************************************"
echo "nomeArquivo"
echo "$nomeArquivo"
echo "containerName"
echo "$containerName"
while [ $i -le 100 ];
do
	echo "------------------"
	echo "Obtendo amostra $i"
	echo $(date +"%d-%m-%Y %T")
	
	if [ $linguagem = "java" ]; then
		#Java
		cd $api"_"$plataforma"_"$linguagem"_"$acao"/target"
		/usr/bin/time -f "\n%M\n%S + %U" -o "../../temp.temp" -a java -jar $api"_"$plataforma"_"$linguagem"_"$acao"-1.0-SNAPSHOT".jar $containerName $nomeArquivo > ../../temp.temp
		cd ../..
    else
		#Python
		/usr/bin/time -f "\n%M\n%S + %U" -o "temp.temp" -a python $api"_"$plataforma"_"$linguagem"_"$acao".py" $containerName $nomeArquivo > temp.temp
    fi

    latencia=$(sed -n '1p' < temp.temp)
	memoria=$(sed -n '2p' < temp.temp)
	cpu=$(sed -n '3p' < temp.temp | bc)

	curl --data "platform=$plataforma&api=$api&language=$linguagem&activity=$acao&filesize=$fileSize&latency=$latencia&memory=$memoria&cputime=0$cpu" http://ec2-52-90-58-206.compute-1.amazonaws.com:8080/ExperimentDataRecord/rest/record
	
	echo "latencia"
	echo "$latencia"
	echo "memoria"
	echo "$memoria"
	echo "cpu"
	echo "$cpu"

	i=$(($i+1))
done
