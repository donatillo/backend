from flask import Flask, request
from flask_cors import CORS, cross_origin
from flask_restful import Resource, Api
import socket

app = Flask(__name__)
api = Api(app)
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'

@app.route('/tokensignin')
@cross_origin()
def signin():
    return dict(request.headers)

class HelloWorld(Resource):
    def get(self):
        #return { 'hello': 'world' }
        return dict(request.headers)

api.add_resource(HelloWorld, '/')

class Version(Resource):
    def get(self):
        #return { 'hello': 'world' }
        return '0.1'

api.add_resource(Version, '/version')

class IP(Resource):
    def get(self):
        ips = []
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        try:
            s.connect(('10.255.255.255', 1))
            ips.append(s.getsockname()[0])
        except:
            ips.append('127.0.0.1')
        finally:
            s.close()
        return ips

api.add_resource(IP, '/ip')

if __name__ == '__main__':
    app.run(debug=True)
