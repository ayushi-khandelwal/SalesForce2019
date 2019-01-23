public with sharing class OpportunitiesSelector extends fflib_SObjectSelector {
    
   public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Opportunity.Name,
            Opportunity.Id
             };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Opportunity.sObjectType;
    }
    
    public List<Opportunity> selectById(Set<ID> idSet) {
        return (List<Opportunity>) selectSObjectsById(idSet);
    }
    
    public List<Opportunity> selectMonthWiseLastOpportunityUpdated(DateTime aMonthAgo){
        List<Opportunity> opportunityList = [Select Id,OwnerId, Description From Opportunity Where LastModifiedDate <: aMonthAgo];
        return opportunityList;
    }
    
    public List<Opportunity> selectOpportunityById(Set<ID> idSet){
        List<Opportunity> opportunityList = [Select Id,OwnerId, Description,BillToContact__r.Id,BillToContact__r.AccountId,Manager__r.Id From Opportunity Where Id In : idSet];
        return opportunityList;
    }
}