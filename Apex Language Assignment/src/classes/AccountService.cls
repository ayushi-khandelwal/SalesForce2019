public with sharing class AccountService implements AccountServiceI{
	
	AccountsSelectorInterface accountSelectorObject = new AccountsSelector();
	
	ContactsSelector contactSelectorObject = new ContactsSelector();
	
	public List<Account> getAccountBySetIds(Set<Id> accountIds){
		return accountSelectorObject.getAccountWithContacts(accountIds);	
	}
    
    public List<Account> updateAccountContactIDs(Id contactId){
    	Set<Id> contactSet = new Set<Id>();
    	contactSet.add(contactId);
    	//List<Contact> contactObjects = contactSelectorObject.selectById(contactSet);
    	//Set<Id> accountSet= new Set<Id>();
    	//accountSet.add(contactObjects[0].AccountId);
    	List<Account> accountObjects = accountSelectorObject.getAccountByContactId(contactSet);
    	Accounts accountDomainObject = new Accounts(accountObjects);
    	accountDomainObject.updateContacIdsInformation(accountObjects,contactId);
    	//return getAccountBySetIds(accountSet);
    	return accountSelectorObject.getAccountByContactId(contactSet);
    }
    
}