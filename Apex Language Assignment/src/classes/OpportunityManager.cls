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
}