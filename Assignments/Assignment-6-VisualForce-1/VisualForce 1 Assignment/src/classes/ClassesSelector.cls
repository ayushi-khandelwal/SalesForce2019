public with sharing class ClassesSelector extends fflib_SObjectSelector {
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
        	Class__c.Name,
            Class__c.Name__c,
            Class__c.Id,
            Class__c.Max_Size__c,
            Class__c.Number_Of_Students__c,
            Class__c.Number_Of_Pupils__c,
            Class__c.Class_Teacher__c,
            Class__c.Detailed_Description__c,
            Class__c.Fee__c
             };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Class__c.sObjectType;
    }
    
    public List<Class__c> selectById(Set<ID> idSet) {
        return (List<Class__c>) selectSObjectsById(idSet);
    }
    
    public Map<Id,Class__c> selectStudentByClassId(Set<Id> classIds){
    	 fflib_QueryFactory query = newQueryFactory();
   		 query.setCondition('Id IN :classIds');
   		 new StudentsSelector().addQueryFactorySubSelect(query,'Student__r');
   		 return new Map<Id,Class__c>((List<Class__c>) Database.query(query.toSOQL()));
    	 //Map<Id,Class__c> classOf= new Map<Id,Class__c>([Select Id,Name,Max_Size__c,(Select Id,Name From Student__r) From Class__c Where ID IN : classIds]);
    	 //return classOf;
    }
    
    public List<Class__c> selectAllClassWithStudent(){
    	List<Class__c> classesList = [Select Id,Name,Max_Size__c,(Select ID,Name From Student__r) From Class__c];
    	return classesList;
    }
    
    public List<Class__c> selectAllClassWithFemaleStudents(List<Class__c> recordsToBeDeleted){
    	List<Class__c> classesList = [Select id,Name,(Select id From Student__r Where Sex__c = 'F') From Class__c Where Id IN : recordsToBeDeleted];
    	return classesList;
    }
}