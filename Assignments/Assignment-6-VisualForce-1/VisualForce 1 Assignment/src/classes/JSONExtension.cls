public with sharing class JSONExtension {
    
    public String jsonObject{get; set;}
    public String recordId{get; set;}
    
    public void setJson(){
        //Id recordId = ApexPages.currentPage().getParameters().get('id');
        jsonObject = createJsonFromSObject(String.valueOf(recordId));
    }
    
    //This method returns the JSON string for the corresponding record.
    public static string createJsonFromSObject(String recordId)
    {
        //"recordId" can be the Record ID of any object.
        if(String.isNotBlank(recordId))
        {
            String jsonRequest = '';
            String queryFields = '';

            //Getting the first three characters from the record id and passing that into another method to get the object name.
            String objectName = findObjectNameFromRecordIdPrefix(recordId.subString(0,3));

            //Getting schema information.
            Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();

            //Getting the fields information
            Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();

            //Initializing a new map to obtain the Data Type of a particular field.
            //Key is the Field API name and Value is the Data Type.
            Map<String, String> fieldNameTypeMap = new Map<String, String>();
            
            for(Schema.SObjectField sfield: fieldMap.Values())
            {
                schema.describefieldresult dfield = sfield.getDescribe();
                
                //Putting the field api name and data type into the map.
                fieldNameTypeMap.put(dfield.getName(), dfield.getType().name());
            }
            system.debug('FIELD NAMES-------'+fieldNameTypeMap.keySet().size());
            for(String field: fieldNameTypeMap.keySet())
            {
                 //Putting together all the fields to query the data.
                 queryFields += field+',';
            }
            queryFields = queryFields.removeEnd(',');

            //Creating query in a string variable.
            String queryString = 'SELECT '+queryFields+' FROM '+objectName+' WHERE Id =: recordId';
            system.debug('QUERYSTRING-----'+queryString);

            //Making the query
            sObject obj = Database.Query(queryString);
            system.debug('OBJECT------'+obj);
            
            //Initializing the JSONGenerator. "true" has been passed into the method for pretty print formatting of JSON.
            JSONGenerator gen = JSON.createGenerator(true);
            gen.writeStartArray();
            gen.writeStartObject();
            gen.writeFieldName('attributes'); //creating JSON field "attributes". Change it according to your need.
            gen.writeStartObject();
            gen.writeStringField('type',objectName);
            gen.writeStringField('url','/services/data/v36.0/Sobjects/'+objectName+'/'+recordId);
            gen.writeEndObject();
            gen.writeFieldName('fields'); //creating JSON field "fields". Change it according to your need.
            gen.writeStartObject();
            
            //Iterating over each field and writing every field into JSON string. 
            //If the field value is null then blank is written in the JSON.
            for(String field: fieldNameTypeMap.keySet())
            {
                if(obj.get(field) != null)
                {
                    gen.writeStringField(field, String.ValueOf(obj.get(field)));
                }
                else
                {
                    gen.writeStringField(field, '');
                }
            }
            
            gen.writeEndObject();
            gen.writeEndObject();
            gen.writeEndArray();
            jsonRequest = gen.getAsString();//Getting the JSON String by using "getAsString" method of JSONGenerator class.
            system.debug('JSONRequest------'+jsonRequest);
            return jsonRequest;
        }
        else
        {
            return null;
        }
    }
    
    //This method returns the name of object by manipulating the record ID.
    public static String findObjectNameFromRecordIdPrefix(String recordIdOrPrefix)
    {
        String objectName = '';
        try
        {
            //Get prefix from record ID
            //This assumes that you have passed at least 3 characters
            String myIdPrefix = String.valueOf(recordIdOrPrefix).substring(0,3);
             
            //Get schema information
            Map<String, Schema.SObjectType> gd =  Schema.getGlobalDescribe(); 
             
            //Loop through all the sObject types returned by Schema
            for(Schema.SObjectType stype : gd.values())
            {
                Schema.DescribeSObjectResult r = stype.getDescribe();
                String prefix = r.getKeyPrefix();
                 
                //Check if the prefix matches with requested prefix
                if(prefix!=null && prefix.equals(myIdPrefix))
                {
                    objectName = r.getName();
                    System.debug('Object Name! ' + objectName);
                    break;
                }
            }
        }
        catch(Exception e)
        {
            System.debug(e);
        }
        return objectName;
    }
    
    
}