public with sharing class OpportunityManager {
    
    public static void manageBillToContactAndManager(List<Opportunity> contactList){
        ContactsSelector contactSelectorObject = new ContactsSelector();
        Map<Id,Opportunity> mapOfOpportunities = new Map<Id,Opportunity>();
        List<Id> contactIds = new List<Id>();
        for(Opportunity opp : (List<Opportunity>)contactList){
            contactIds.add(opp.BillToContact__c);
        }
        Map<Id,Contact> contactMap = new Map<Id,Contact>(contactSelectorObject.selectContactById(contactIds));
        for(Opportunity opp : (List<Opportunity>)contactList)
        {
            if(opp.BillToContact__c!=null && opp.Manager__c==null){
                Contact cont = contactMap.get(opp.BillToContact__c);
                opp.Manager__c = cont.AccountId ;
            }
              
        }
    }
    
    public static void updateCloseDateOnStageChange (List<Opportunity> opportunityList, Map<Id,SObject> existingRecordsOf){
        for(Opportunity opportunityObject : opportunityList){
            Opportunity opportunityObjectBefore = (Opportunity)existingRecordsOf.get(opportunityObject.Id);
            if(opportunityObjectBefore != null){
                if(opportunityObjectBefore.StageName != opportunityObject.StageName && (opportunityObject.StageName == 'Closed Won' || opportunityObject.StageName == 'Closed Lost') ){
                    opportunityObject.CloseDate = Date.today();
                }
            }
        }   
    }
    
    public static void customStatusChangeDeleteProductsAssociated(List<Opportunity> recordsUpdated,fflib_SObjectUnitOfWork uow){
        Set<Id> opportunityIds = new Set<Id>();
        for(Opportunity opportunityObject : recordsUpdated){
            if(opportunityObject.Custom_Status__c == 'Reset'){
                opportunityIds.add(opportunityObject.Id);
            }
        }
        if(opportunityIds.size()>0){
            OpportunityLineItemsSelector oppLineItemSelector = new OpportunityLineItemsSelector();
            List<OpportunityLineItem> oppLineItemList = oppLineItemSelector.selectOpportunityLineItemByOpportunityId(opportunityIds);
            uow.registerDeleted(oppLineItemList);
        }
    }
    
    public static void statusChangeEmail(List<Opportunity> recordsInserted, Map<Id,SObject> existingRecordsOf){
        List<Opportunity> emailApplicants = new List<Opportunity>();
        for(Opportunity opp: recordsInserted){
               Opportunity oppToCompare = (Opportunity)existingRecordsOf.get(opp.Id);
                if(oppToCompare.Custom_Status__c != opp.Custom_Status__c){
                    emailApplicants.add(opp);
                }
            }
        EmailTemplate eTemp = [SELECT id,name FROM EmailTemplate WHERE name ='Opportunity Status Change' AND isActive = true LIMIT 1];
        List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
        for(Opportunity emailApplicant : emailApplicants){
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setReplyTo('sankalp.vyas@metacube.com');
            email.setSaveAsActivity(false);
   			email.setTemplateId(eTemp.Id);
            email.setTargetObjectId(emailApplicant.OwnerId);
            email.setTreatTargetObjectAsRecipient(false);
            email.setToAddresses(new String[]{'sankalp.vyasrocker@gmail.com'});
            emailMessages.add(email);
        }
   		Messaging.sendEmail(emailMessages); 
    }
}