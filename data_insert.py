import datetime
import glob
import json
import sys
import time
import xmltodict
import os
from testlog import curr
x = datetime.datetime.now().strftime("%d/%m/%y")

def insert(root):
    try:
        list_of_files = glob.glob(root + '/*.xml')
        data = max(list_of_files, key=os.path.getctime)
        print(data)
        fxml = open(data, 'r')
        xml_data = fxml.read()
        fxml.close()
        temp_data = xmltodict.parse(xml_data)
        data = json.dumps(temp_data)
        output = json.loads(data)
        time_1 = output["robot"]["suite"]["status"]["@starttime"]
        test_data = curr.find({"date": x})
        l1 = [i['data'] for i in test_data]
        if len(l1) == 0:
            curr.insert({"date": x, "data": output})
            print("data inserted for null")
        else:
            time_2 = []
            for j in l1:
                time_2.append(j["robot"]["suite"]["status"]["@starttime"])
            if time_1 not in time_2:
                curr.insert({"date": x, "data": output})
                print("data inserted")
            else:
                print("data already exist")

    except Exception as e:
        print(e)


while 1:
    insert(sys.argv[1])
    time.sleep(2*60)
