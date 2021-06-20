import pandas as pd
import boto3
from sqlalchemy import create_engine

# upload file to S3 bucket
s3 = boto3.client('s3')
bucket = 'my-bucket-storage-test'
fileName = 'weight-height.txt'
df = pd.read_csv(fileName)
# transform to excel file
fileName = 'weight-height.xlsx'
df.to_excel(fileName, 'Sheet1', index=False)
s3.upload_file(fileName, bucket, fileName)
print('Upload completed')

# read file from S3 bucket
path = 's3://my-bucket-storage-test/weight-height.xlsx'
data = pd.read_excel(path)
print(data)

# Credentials to database connection
hostname='database-1.c1hgka2potxp.us-east-1.rds.amazonaws.com'
dbname='db_profiling'
uname='admin'
pwd='eE123654'

engine = create_engine("mysql+pymysql://{user}:{pw}@{host}/{db}"
				.format(host=hostname, db=dbname, user=uname, pw=pwd))

# Convert dataframe to sql table
data.to_sql('tb_weight_height', engine, index=False)
