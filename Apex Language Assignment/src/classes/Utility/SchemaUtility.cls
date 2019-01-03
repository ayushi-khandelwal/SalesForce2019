public with sharing class SchemaUtility {
    
    public List<String> getSObjectsInTheOrg (){
    	Map<String, Schema.SObjectType> sObjectOrg = Schema.getGlobalDescribe();
    	List<String> sObjectOrgNameOfObjects = sObjectOrg.keySets();
    	return sObjectOrgNameOfObjects;
    }
     
}