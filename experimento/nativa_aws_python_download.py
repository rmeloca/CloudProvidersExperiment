from boto3.session import Session
import time
import sys

ACCESS_ID = "AKIAJ5TVZPWOSYKRW4FQ"
SECRET_KEY = "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"


bucketName = sys.argv[1]
nomeArquivo = sys.argv[2]
nomeArquivoDownload = "download"
tempoMilis = 0
iniMilis = 0
fimMilis = 0

session = Session(aws_access_key_id=ACCESS_ID,
                  aws_secret_access_key=SECRET_KEY)

s3 = session.resource("s3")
bucket = s3.Bucket(bucketName)

##### download container #####
iniMilis = time.time()
bucket.download_file(nomeArquivo, nomeArquivoDownload)
fimMilis = time.time()
tempoMilis = fimMilis - iniMilis

sys.stdout.write(str(tempoMilis * 1000))
