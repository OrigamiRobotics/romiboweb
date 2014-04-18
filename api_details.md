Romiboweb API details
=====================

### Version: v1

## User Authentication

### Registration

**URL:** /api/v1/register  
**Method:** POST  
**Body:**  
```
{"user":{  
  "first_name":  
  "last_name":  
  "email":  
  "password":  
}}
```  
    
**Response:**  
Success:  
HTTP: 201 Created  
    {"user":{  
        "first_name":  
        "last_name":  
        "email":  
        "auth_token":  
        }  
    }  

Failure:  
HTTP: 422 Unproccessible entity    
HTTP: 400 Bad Request

***    

### Login    

**URL:** /api/v1/login  
**Method:** POST  
**Body:**  
```
{"user":{  
  "email":  
  "password":  
}}  
```
    
**Response:**  
Success:  
HTTP 201 Created
Body:
```
{user:  
    {first_name:  
    last_name:  
    email:  
    **auth_token:**  
    } 
}
```

Failure:  
HTTP: 401 Unauthorized
    
***

### Download Palettes

**URL:** /api/v1/palettes  
**Method:** GET  
**Headers:**  
- Authentication: Token token= **auth_token**

**Response:**  
Success: HTTP 200 OK  
Body: 
``` 
  {"palettes":[  
      {"id:"  
      "title:"  
      "color:"  
      "description:"  
      "owner_id:"  
      "buttons:" [  
          {"id:"  
          "title:"  
          "speech_phrase:"  
          "speech_speed_rate:"  
          "color:"  
          "size:"  
          "row:"  
          "col:"  
          }
      ]  
      }  
  ]}
```

Failure: HTTP 401 Unauthorized

***

### Upload Palettes

**URL:** /api/v1/palettes  
**Method:** POST  
**Headers:**  
- Authentication: Token token= **auth_token**

**Body:**  
```
{"palette":{
  "title": <required>
  "color": <optional>
  "description": <optional>
  "buttons": [
    {
      "button": {
        "title:"  
        "speech_phrase:"  
        "speech_speed_rate:"  
        "color:"  
        "size:"  
      }
    }
  ]
}}
```    

**Response:**  
Success: HTTP 201 Created  
Body:
```
{"palette":{
  "id":
  "title": 
  "color": 
  "description": 
  "owner_id":
  "buttons": [
    {
      "button": {
        "id:"  
        "title:"  
        "speech_phrase:"  
        "speech_speed_rate:"  
        "color:"  
        "size:"  
        "row:"  
        "col:"  
      }
    }
  ] 
}}
```  

Failure: HTTP 422 Unprocessable Entity   

***
