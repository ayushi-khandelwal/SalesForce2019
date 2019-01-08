public with sharing class StudentsSelector extends fflib_SObjectSelector{
    
     public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
        	Student__c.Name,
            Student__c.Id,
            Student__c.Sex__c,
            Student__c.Class__c
             };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Student__c.sObjectType;
    }
    
     public List<Student__c> selectById(Set<ID> idSet) {
        return (List<Student__c>) selectSObjectsById(idSet);
    }
    
}