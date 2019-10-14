import sys
#import time
from flask import Flask
from flask_cors import CORS
from flask_restful import Api
from flask_pymongo import PyMongo

app = Flask(__name__)
api = Api(app)
CORS(app)
app.config['SECRET_KEY'] = '5791628bb0b13ce0c676dfde280ba245'
app.config['MONGO_DBNAME'] = 'kbpatil'
app.config['MONGO_URI'] = 'mongodb://localhost:27017/kbpatil'

mongo = PyMongo(app)
curr = mongo.db.testlog


from testlog import testapi

