#!/bin/bash

if [ "$(whoami)" != 'root' ]; then
    echo "You have no permission to run $0 as non-root user."
    exit 1;
fi

######################## C ##############################
apt-get install build-essential checkinstall -y

######################## python ##############################
apt-get install python-pip -y
#libcloud
pip install apache-libcloud
#aws
pip install boto3
#azure
pip install azure

######################## java ##############################
add-apt-repository ppa:webupd8team/java -y
apt-get update
apt-get install oracle-java8-installer -y
apt-get install maven -y

######################## unzip ##############################
apt-get install unzip -y

cd /home
rm -f /experimento -R
rm -f experimento -R
rm -f download.py
rm -f experimento.zip
touch download.py

echo "from libcloud.storage.types import Provider" >> download.py
echo "from libcloud.storage.providers import get_driver" >> download.py
echo "ACCESS_ID = \"AKIAJ5TVZPWOSYKRW4FQ\"" >> download.py
echo "SECRET_KEY = \"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\"" >> download.py
echo "cls = get_driver(Provider.S3_US_WEST)" >> download.py
echo "driver = cls(key=ACCESS_ID, secret=SECRET_KEY)" >> download.py
echo "bucket = driver.get_container(container_name=\"experimentofile\")" >> download.py
echo "obj = bucket.get_object(\"experimento.zip\")" >> download.py
echo "bucket.download_object(obj, \"experimento.zip\", overwrite_existing=True, delete_on_failure=True)" >> download.py

python download.py
unzip experimento.zip
cd experimento
sh install.sh