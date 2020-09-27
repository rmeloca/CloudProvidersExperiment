#!/bin/bash

api=$1
plataforma=$2
linguagem=$3


if [ "$(whoami)" != 'root' ]; then
    echo "You have no permission to run $0 as non-root user."
    exit 1;
fi

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]; then
	echo "Usage: sh "$0" <api> <plataforma> <linguagem>"
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

if [ $linguagem != "python" ] && [ $linguagem != "java" ]; then
	echo "Argumento 3: python ou java"
	exit
fi

######################## cron ##############################
rm -f schedule.cron

cd /experimento

dia=1
while [ $dia -le 5 ];
do
	data=$(date -d "+$dia day" +"%d %m")
	fileSize=155

	#Upload
	echo "0 0 $data * /experimento/obterAmostra.sh $api $plataforma $linguagem upload $fileSize >> /experimento/log.log 2>&1" >> schedule.cron
	#Download
	echo "0 1 $data * /experimento/obterAmostra.sh $api $plataforma $linguagem download $fileSize >> /experimento/log.log 2>&1" >> schedule.cron

	fileSize=$(($fileSize*2))

	#Upload
	echo "0 2 $data * /experimento/obterAmostra.sh $api $plataforma $linguagem upload $fileSize >> /experimento/log.log 2>&1" >> schedule.cron
	#Download
	echo "30 3 $data * /experimento/obterAmostra.sh $api $plataforma $linguagem download $fileSize >> /experimento/log.log 2>&1" >> schedule.cron
	
	fileSize=$(($fileSize*2))

	#Upload
	echo "0 5 $data * /experimento/obterAmostra.sh $api $plataforma $linguagem upload $fileSize >> /experimento/log.log 2>&1" >> schedule.cron
	#Download
	echo "0 7 $data * /experimento/obterAmostra.sh $api $plataforma $linguagem download $fileSize >> /experimento/log.log 2>&1" >> schedule.cron
	
	fileSize=$(($fileSize*2))

	#Upload
	echo "0 9 $data * /experimento/obterAmostra.sh $api $plataforma $linguagem upload $fileSize >> /experimento/log.log 2>&1" >> schedule.cron
	#Download
	echo "30 11 $data * /experimento/obterAmostra.sh $api $plataforma $linguagem download $fileSize >> /experimento/log.log 2>&1" >> schedule.cron
	
	fileSize=$(($fileSize*2))

	#Upload
	echo "0 14 $data * /experimento/obterAmostra.sh $api $plataforma $linguagem upload $fileSize >> /experimento/log.log 2>&1" >> schedule.cron
	#Download
	echo "0 17 $data * /experimento/obterAmostra.sh $api $plataforma $linguagem download $fileSize >> /experimento/log.log 2>&1" >> schedule.cron
	
	fileSize=$(($fileSize*2))

	dia=$(($dia+1))
done

crontab schedule.cron