public with sharing class AccountService implements IAccountService{
	
	AccountsSelectorInterface accountSelectorObject = new AccountsSelector();
	
	ContactsSelector contactSelectorObject = new ContactsSelector();
	
	public List<Account> getAccountBySetIds(Set<Id> accountIds){
		return AccountServiceImpl.getInstanceOf().getAccountBySetIds(accountIds);
	}
    
    public List<Account> updateAccountContactIDs(Id contactId){
    	return AccountServiceImpl.getInstanceOf().updateAccountContactIDs(contactId);
    }
    
}