public with sharing class SchemaUtility {
    
    public static Set<String> getSObjectsInTheOrg (){
    	Map<String, Schema.SObjectType> sObjectOrg = Schema.getGlobalDescribe();
    	Set<String> sObjectOrgNameOfObjects = sObjectOrg.keyset();
    	return sObjectOrgNameOfObjects;
    }
     
}