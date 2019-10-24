from flask import Flask, request, jsonify
from testlog import app, curr
from .doc import data_extract, get_count, get_tests
import sys


@app.route("/", methods=["GET"])
def get_data():
    data1 = data_extract()
    length = len(data1)
    return jsonify({"tests": length, "data": data1})


@app.route("/count", methods=["GET"])
def count_test():
    count = get_count()
    t_pass = count[0]
    t_fail = count[1]
    lst = count[2]
    criti = count[3]
    
    total = t_pass + t_fail
    return jsonify({"total": total, 'pass_tests': t_pass, 'fail_tests': t_fail, "list": lst, "critical": criti})


@app.route("/tests", methods=["GET"])
def tests():
    test = get_tests()
    print(test)
    return jsonify(test)




