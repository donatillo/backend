from flask import Flask, request
from flask_cors import CORS, cross_origin
from flask_restful import Resource, Api
import socket

app = Flask(__name__)
api = Api(app)
cors = CORS(app, resources={r"/*": {"origins": ["http://localhost:3000"]}})
app.config['CORS_HEADERS'] = 'Content-Type'

class SignIn(Resource):
    def post(self):
        return 'ok'

api.add_resource(SignIn, '/tokensignin')

if __name__ == '__main__':
    app.run(debug=True)
