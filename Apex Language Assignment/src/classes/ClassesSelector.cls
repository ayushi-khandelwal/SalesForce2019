public with sharing class ClassesSelector extends fflib_SObjectSelector implements ClassesSelectorInterface {
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
        	Class__c.Name,
            Class__c.Id
             };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Class__c.sObjectType;
    }
    
    public List<Class__c> selectById(Set<ID> idSet) {
        return (List<Class__c>) selectSObjectsById(idSet);
    }
    
    public Map<Id,Class__c> selectStudentByClassId(Set<Id> classIds){
    	 Map<Id,Class__c> classOf= new Map<Id,Class__c>([Select Id,(Select Name From Student__r) From Class__c Where ID IN : classIds]);
    	 return classOf;
    }
    
    public List<Class__c> selectAllClassWithStudent(){
    	List<Class__c> classesList = [Select Id,Name,(Select ID,Name From Student__r) From Class__c];
    	return classesList;
    }
}