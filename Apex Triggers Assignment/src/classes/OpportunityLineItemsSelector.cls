public with sharing class OpportunityLineItemsSelector extends fflib_SObjectSelector{
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
        	OpportunityLineItem.Id,
        	OpportunityLineItem.ServiceDate,
            OpportunityLineItem.Discount,
            OpportunityLineItem.Quantity
             };
    }
    
    public Schema.SObjectType getSObjectType() {
        return OpportunityLineItem.sObjectType;
    }
    
     public List<Class__c> selectById(Set<ID> idSet) {
        return (List<Class__c>) selectSObjectsById(idSet);
    }
    
     public List<OpportunityLineItem> selectOpportunityLineItemByOpportunityId(Set<Id> oppIds){
    	 fflib_QueryFactory query = newQueryFactory();
   		 query.setCondition('OpportunityId IN :oppIds');
   		 return ((List<OpportunityLineItem>) Database.query(query.toSOQL()));
    }
}