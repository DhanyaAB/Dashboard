import re

def Create_a_new_config():
    data = {
"name": "Config-add",
"config": {
"schedule": {
"win_file_events": {
"query": "select * from win_file_events;",
"interval": 10,
"description": "win file events"
}
},
"win_include_paths": {
"user_folders": [
"C:\\Users\\*\\Downloads\\"
]
},
"win_exclude_paths": {
"temp_folders": [
"C:\\Users\\*\\Downloads\\exclude\\"
]
}
}
}
    return data


def Updating_a_config():
    data = {
"config": {
"schedule": {
"processes": {
"description": "program",
"interval": 10,
"query": "select * from processes;"
}
},
"win_exclude_paths": {
"temp_folders": [
"C:\\Users\\*\\Downloads\\exclude\\"
]
},
"win_include_paths": {
"user_folders": [
"C:\\Users\\*\\Downloads\\"
]
}
},
"name": "poly-confignew"
}
    return data

def Assign_a_Config_to_a_node(host_id):
    data = {
"host_identifier": host_id,
"config_id": 1,
}
    return data


def Remove_a_Config_from_a_node(host_id):
    data = {
"host_identifier": host_id
}
    return data

# Scheduled Queries

def Scheduled_Query_Results_for_an_Endpoint_Node(host_id):
    data = {
"host_identifier": host_id,
"query_name": "win_file_events",
"start": 0,
"limit": 100
}
    return data

#Distributed (Ad-Hoc) Queries

def Add_a_Distributed_Query(host_id):
    data = {
"query": "select * from system_info;",
"tags": [
""
],
"nodes": [host_id]
}
    return data


def Add_a_query():
    data = {
"name": "new_process_query",
"query": "select * from processes;",
"interval": 5,
"platform": "all",
"version": "2.9.0",
"description": "Processes",
"value": "Processes"
,
"tags":["Test1","Test2"]
}
    return data


def Upload_a_pack():
    data = {
"name": "process_query_pack",
"queries": {
"win_file_events": {
"query": "select * from processes;",
"interval": 5,
"platform": "windows",
"version": "2.9.0",
"description": "Processes",
"value": "Processes"
}
},
"tags":["Test1","Test2"]
}
    return data


def Add_new_tags():
    data = {
"tags":["Test1","Test2"]
}
    return data

def Modify_tags_on_a_node(host_id):
    data = {
"host_identifier":host_id,
"add_tags":["Test2","sales"],
"remove_tags":["Test2"]
}
    return data

def Modify_tags_on_a_query():
    data = {
"query_id":1,
"add_tags":["Test1","Test2"],
"remove_tags":["Test2"]
}
    return data

def Modify_tags_on_a_pack():
    data ={
"pack_id":1,
"add_tags":["Test2","sales"],
"remove_tags":["Test2"]
}
    return data

def Add_a_rule():
    data = {
"alerters": [
"email","splunk"
],
"name":"Adult website test_1",
"description":"Rule for finding adult websites",
"conditions": {
"condition": "AND",
"rules": [
{
"id": "column",
"type": "string",
"field": "column",
"input": "text",
"value": [
"issuer_name",
"Polylogyx.com(Test)"
],
"operator": "column_contains"
}
],
"valid": True
}
}
    return data

def Modify_rule():
    data = {
"alerters": [
"email",
"debug"
],
"conditions": {
"condition": "AND",
"rules": [
{
"field": "column",
"id": "column",
"input": "text",
"operator": "column_contains",
"type": "string",
"value": [
"domain_names",
"89.com"
]
}
],
"valid": True
},
"description": "Adult websites test",
"name": "Adult websites test_1",
"status": "ACTIVE"
}
    return data

def Alerts(host_id):
    data = {
"host_identifier": host_id
}
    return data

def Configure_email_sender_and_recipients_for_alerts():
    data={
"emailRecipients": ["mehtamouli1k@gmail.com", "moulik1@polylogyx.com" ],
"email": "mehtamoulik13@gmail.com",
"smtpAddress": "smtp2.gmail.com",
"password": "a",
"smtpPort": 445
}
    return data

#Response
def Response_add(host_names):
    for host_name in host_names:
        if not re.search('.*ip',host_name):
            name=host_name
            break

    data = {
"action": "delete",
"actuator": {
"endpoint": "polylogyx_vasp"
},
"target": {
"file": {
"device": {
"hostname":name
},
"hashes": {},
"name": "C:\\Users\\Administrator\\Desktop\\Malware.txt"
}
}
}
    return data

def Kill_Process_on_Endpoint(host_names,pid):
    for host_name in host_names:
        if not re.search('.*ip',host_name):
            name=host_name
            break

    data = {
"action": "stop",
"target": {
"process": {
"name": "cmd.exe",
"pid": pid,
"device": {
"hostname":name
}
}
},
"actuator": {
"endpoint": "polylogyx_vasp"
}
}
    return data

def Carves(host_id):
    data = {
"host_identifier": host_id,
}
    return data


################(new API JSON DATA)

def Change_User_Password():  # /changepw
    data = {
        "old_password": "admin",
        "new_password": "admin",
        "confirm_new_password": "admin"
    }
    return data


def Update_API_keys():  # /apikeys
    data = {
        "IBMxForceKey": "304020f8-99fd-4a17-9e72-80033278810a",
        "IBMxForcePass": "6710f119-9966-4d94-a7ad-9f98e62373c8",
        "vt_key": "69f922502ee0ea958fa0ead2979257bd084fa012c283ef9540176ce857ac6f2c"
    }
    return data


def Update_the_options():  # /options/add
    data = {
        "option": {
            "custom_plgx_EnableLogging": "true",
            "custom_plgx_LogFileName": "C:\\ProgramData\\plgx_win_extension\\plgx-agent.log",
            "custom_plgx_LogLevel": "1",
            "custom_plgx_LogModeQuiet": "0",
            "custom_plgx_ServerPort": "443",
            "custom_plgx_enable_respserver": "true",
            "schedule_splay_percent": 10
        }
    }
    return data


def Delete_query_result_for_some_recent_days():  # /queryresult/delete
    data = {
        "days_of_data": 2
    }
    return data


def Export_schedule_query_results_into_csv_file(host_id):  # /schedule_query/export
    data = {
        "query_name": "new_process_query",
        "host_identifier": host_id
    }
    return data


def Assign_Node_Configuration_through_config_id_for_a_specific_node(config_id,host_id):  # /nodes/config/assign
    data = {
        "config_id": config_id,
        "host_identifier": host_id
    }
    return data


def Remove_All_The_Configuration_of_a_Node_through_host_identifier(host_id):  # /nodes/config/remove
    data = {
        "host_identifier": host_id
    }
    return data


def Create_Tags_To_a_Node():  # /nodes/<string:host_identifier>/tags
    data = {
        "tags": ["Test1", "Test2"]
    }
    return data


def Get_Query_Results_of_a_Node():  # /nodes/<string:host_identifier>/queryResult
    data = {
        "start": 1,
        "length": 100,
        "search[value]": "5ad7fff3-cef4-4d"
    }
    return data


def Get_Activity_Results_of_a_Node():  # /nodes/<string:host_identifier>/activity
    data = {
        "timestamp": "2019-06-2710:58:41.57649"
    }
    return data


def Add_Tags_to_a_Query():  # /queries/<int:query_id>/tags
    data = {
        "tags": ["Test1", "Test2"]
    }
    return data


def Add_tags_to_A_Pack():  # /packs/<string:pack_name>/tags
    data = {
        "tags": ["Test1", "Test2"]
    }
    return data


def Search_Export_To_CSV_File(host_id):  # /nodes/search/export
    data = { 
"conditions":{ "condition": "OR", 
"rules": [ { 
"id": "name", "field": "name", "type": "string", "input": "text", "operator": "contains", "value": "EC2" 
}, { "id": "name", "field": "name", "type": "string", "input": "text", "operator": "equal", "value": "pc" } ], 
"valid": "true" }, 
"host_identifier": host_id 
}
    return data

import json

def Add_IOC_files():  # /iocs/add
    data={
  "data": {
    "test-intel_domain_name": {
      "values": [
        "unknown.com",
        "slackabc.com",
        ".www.amazon.in"
      ],
      "type": "domain_name",
      "severity": "WARNING"
    },
    "test-intel_ipv4": {
      "values": [
        "3.30.1.15",
        "3.30.1.16",
        "104.80.89.42"
      ],
      "type": "remote_address",
      "severity": "WARNING"
    },
    "test-intel_md5": {
      "values": [
        "3h8dk0sksm0",
        "9sd772ndd80",
        "44d88612fea8a8f36de82e1278abb02f"
      ],
      "type": "md5",
      "severity": "INFO1"
    }
  }
}
    fout=open("test_ioc.json","w")
    fout.write(json.dumps(data))
    fout.close()
    data = {
        "file": open("test_ioc.json","rb")
    }
    return data


def Hunt_file_upload():  # /hunt-upload
    data = '''0d19266c09d4deac5836e572be912a39
7fb8adb9d0401b4b5dbbc400194e7b48
44d88612fea8a8f36de82e1278abb02f
69630e4574ec6798239b091cda43dca0
0a41b96695fc5782b5c46d86042f964a
44d88612fea8a8f36de82e1278abb02f
3208ea1bb78ca077a8f9bff22fe89614
b3215c06647bc550406a9c8ccc378756
44d88612fea8a8f36de82e1278abb02f
44d88612fea8a8f36de82e1278abb02f
d41d8cd98f00b204e9800998ecf8427e
44d88612fea8a8f36de82e1278abb02f
44D88612FEA8A8F36DE82E1278ABB02F
7891341e2116e5bf3490f4049d4a41c4
44d88612fea8a8f36de82e1278abb02f'''
    fout = open("md5", "w")
    fout.write(data)
    fout.close()
    data = {
        "file": open("md5", "rb"),
        "type": "md5"
    }
    return data

def Add_packs_through_file_upload():  # /packs/upload
    json_data ={
"name": "process_query_pack",
"queries": {
"win_file_events": {
"query": "select * from processes;",
"interval": 5,
"platform": "windows",
"version": "2.9.0",
"description": "Processes",
"value": "Processes"
}
},
"tags":["finance","sales"]
}

    fout=open("pack.json","w")
    json.dump(json_data, fout)
    fout.close()
    data = {
      "file": open("pack.json","rb"),
     }
    return data

def Search_for_data_in_result_log_database_table(host_id):
    data ={
"conditions":{
"condition": "OR",
"rules": [{
"id": "name",
"field": "md5",
"type": "string",
"input": "text",
"operator": "contains",
"value": "44d88612fea8a8f36de82e1278abb02f"
}
],
"valid": True
},
"host_identifier":host_id,
"query_name":"win_file_events",
"start":1,
"limit":2
}
    return data

#
#
# def Add_YARA_files():  # /yara/add
#     data = {
#         "file": "a file object here"
#     }
#     return data



