from flask_restful import Resource, Api

class User(Resource):
    def get(self):
        return 'hello'
