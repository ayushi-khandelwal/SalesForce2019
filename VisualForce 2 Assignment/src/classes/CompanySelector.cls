public with sharing class CompanySelector extends fflib_SObjectSelector {
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
        	Company__c.Name,
            Company__c.Id
             };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Company__c.sObjectType;
    }
    
    public List<Company__c> selectById(Set<ID> idSet) {
        return (List<Company__c>) selectSObjectsById(idSet);
    }
}