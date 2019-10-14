import datetime
from testlog import curr

x = datetime.datetime.now().strftime("%Y%m%d")

#y = datetime.datetime.now().strftime(":%H:%M:%S")
#dir = sys.argv[1]


'''def data_insert(root):
    print(root)
    try:
        list_of_files = glob.glob(root + '/*.xml')
        data = max(list_of_files, key=os.path.getctime)
        print(data)
        fxml = open(data,'r')
        xml_data = fxml.read()
        fxml.close()
        #os.remove(data)
        temp_data = xmltodict.parse(xml_data)
        data = json.dumps(temp_data)
        output = json.loads(data)
        test_data = curr.find_one({"data": output})
        if test_data is not None:
            pass
        else:
            curr.insert({"date": x, "data": output})
        
    except Exception as e:
        print(e)
        #sys.exit(1)'''


def data_extract():
    output1 = curr.find({"date": x})
    l1 = [i['data'] for i in output1]
    print(len(l1))
    return l1


def get_count():
    c_pass = 0
    c_fail = 0
    c_criti = 0
    test_count = []
    output1 = curr.find({"date": x})
    l1 = [i['data'] for i in output1]
    for i in l1:
        name = i['robot']['suite']['@name']
        data2 = i['robot']['statistics']['suite']['stat']
        c_pass += int(data2['@pass'])
        c_fail += int(data2['@fail'])
        data = i['robot']['suite']['test']
        count = 0
        for k in data:
            #print(type(data))
            if type(data)==dict:
                if data['status']['@critical'] == "yes":
                    count = count + 1
            elif type(data)==list:
                if data[0]['status']['@critical'] == "yes":
                    count = count + 1
        c_criti += count
        data3 = i["robot"]["suite"]["status"]
        s_time = data3["@starttime"]
        e_time = data3["@endtime"]
        test_count.extend([{"pass": int(data2['@pass']), "fail": int(data2['@fail']), "s_time": s_time,
                            "e_time": e_time, "critical": count, "name":name}])

    return c_pass, c_fail, test_count, c_criti


def get_tests():
    test_cases = []
    output1 = curr.find({"date": x})
    l1 = [i['data'] for i in output1]
    for i in l1:
        name = i['robot']['suite']['@name']
        data = i['robot']['suite']['test']
        p_test = []
        f_test = []
        for j in range(len(data)):
            if (data[j]['status']['@status']).lower() == "pass":
                if data[j] not in p_test:
                    p_test.append(data[j])
            else:
                if data[j] not in f_test:
                    f_test.append(data[j])

        test_cases.extend([{'test_name': name, "pass_tests": p_test, "fail_tests": f_test}])
    return test_cases


if "__name__" == "__main__":
    data_extract()
    get_count()
    get_tests()




