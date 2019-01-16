public with sharing class PurchaseOrderSelector extends fflib_SObjectSelector{
   
   public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
        	Purchase_Order__c.Name,
            Purchase_Order__c.Id,
            Purchase_Order__c.Order_Cost__c,
            Purchase_Order__c.Purchase_Order_Id__c,
            Purchase_Order__c.Status__c
             };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Purchase_Order__c.sObjectType;
    }
    
    public List<Purchase_Order__c> selectById(Set<ID> idSet) {
        return (List<Purchase_Order__c>) selectSObjectsById(idSet);
    } 
    
    public List<Purchase_Order__c> selectByOwnerId(Set<Id> idSet){
    	fflib_QueryFactory query = newQueryFactory();
   		query.setCondition('OwnerId IN :idSet');
    	return (List<Purchase_Order__c>) Database.query(query.toSOQL());
    }
}