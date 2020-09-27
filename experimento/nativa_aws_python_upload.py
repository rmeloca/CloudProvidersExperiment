from boto3.session import Session
import time
import sys

ACCESS_ID = "AKIAJ5TVZPWOSYKRW4FQ"
SECRET_KEY = "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"


bucketName = sys.argv[1]
nomeArquivo = sys.argv[2]
tempoMilis = 0
iniMilis = 0
fimMilis = 0

session = Session(aws_access_key_id=ACCESS_ID,
                  aws_secret_access_key=SECRET_KEY)

s3 = session.resource("s3")

####### create bucket #######
#s3.create_bucket(Bucket=bucketName, CreateBucketConfiguration={'LocationConstraint': 'EU'})
bucket = s3.Bucket(bucketName)

####### upload object #######
iniMilis = time.time()
data = open(nomeArquivo, "rb")
bucket.put_object(Key=nomeArquivo, Body=data)
fimMilis = time.time()
tempoMilis = fimMilis - iniMilis

sys.stdout.write(str(tempoMilis * 1000))

####### delete bucket #######
#bucket = s3.Bucket(bucketName)
#response = bucket.delete_objects(Delete={'Objects': [{'Key': nomeArquivo}]})
#bucket.delete()
