from flask import Flask
from flask_cors import CORS, cross_origin
from flask_restful import Api
from donatillo.resources.user import User

app = Flask(__name__, instance_relative_config=True)
api = Api(app)
cors = CORS(app, resources={r"/*": {"origins": ["http://localhost:3000"]}})
app.config['CORS_HEADERS'] = 'Content-Type'

app.config.from_pyfile('config.py', silent=True)

api.add_resource(User, '/user')# , '/user/<str:id>')
