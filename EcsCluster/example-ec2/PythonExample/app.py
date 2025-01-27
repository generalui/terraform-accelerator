from os import getenv
import json
import logging
from flask import Flask
from flask_restful import Resource, Api

LOG_PREFIX = 'Example-Python-ECS-EC2'

logging.basicConfig(
    level=logging.INFO,
    # dont need timing
    format=json.dumps({'level': '%(levelname)s', 'prefix': LOG_PREFIX, 'message': '%(message)s'})
)
logger = logging.getLogger()

app = Flask(__name__)
api = Api(app)
# Load environment variables
env_var = getenv('TEST')

class HelloWorld(Resource):
    def get(self):
        message = 'Hello World!'
        logger.info('%s: %s', LOG_PREFIX, message)
        logger.info('%s: Environment Variable value = %s', LOG_PREFIX, env_var)
        return message

api.add_resource(HelloWorld, '/')

if __name__ == '__main__':
    logger.info('%s: Starting', LOG_PREFIX)
    app.run(host='0.0.0.0')

