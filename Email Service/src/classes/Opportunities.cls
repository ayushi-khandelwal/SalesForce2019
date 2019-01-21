public with sharing class Opportunities extends fflib_SObjectDomain {
   
   ContactsSelector contactSelectorObject = new ContactsSelector();
   
   public Opportunities(List<Opportunity> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Opportunities(sObjectList);
        }
    } 
    
     public override void onBeforeUpdate(Map<Id,SObject> existingRecords){
    	OpportunityManager.manageBillToContactAndManager((List<Opportunity>) Records);
    	OpportunityManager.updateCloseDateOnStageChange((List<Opportunity>) Records,existingRecords);
    }
    
    public override void onAfterUpdate(Map<Id,SObject> existingRecords){
    	fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] { OpportunityLineItem.SObjectType });
    	OpportunityManager.customStatusChangeDeleteProductsAssociated((List<Opportunity>) Records, uow);
    	uow.commitWork();
        OpportunityManager.statusChangeEmail((List<Opportunity>) Records,existingRecords);
    }
}