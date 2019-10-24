*** Settings ***
Library  Collections

Library  /var/lib/jenkins/workspace/dashboard/Poly_api_get.py
Library  /var/lib/jenkins/workspace/dashboard/json_post_data.py
Library  /var/lib/jenkins/workspace/dashboard/node_connect.py



*** Variables ***
${status}   success
${server_ip}   13.127.198.209
*** Test Cases ***


Get the Base URL for API Connect
   [Documentation]  Gets the base url of server
   [Tags]  REST API Base URL
   ${base_url}=  get_url  ${server_ip}
   Set Global Variable  ${base_url}

Get the x-tocken for API connection
   [Documentation]  Gets the API token
   [Tags]  REST API token
   ${token}=  get_token  ${server_ip}
   log  ${token}
   Set Global Variable  ${token}

Get API Responses of Endpoint /nodes
   [Documentation]  Connects to the API and gets the responses of endpoint /nodes
   [Tags]  REST API GET Responses
   ${endpoint}=  get_endpoint  nodes
   ${Result}=  CONNECT API  ${base_url}  ${endpoint} 
   ${Host_id}=  get_host_id  ${Result}
   Log  ${Host_id}
   Set Global Variable  ${Host_id}
   ${host_Name}=  get_hostname  ${Result}
   Log  ${host_Name}
   Set Global Variable  ${host_Name}
   Log  ${Result}
   Should Be Equal  success  ${Result['status']}
   Should Not Be Empty ${Result['data'][0]['node_info']}

Get API Responses of POST Type of Endpoint /apikeys
    [Documentation]  Connects to the API posts the required data and gets the responses of /apikeys
    [Tags]  REST API POST Responses
    ${data}=   Update_API_keys
    ${result}=  CONNECT API POST  /apikeys  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}
    Should Not Be Empty  ${result['data']}
    Dictionary Should Contain Value  ${result['data']['ibmxforce']}  ${data['IBMxForceKey']}

Get API Responses of Endpoint /apikeys
   [Documentation]  Connects to the API and gets the responses of endpoint /apikeys
   [Tags]  REST API GET Responses
   ${data}=   Update_API_keys
   ${endpoint}=  get_endpoint  apikeys
   ${Result}=  CONNECT API  ${base_url}  ${endpoint}
   Log  ${Result}
   Should Be Equal  success  ${Result['status']}
   Should Not Be Empty  ${result['data']}
   Dictionary Should Contain Value  ${result['data']['ibmxforce']}  ${data['IBMxForceKey']}

Get API Responses of Endpoint /nodes/<host_identifier>
   [Documentation]  Connects to the API and gets the responses of endpoint /nodes/<host_identifier>
   [Tags]  REST API GET Responses
   ${endpoint}=  get_endpoint  nodes  ${Host_id['ubuntu']}[0]
   ${Result}=  CONNECT API  ${base_url}  ${endpoint}
   Log  ${Result}
   Should Be Equal  success  ${Result['status']}
   Should Not Be Empty  ${result['data']}
   Should Not Be Empty   ${Result['data']['host_identifier']}

Get API Responses of POST Type of Endpoint /nodes/<string:host_identifier>/tags
    [Documentation]  Connects to the API posts the required data and gets the responses of /nodes/<string:host_identifier>/tags
    [Tags]  REST API POST Responses
    ${end_point}=  END_POINTS  /nodes/host_id/tags  ${Host_id['windows']}[0]
    ${data}=  Create_Tags_To_a_Node
    ${result}=  CONNECT API POST  ${end_point}  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}

Get API Responses of POST Type of Endpoint /nodes/<string:host_identifier>/activity
    [Documentation]  Connects to the API posts the required data and gets the responses of /nodes/<string:host_identifier>/activity
    [Tags]  REST API POST Responses
    ${end_point}=  END_POINTS  /nodes/host_id/activity  ${Host_id['windows']}[0]
    Log  ${end_point}
    ${data}=  Get_Activity_Results_of_a_Node
    ${result}=  CONNECT API POST  ${end_point}  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}
    Should Not Be Empty  ${result['data']}
    Should Not Be Empty  ${result['data']['queries_packs']}

Get API Responses of Endpoint /nodes/<string:host_identifier>/tags
   [Documentation]  Connects to the API and gets the responses of endpoint /nodes/<string:host_identifier>/tags
   [Tags]  REST API GET Responses
   ${end_point}=  END_POINTS  nodes/host_id/tags  ${Host_id['windows']}[0]
   ${endpoint}=  get_endpoint  ${end_point}
   Log  ${end_point}
   ${Result}=  CONNECT API  ${base_url}  ${endpoint}
   Log  ${Result}
   Should Be Equal  success  ${Result['status']}
   Should Not Be Empty  ${result['data']}


Get API Responses of Endpoint /schema
   [Documentation]  Connects to the API and gets the responses of /schema
   [Tags]  REST API GET Responses
   ${endpoint}=  get_endpoint  schema  
   ${Result}=  CONNECT API  ${base_url}  ${endpoint}
   Log  ${Result}
   Should Be Equal  success  ${Result['status']}
   Should Not Be Equal  ${Result['data']['osquery_events']}    None
   Should Not Be Empty   ${Result['data']['osquery_events']} 



Get API Responses of Endpoint /schema/<table_name>
   [Documentation]  Connects to the API and gets the responses of /schema/<table_name>
   [Tags]  REST API GET Responses
   ${endpoint}=  get_endpoint  schema/osquery_flags
   ${Result}=  CONNECT API  ${base_url}  ${endpoint}
   Log  ${Result}
   Should Be Equal  success  ${Result['status']}
   Should Not Be Empty  ${result['data']}

Get API Responses of POST Type of Endpoint /iocs/add
    [Documentation]  Connects to the API posts the required data and gets the responses /iocs/add
    [Tags]  REST API POST Responses
    ${data}=  Add_IOC_files
    ${result}=  CONNECT API IOC_PACK POST  /iocs/add  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}

Get API Responses of Endpoint /tags
   [Documentation]  Connects to the API and gets the responses of /tags
   [Tags]  REST API GET Responses
   ${endpoint}=  get_endpoint  tags
   ${Result}=  CONNECT API  ${base_url}  ${endpoint}
   Log  ${Result}
   Should Be Equal  success  ${Result['status']}
   Should Not Be Empty  ${result['data']}
   Should Be Equal    ${Result['data'][0]['value']}   Test1


  

Get API Responses of Endpoint /rule/<rule_id>
   [Documentation]  Connects to the API and gets the responses of /rules/<rule_id>
   [Tags]  REST API GET Responses
   ${endpoint}=  get_endpoint  rules/1
   ${Result}=  CONNECT API  ${base_url}  ${endpoint}
   Log  ${Result}
   Should Be Equal  success  ${Result['status']}
   Should Not Be Empty  ${result['data']}
   Should Be Equal  ${Result['data']['name']}  Adult websites test_1


#Get API Responses of POST Type of Endpoint config/<config_id>
#   [Documentation]  Connects to the API posts the required data and gets the responses of config/<config_id>
#   [Tags]  REST API POST Responses
#   ${data}=  Updating_a_config
#   ${endpoint}=  get_endpoint  /configs  ${config_id}
#   ${result}=  CONNECT API POST  ${endpoint}  ${data}
#   Log  ${result}
#   Should Be Equal  ${result['status']}   ${status}

#Get API Responses of POST Type of Endpoint /nodes/config/assign
#   [Documentation]  Connects to the API posts the required data and gets the responses of /nodes/config/assign
#   [Tags]  REST API POST Responses
#   ${data}=  Assign_a_Config_to_a_node  ${Host_id['windows']}[0]
#   ${result}=  CONNECT API POST  /nodes/config/assign   ${data}
#   Log  ${result}
#   Should Be Equal  ${result['status']}   ${status}

#Get API Responses of POST Type of Endpoint /nodes/config/remove
#    [Documentation]  Connects to the API posts the required data and gets the responses of /nodes/config/remove
#    [Tags]  REST API POST Responses
#    ${data}=  Remove_a_Config_from_a_node  ${Host_id['windows']}[0]
#    ${result}=  CONNECT API POST  /nodes/config/remove   ${data}
#    Log  ${result}
#    Should Be Equal  ${result['status']}   ${status}

Get API Responses of POST Type of Endpoint /nodes/schedule_query/results 
    [Documentation]  Connects to the API posts the required data and gets the responses of /nodes/schedule_query/results 
    [Tags]  REST API POST Responses
    ${data}=  Scheduled_Query_Results_for_an_Endpoint_Node  ${Host_id['windows']}[0]
    ${result}=  CONNECT API POST  /nodes/schedule_query/results  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}
    Should Not Be Empty  ${result['data']}

Get API Responses of Endpoint /nodes/schedule_query/<string:host_identifier>
   [Documentation]  Connects to the API and gets the responses of endpoint /nodes/schedule_query/<string:host_identifier>
   [Tags]  REST API GET Responses
   ${endpoint}=  get_endpoint  nodes/schedule_query  ${Host_id['windows']}[0]
   ${Result}=  CONNECT API  ${base_url}  ${endpoint}
   Log  ${Result}
   Should Be Equal  success  ${Result['status']}
   Should Not Be Empty  ${Result['data']}

Get API Responses of POST Type of Endpoint /distributed/add
    [Documentation]  Connects to the API posts the required data and gets the responses /distributed/add
    [Tags]  REST API POST Responses
    ${data}=  Add_a_Distributed_Query  ${Host_id['ubuntu']}[0]
    ${result}=  CONNECT API POST  /distributed/add  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}
    Should Not Be Empty  ${Result['query_id']}

Get API Responses of POST Type of Endpoint /nodes/<string:host_identifier>/queryResult
    [Documentation]  Connects to the API posts the required data and gets the responses of /nodes/<string:host_identifier>/queryResult
    [Tags]  REST API POST Responses
    ${end_point}=  END_POINTS  /nodes/host_id/queryResult  ${Host_id['windows']}[0]
    ${data}=  Get_Query_Results_of_a_Node
    ${result}=  CONNECT API POST  ${end_point}  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}
    Should Not Be Empty  ${result['data']}

Get API Responses of POST Type of Endpoint /queries/add
    [Documentation]  Connects to the API posts the required data and gets the responses /queries/add
    [Tags]  REST API POST Responses
    ${data}=  Add_a_query
    ${result}=  CONNECT API POST  /queries/add  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}
    Should Not Be Empty  ${Result['query_id']}

Get API Responses of POST Type of Endpoint /queries/<int:query_id>/tags
    [Documentation]  Connects to the API posts the required data and gets the responses of /queries/<int:query_id>/tags
    [Tags]  REST API POST Responses
    ${data}=  Add_Tags_to_a_Query
    ${result}=  CONNECT API POST  /queries/100/tags  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}

Get API Responses of Endpoint /queries
   [Documentation]  Connects to the API and gets the responses of /queries
   [Tags]  REST API GET Responses
   ${endpoint}=  get_endpoint  queries
   ${Result}=  CONNECT API  ${base_url}  ${endpoint}
   Log  ${Result}
   Should Be Equal  success  ${Result['status']}
   Should Not Contain  ${Result['data']}    None
   ${data_validation}=  Validate_Element  ${result}  new_process_query 
   Should Be True  ${data_validation}    

Get API Responses of Endpoint /queries/<query_id>
   [Documentation]  Connects to the API and gets the responses of /queries/<query_id>
   [Tags]  REST API GET Responses
   ${endpoint}=  get_endpoint  queries/2
   ${Result}=  CONNECT API  ${base_url}  ${endpoint}
   Log  ${Result}
   Should Be Equal  success  ${Result['status']}
   Should Not Be Empty  ${result['data']}
   Should Not Contain  ${Result['data']}    None
   Should Be Equal  ${Result['data']['name']}    new_process_query  

Get API Responses of POST Type of Endpoint /tags/add
    [Documentation]  Connects to the API posts the required data and gets the responses /tags/add
    [Tags]  REST API POST Responses
    ${data}=  Add_new_tags
    ${result}=  CONNECT API POST  /tags/add  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}

Get API Responses of POST Type of Endpoint /nodes/tag/edit
    [Documentation]  Connects to the API posts the required data and gets the responses /nodes/tag/edit
    [Tags]  REST API POST Responses
    ${data}=  Modify_tags_on_a_node  ${Host_id['ubuntu']}[0]
    ${result}=  CONNECT API POST  /nodes/tag/edit  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}

Get API Responses of POST Type of Endpoint /queries/tag/edit
    [Documentation]  Connects to the API posts the required data and gets the responses /queries/tag/edit
    [Tags]  REST API POST Responses
    ${data}=  Modify_tags_on_a_query
    ${result}=  CONNECT API POST  /queries/tag/edit  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}

Get API Responses of POST Type of Endpoint /alerts
    [Documentation]  Connects to the API posts the required data and gets the responses alerts
    [Tags]  REST API POST Responses
    # Sleep  300s
    ${data}=  Alerts  ${Host_id['windows']}[0]
    ${result}=  CONNECT API POST  /alerts  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}
    Should Not Be Empty  ${result['data']}
    ${data_validation}=  Validate_Element  ${result}  query_name
    Should Be True  ${data_validation} 

Get API Responses of Endpoint /alerts/data/<int:alert_id>
   [Documentation]  Connects to the API and gets the responses of endpoint /alerts/data/<int:alert_id>
   [Tags]  REST API GET Responses
   ${endpoint}=  get_endpoint  alerts/data/1
   ${Result}=  CONNECT API  ${base_url}  ${endpoint}
   Log  ${Result}
   Should Be Equal   ${Result['status']}  ${status}
   Should Not Be Empty  ${result['data']}
   Should Be Equal  ${Result['data']['alert']['query_name']}  win_process_events

Get API Responses of POST Type of Endpoint /packs/add
    [Documentation]  Connects to the API posts the required data and gets the responses /packs/add
    [Tags]  REST API POST Responses
    ${data}=  Upload_a_pack
    ${result}=  CONNECT API POST  /packs/add  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}
    Should Not Be Empty  ${Result['pack_id']}

Get API Responses of POST Type of Endpoint /packs/<string:pack_name>/tags
    [Documentation]  Connects to the API posts the required data and gets the responses of /packs/<string:pack_name>/tags
    [Tags]  REST API POST Responses
    ${data}=  Add_tags_to_A_Pack
    ${result}=  CONNECT API POST  /packs/all-events-pack/tags  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}  

Get API Responses of Endpoint /packs
   [Documentation]  Connects to the API and gets the responses of packs
   [Tags]  REST API GET Responses
   ${endpoint}=  get_endpoint  packs
   ${Result}=  CONNECT API  ${base_url}  ${endpoint}
   Log  ${result}
   Should Be Equal  success  ${Result['status']}
   Should Not Be Empty  ${result['data']}
   ${data_validation}=  Validate_Element  ${result}  process_query_pack
   Should Be True  ${data_validation

Get API Responses of Endpoint packs/<packs_id>
   [Documentation]  Connects to the API and gets the responses of packs/<packs_id>
   [Tags]  REST API GET Responses
   ${endpoint}=  get_endpoint  packs/1
   ${Result}=  CONNECT API  ${base_url}  ${endpoint}
   Log  ${Result}
   Should Be Equal  success  ${Result['status']}
   Should Not Be Empty  ${result['data']}
   Should Not Be Empty   ${Result['data'][0]['name']}

Get API Responses of Endpoint /packs/<string:pack_name>/tags
   [Documentation]  Connects to the API and gets the responses of endpoint /packs/<string:pack_name>/tags
   [Tags]  REST API GET Responses
   ${endpoint}=  get_endpoint  packs/all-events-pack/tags
   ${Result}=  CONNECT API  ${base_url}  ${endpoint}
   Log  ${Result}
   Should Be Equal  success  ${Result['status']}
   Should Not Be Empty  ${Result['data']}
   List Should Contain Value  ${result['data']}  Test1

Get API Responses of POST Type of Endpoint /packs/tag/edit
    [Documentation]  Connects to the API posts the required data and gets the responses /packs/tag/edit
    [Tags]  REST API POST Responses
    ${data}=  Modify_tags_on_a_pack
    ${result}=  CONNECT API POST  /packs/tag/edit  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}

Get API Responses of POST Type of Endpoint /email/configure
    [Documentation]  Connects to the API posts the required data and gets the responses /email/configure
    [Tags]  REST API POST Responses
    ${data}=  Configure_email_sender_and_recipients_for_alerts
    ${result}=  CONNECT API POST  /email/configure  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}
    Should Not Be Empty  ${result['data']}
    Should Not Be Empty  ${result['data']['emailRecipients']}

Get API Responses of POST Type of Endpoint /kill process
    [Documentation]  Connects to the API posts the required data and gets the /response/add to kill process
    [Tags]  REST API POST Responses
    ${pid}  Get PID 
    ${data}=  Kill_Process_on_Endpoint  ${host_Name}  ${pid}
    Log  ${data}
    ${response}=  CONNECT API POST  /response/add  ${data}
    Log  ${response}
    ${command_id}  get_id  ${response}
    Set Global Variable  ${command_id}
    Sleep  30s
    ${endpoint}=  get_endpoint  response  ${command_id}
    ${Result}=  CONNECT API  ${base_url}  ${endpoint} 
    Log  ${result}
    Should Be Equal  ${result['data']['status']}   ${status}

Get API Responses of POST Type of Endpoint /carves
    [Documentation]  Connects to the API posts the required data and gets the /carves
    [Tags]  REST API POST Responses
    ${data}=  Carves  ${Host_id['ubuntu']}[0]
    ${result}=  CONNECT API POST  /carves  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}

Get API Responses of Endpoint /downloads/<path:filename>
   [Documentation]  Connects to the API and gets the responses of endpoint /downloads/<path:filename>
   [Tags]  REST API GET Responses
   ${token}=  get_token  ${server_ip}
   Set Global Variable  ${token}
   ${endpoint}=  get_endpoint  downloads/certificate.crt
   ${Result}=  CONNECT API  ${base_url}  ${endpoint}
   Log  ${Result}
   Should Be Equal  success  ${Result['status']}

Get API Responses of Endpoint /cpt/<string:platform>
   [Documentation]  Connects to the API and gets the responses of endpoint /cpt/<string:platform>
   [Tags]  REST API GET Responses
   ${endpoint}=  get_endpoint  cpt/windows
   ${Result}=  CONNECT API  ${base_url}  ${endpoint} 
   Log  ${Result}
   Should Be Equal  success  ${Result['status']}

Get API Responses of Endpoint /certificate
   [Documentation]  Connects to the API and gets the responses of endpoint /certificate
   [Tags]  REST API GET Responses
   ${endpoint}=  get_endpoint  certificate
   ${Result}=  CONNECT API  ${base_url}  ${endpoint}
   Log  ${Result}
   Should Be Equal  success  ${Result['status']}

Get API Responses of Endpoint /nodes_csv
   [Documentation]  Connects to the API and gets the responses of endpoint /nodes_csv
   [Tags]  REST API GET Responses
   ${endpoint}=  get_endpoint  nodes_csv
   ${Result}=  CONNECT API  ${base_url}  ${endpoint}
   Log  ${Result}
   Should Be Equal  success  ${Result['status']}

Get API Responses of Endpoint /yara
   [Documentation]  Connects to the API and gets the responses of endpoint /yara
   [Tags]  REST API GET Responses
   ${endpoint}=  get_endpoint  yara
   ${Result}=  CONNECT API  ${base_url}  ${endpoint}
   Log  ${Result}
   Should Be Equal  success  ${Result['status']}

#Get API Responses of Endpoint /search_input
#   [Documentation]  Connects to the API and gets the responses of endpoint /search_input
#   [Tags]  REST API GET Responses
#   ${endpoint}=  get_endpoint  search_input
#   ${Result}=  CONNECT API  ${base_url}  ${endpoint}
#   Log  ${Result}
#   Should Be Equal  success  ${Result['status']}

Get API Responses of POST Type of Endpoint /queryresult/delete
    [Documentation]  Connects to the API posts the required data and gets the responses of /queryresult/delete
    [Tags]  REST API POST Responses
    ${data}=  Delete_query_result_for_some_recent_days
    ${result}=  CONNECT API POST  /queryresult/delete  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}

Get API Responses of Endpoint /queryresult/delete
    [Documentation]  Connects to the API and gets the responses of endpoint /queryresult/delete
    [Tags]  REST API GET Responses
    ${data}=  Delete_query_result_for_some_recent_days
    ${result}=  CONNECT API GET  /queryresult/delete  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}

Get API Responses of POST Type of Endpoint /schedule_query/export
    [Documentation]  Connects to the API posts the required data and gets the responses of /schedule_query/export
    [Tags]  REST API POST Responses
    ${data}=  Export_schedule_query_results_into_csv_file  ${Host_id['windows']}[0]
    ${result}=  CONNECT API POST  /schedule_query/export  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}

Get API Responses of POST Type of Endpoint /options/add
    [Documentation]  Connects to the API posts the required data and gets the responses of /options/add
    [Tags]  REST API POST Responses
    ${data}=  Update_the_options
    ${result}=  CONNECT API POST  /options/add  ${data} 
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}

Get API Responses of POST Type of Endpoint /nodes/search/export
    [Documentation]  Connects to the API posts the required data and gets the responses of /nodes/search/export
    [Tags]  REST API POST Responses
    ${data}=  Search_Export_To_CSV_File  ${Host_id['windows']}[0]
    Log  ${data}
    ${result}=  CONNECT API POST  /nodes/search/export  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}

Get API Responses of POST Type of Endpoint /search
    [Documentation]  Connects to the API posts the required data and gets the responses of /search
    [Tags]  REST API POST Responses
    ${data}=  Search_for_data_in_result_log_database_table  ${Host_id['windows']}[0]
    Log  ${data}
    ${result}=  CONNECT API POST  /search  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}
    Should Not Be Empty  ${result['data']}
    ${data_validation}=  Validate_Element  ${result}  ${data['conditions']['rules'][0]['value']}
    Should Be True  ${data_validation}   

Get API Responses of Endpoint /iocs
   [Documentation]  Connects to the API and gets the responses of endpoint /iocs
   [Tags]  REST API GET Responses
   ${endpoint}=  get_endpoint  iocs
   ${Result}=  CONNECT API  ${base_url}  ${endpoint}
   Log  ${Result}
   Should Be Equal  success  ${Result['status']}
   Should Not Be Empty  ${Result['data']}
   ${data_validation}=  Validate_Element  ${result}  .www.amazon.in
   Should Be True  ${data_validation}  

Get API Responses of POST Type of Endpoint /packs/upload
    [Documentation]  Connects to the API posts the required data and gets the responses /packs/upload
    [Tags]  REST API POST Responses
    ${data}=  Add_packs_through_file_upload
    ${result}=  CONNECT API IOC_PACK POST  /packs/upload  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}

Get API Responses of POST Type of Endpoint /hunt-upload
    [Documentation]  Connects to the API posts the required data and gets the responses /hunt-upload
    [Tags]  REST API POST Responses
    ${data}=  Hunt_file_upload
    ${result}=  CONNECT API HUNT POST  /hunt-upload  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}

Get API Responses of POST Type of Endpoint /changepw
    [Documentation]  Connects to the API posts the required data and gets the responses of /changepw
    [Tags]  REST API POST Responses
    ${data}=  Change_User_Password
    ${result}=  CONNECT API POST  /changepw  ${data}
    Log  ${result}
    Should Be Equal  ${result['status']}   ${status}



*** Keywords ***

CONNECT API
	[Arguments]  ${base_url}  ${endpoint}
	${API_object}=  call_API   ${base_url}  ${endpoint}  ${token}
	[Return]  ${API_object.connect_API()}

TERMINATE EC2 INSTANCE
	[Arguments]  ${Instance_id}
	${Result}  Terminate_instance  ${Instance_id}
	[Return]  ${Result}

CONNECT API POST
    [Arguments]  ${endpoint}  ${data}
    Log  ${data}
    ${obj}  apitest  ${server_ip}   ${endpoint}  ${data}  ${token}
    [Return]  ${obj.test_connection()}

CONNECT API GET   ## (only for /queryresult/delete)
    [Arguments]  ${endpoint}  ${data}
    Log  ${data}
    ${obj}  apitest  ${server_ip}   ${endpoint}  ${data}  ${token}
    [Return]  ${obj.get_connection()}

Start and Stop windows instance
    [Arguments]  ${activity}
    ${windows_host_ip}=  start_stop_instance  ${activity}
    Log  ${windows_host_ip}
    [Return]  ${windows_host_ip}

Get PID
   ${login_win}=  windows_ssh_object  ${windows_host_ip}  ${server_ip}
   [Return]  ${login_win.get_pid()}

CONNECT API IOC_PACK POST
    [Arguments]  ${endpoint}  ${data}
    Log  ${data}
    ${obj}  apitest  ${server_ip}   ${endpoint}  ${data}  ${token}
    [Return]  ${obj.ioc_pack()}

CONNECT API HUNT POST
    [Arguments]  ${endpoint}  ${data}
    Log  ${data}
    ${obj}  apitest  ${server_ip}   ${endpoint}  ${data}  ${token}
    [Return]  ${obj.hunt()}
