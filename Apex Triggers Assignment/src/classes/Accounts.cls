public class Accounts extends fflib_SObjectDomain {
    
    public Accounts(List<Account> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Accounts(sObjectList);
        }
    }
    
    public void updateContacIdsInformation(List<Account> accountObjects, Id contactId){
    	 fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] { Account.SObjectType });
    	 List<Account> accountObjectsList = handleNullContactIdInformation(accountObjects,contactId); 
         uow.registerDirty(accountObjectsList);
       	 uow.commitWork();
    }
    
    public List<Account> handleNullContactIdInformation(List<Account> accountObjects,Id contactId){
    	for(Account accountObject : accountObjects){
    		if(accountObject.ContactIDs__c == null){
    		for(Contact contactObject : accountObject.Contacts){
                if( accountObject.ContactIDs__c != null){
                    accountObject.ContactIDs__c = accountObject.ContactIDs__c +','+contactObject.Id ;
                }
                else{
                    accountObject.ContactIDs__c = contactObject.Id ;
                }
    		}
    	  }else{
    	  	if(!accountObject.ContactIds__c.contains(String.valueOf(contactId))){
    	  		accountObject.ContactIDs__c = accountObject.contactIDs__c +','+contactId ;
    	  	}
    	  }
    	}
    	return accountObjects;
    }
    
    
}