public with sharing class PurchaseLineItemSelector extends fflib_SObjectSelector{
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
        	Purchase_Line_Items__c.Name,
            Purchase_Line_Items__c.Id,
            Purchase_Line_Items__c.Product__c,
            Purchase_Line_Items__c.Quantity__c,
            Purchase_Line_Items__c.Purchase_Order__c,
            Purchase_Line_Items__c.Total_Price__c
             };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Purchase_Line_Items__c.sObjectType;
    }
    
    public List<Purchase_Line_Items__c> selectById(Set<ID> idSet) {
        return (List<Purchase_Line_Items__c>) selectSObjectsById(idSet);
    }
    
    public List<Purchase_Line_Items__c> selectByPurchaseOrderId(Set<Id> idSet) {
    	fflib_QueryFactory query = newQueryFactory();
   		query.setCondition('Purchase_Order__c IN :idSet');
    	return (List<Purchase_Line_Items__c>) Database.query(query.toSOQL());
    }
}