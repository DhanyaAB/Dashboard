import requests
import json
import sys
import re
from requests.packages.urllib3.exceptions import InsecureRequestWarning
requests.packages.urllib3.disable_warnings(InsecureRequestWarning)


def call_API(base_url, endpoint,token):
	obj = Connect_API(base_url, endpoint,token)
	return obj

def get_url(ip):
    base_url = "https://"+ip+":5000/services/api/v0"
    return base_url

def get_host_id(json_data):
	host_ubuntu_ids = []
	host_windows_ids=[]
	host_id={}
	json_data=json_data['data']
	for data in json_data:
		for key_name in data:
			if key_name=='node_info':
				key_name=data[key_name]
				if re.search('ip',key_name['computer_name']):
					host_ubuntu_ids.append(data['host_identifier'])
				else:
					host_windows_ids.append(data['host_identifier'])
	host_id['ubuntu']=host_ubuntu_ids
	host_id['windows']=host_windows_ids
	return host_id

def get_id(json_data):
     for data in json_data:
        if data == 'command_id':
            return str(json_data[data])
        elif data=='rule_id':
            return str(json_data[data])

def get_hostname(json_data):
    host_names = []
    json_data=json_data['data']
    for data in json_data:
        for node_info in data:
            if node_info == 'node_info':
                for host_name in data[node_info]:
                    if host_name == 'computer_name':
                        host_names.append(data[node_info][host_name])
    return host_names

def get_config_id(json_data):
    for data in json_data:
        if data == 'config_id':
            return str(json_data[data])



def get_endpoint(endpoint, Id=None):
    if Id == None:
        return endpoint
    else:
        return endpoint+'/'+Id

def get_token(server_ip):
	data={"username":"admin",
		"password":"admin"}
	r=requests.post("https://"+server_ip+":5000/services/api/v0/login",data=json.dumps(data), verify=False)
	token=json.loads(r.text)
	return token["token"]


class Connect_API:
    def __init__(self, base_url, endpoint, token):
        self.base_url = base_url
        self.endpoint = '/' + endpoint
        self.token = token

    def connect_API(self):
        jsondata = {'status': 'Failed'}
        headers = {"x-access-token": self.token}
        url = self.base_url + self.endpoint
        r = requests.get(url, headers=headers, verify=False)
        if r.status_code == 200:
            try:
                jsondata = json.loads(r.text)
            except Exception:
                jsondata = {'status': 'success'}
        else:
            jsondata['message'] = 'API connection failed, Error code = ' + str(r.status_code)

        return jsondata








'''if  __name__ == '__main__':
	n=len(sys.argv)
	if n != 2:
		print("please provide file name")
		sys.exit(1)
	endpoint = (sys.argv[1])
	base_url = "https://13.232.45.179:5000/services/api/v0"
	token=get_token('13.232.45.179')
        obj=Connect_API(base_url,endpoint,token)
	data=obj.connect_API()
	L=get_host_id(data)
	print get_hostname(data)
	print L'''
