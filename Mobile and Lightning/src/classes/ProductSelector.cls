public with sharing class ProductSelector extends fflib_SObjectSelector{
    
     public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
        	Product__c.Name,
            Product__c.Id,
            Product__c.Price__c,
            Product__c.Status__c
             };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Product__c.sObjectType;
    }
    
    public List<Product__c> selectById(Set<ID> idSet) {
        return (List<Product__c>) selectSObjectsById(idSet);
    }
    
    public List<Product__c> selectByName(Set<String> fieldsSet,String queryCondition){
        String condition = 'Name Like \''+queryCondition+'%\'';
    	fflib_QueryFactory query = newQueryFactory();
        if(fieldsSet.size()>0){
        	query.selectFields(fieldsSet);    
        }
        if(queryCondition!=null && queryCondition!=''){
            query.setCondition(condition);
        }
   		return (List<Product__c>) Database.query(query.toSOQL());
    }
}