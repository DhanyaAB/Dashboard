import json,re,os
import requests
from requests.packages.urllib3.exceptions import InsecureRequestWarning
requests.packages.urllib3.disable_warnings(InsecureRequestWarning)

def END_POINTS(data, ids):
    end_point = re.sub('host_id', ids, data)
    return end_point

def apitest(server_ip, url_node, data, token):
    obj = API_TEST(server_ip, url_node, data, token)
    return obj


class API_TEST:

    def __init__(self, server_ip, url_node, data, token):
        self.base_url = 'https://' + server_ip + ':5000/services/api/v0'
        self.url_node = url_node
        self.data = data
        self.token = token

    def test_connection(self):
        jsondata = {'status': 'Failed'}
        headers = {"Content-Type": "application/json", "x-access-token":self.token}
        req = requests.post(self.base_url + self.url_node, headers=headers, data=json.dumps(self.data), verify=False)
        if req.status_code == 400:
            req = requests.post(self.base_url + self.url_node, headers=headers, data=self.data, verify=False)
        if req.status_code == 200:
            print('connection successful')
            try:
                jsondata = json.loads(req.text)
            except Exception:
                jsondata = {'status': 'success'}
        else:
            jsondata['message'] = 'API connection failed, Error code = ' + str(req.status_code)

        return jsondata

    def get_connection(self):
        jsondata = {'status': 'Failed'}
        headers = {"Content-Type": "application/json", "x-access-token":self.token}
        req = requests.get(self.base_url + self.url_node, headers=headers, data=json.dumps(self.data), verify=False)
        if req.status_code == 200:
            print('connection successful')
            jsondata = json.loads(req.text)
        else:
            jsondata['message'] = 'API connection failed, Error code = ' + str(req.status_code)
        return jsondata

    def ioc_pack(self):
        jsondata = {'status': 'Failed'}
        headers = {"x-access-token": self.token}
        req = requests.post(self.base_url + self.url_node, headers=headers, files=self.data, verify=False)
        if req.status_code == 200:
            print('connection successful')
            jsondata = json.loads(req.text)
        else:
            jsondata['message'] = 'API connection failed, Error code = ' + str(req.status_code)
        return jsondata

    def hunt(self):
        jsondata = {'status': 'Failed'}
        headers = {"x-access-token": self.token}
        req = requests.post(self.base_url + self.url_node, headers=headers, files=self.data, data=self.data, verify=False)
        if req.status_code == 200:
            print('connection successful')
            jsondata = json.loads(req.text)
        else:
            jsondata['message'] = 'API connection failed, Error code = ' + str(req.status_code)
        return jsondata

def rules_validation(server_ip, token):
    jsondata = {'status': 'Failed'}
    headers = {"Content-Type": "application/json", "x-access-token": token}
    req = requests.get('https://' + server_ip + ':5000/services/api/v0/rules', headers=headers, verify=False)
    if req.status_code == 200:
        print('connection successful')
        jsondata = json.loads(req.text)
    else:
        jsondata['message'] = 'API connection failed, Error code = ' + str(req.status_code)
        return jsondata
    rule_list = []

    for rule_name in jsondata["data"]:
        rule_list.append(rule_name["name"])

    WORKSPACE=os.getenv('WORKSPACE')
    fout = open(WORKSPACE+'/branch/default_rules', 'r')
    data = fout.readlines()
    default_rule=[]

    for rule_name in data:
        rule_name = rule_name.strip('\n')
        default_rule.append(rule_name)
        if rule_name in rule_list:
            continue
        else:
            # print(rule_name)
            json_data = {'status': 'Failed','message':rule_name +' Rule is not present','data':rule_list}
            return json_data

    for rule_name in rule_list:
        if rule_name in default_rule:
            continue
        else:
            # print(rule_name)
            Result = {'status': 'Failed','message':rule_name +' Rule is not present','data':default_rule}
            return Result
    Result = {'status': 'success','data': rule_list}
    return Result

def Validate_Element(response,val_key):
    for data in response['data']:
        if val_key in data.keys():
            return True
        elif val_key in data.values():
            return True
    return False

if __name__ == '__main__':
	print("hi")
















		
