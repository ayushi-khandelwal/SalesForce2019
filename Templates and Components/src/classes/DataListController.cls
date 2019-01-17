public with sharing class DataListController {
    
    public List<String> fieldNames{get; set;}
    public Map<String,String> nameLabelMap {get; set;}
    public String sortByField{get;set;}
    
    public ApexPages.StandardSetController ssc {get; set;}
    public Integer pageSize {get; set;}
    
    public String fieldParams{get; set;}
    public String objectName{get; set;}
    
    Map<String, Schema.SObjectField> fieldMap;
    Transient Schema.DescribeSObjectResult objectDescribe;
    
    public DataListController(){
        
    }
    
    public List<sObject> getRecords(){
        if(ssc==null){
            Boolean validationFail = false;
            if(fieldParams == null && objectName == null){
                validationFail = true;
            }
            if(!validate(objectName,fieldParams)){
                validationFail=true;    
            }
            if(!validationFail){
                    fieldNames = fieldParams.split(',');
                    fieldMap = getObjectDescribe().fields.getMap();
                    nameLabelMap = new Map<String,String>();
                    for(String fld : fieldNames){
                        String label = fieldMap.get(fld).getDescribe().getLabel();
                        nameLabelMap.put(fld,label);
                    }
                    String query = 'Select '+fieldParams+' From '+objectName+' ';
                    if(sortByField != null){
                        query += ' Order By '+sortByField+ ' asc' ;
                    }
                    ssc = new ApexPages.StandardSetController(Database.query(query));
                	if(ssc.getCompleteResult() == false){
						ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING,'There were more related records than could be processed. This is a partially complete list.'));
					}
                    if(ssc!=null && pageSize!=null && pageSize>0){
                        ssc.setPageSize(pageSize);
                    }
                    return ssc.getRecords();
                }
            else{
            		return null;
       		 }
        }
        else{
            return ssc.getRecords();
        }
    }
           
    public boolean validate(String objectName, String fieldParams){
           return true;        
    }
    
    public DescribeSObjectResult getObjectDescribe(){
		if(objectDescribe == null){
			objectDescribe = Schema.getGlobalDescribe().get(objectName).getDescribe();	
		}
		return objectDescribe;
	}
    
    public void sortByField(){
       ssc = null; 
    }
}