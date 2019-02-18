import boto3
import logging

# initialize logging
logging.basicConfig(
    format='%(asctime)s %(message)s', datefmt='%Y-%m-%d %H:%M:%S',
    level=logging.INFO
)

# initialize boto3
ssm = boto3.client('ssm')

# load parameters
try:
    ssl_fullchain = ssm.get_parameter(Name='ssl_fullchain', WithDecryption=True)['Parameter']['Value']
    ssl_privkey   = ssm.get_parameter(Name='ssl_privkey', WithDecryption=True)['Parameter']['Value']
    logging.info('SSL parameters loaded.')
except ssm.exceptions.ParameterNotFound:
    logging.error('SSL credential parameters not found. Bailing out...')

# create certificate files
f = open('/etc/fullchain.pem', 'w')
f.write(ssl_fullchain)
f.close()

f = open('/etc/privkey.pem', 'w')
f.write(ssl_privkey)
f.close()
logging.info('SSL files written.')
