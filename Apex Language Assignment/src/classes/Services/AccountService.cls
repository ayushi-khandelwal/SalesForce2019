public with sharing class AccountService implements AccountServiceInterface{
	
	AccountSelectorInterface accountSelector = new AccountSelector();
	
	public List<Account> getAccountBySetIds(Set<Id> accountIds){
		return accountSelector.selectById(accountIds);	
	}
    
    public List<Account> updateAccountContactIDs(String contactId,Set<Id> accountIds){
    	List<Account> accountObjects = getAccountBySetIds(accountIds);
    	Accounts accountDomainObject = new Accounts();
    	accountDomainObject.updateContacIdsInformation(accountObjects,contactId);
    	return getAccountBySetIds(accountId);
    }
    
}