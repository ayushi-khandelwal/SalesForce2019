public with sharing class Accounts extends fflib_SObjectDomain {
    
    public Accounts(List<Account> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Accounts(sObjectList);
        }
    }
    
    public void updateContacIdsInformation(List<Account> accountObjects, String contactId){
    	 fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] { Account.SObjectType });
    	 List<Account> accountWithNullContactIds = new List<Account>();
    	   for(Account account : accountObjects){
    	   		if(account.contactIds == null){
    	   			accountWithNullContactIds.add(account);
    	   		}
    	   }
    	   if(accountWithNullContactIds.size()>0){
    	   	accountObjects = handleNullContactIdInformation(accountWithNullContactIds,uow);
    	   }
    	   for(Account account : accountObjects) {
            	account.contactIDs = account.contactIDs +','+contactId ;
            	uow.registerDirty(account);
       	 	}
       	 uow.commitWork();
    }
    
    public List<Account> handleNullContactIdInformation(List<Account> accountObjects){
    	for(Account accountObject : accountObjects){
    		for(Contact contactObject : accountObject.Contacts){
    			accountObject.contactIDs = accountObject.contactIDs +','+contactObject.Id ;
    		}
    	}
    	return accountObjects;
    }
    
    
}