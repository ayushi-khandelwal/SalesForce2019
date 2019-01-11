public with sharing class AccountServiceImpl implements IAccountService{
    
    AccountsSelector accountSelectorObject = new AccountsSelector();
	
	ContactsSelector contactSelectorObject = new ContactsSelector();
	
	public static AccountServiceImpl getInstanceOf(){
		return new AccountServiceImpl();	
	}
	
	public List<Account> getAccountBySetIds(Set<Id> accountIds){
		return accountSelectorObject.getAccountWithContacts(accountIds);	
	}
    
    public List<Account> updateAccountContactIDs(Id contactId){
    	Set<Id> contactSet = new Set<Id>();
    	contactSet.add(contactId);
    	List<Account> accountObjects = accountSelectorObject.getAccountByContactId(contactSet);
    	Accounts accountDomainObject = new Accounts(accountObjects);
    	accountDomainObject.updateContacIdsInformation(accountObjects,contactId);
    	return accountSelectorObject.getAccountByContactId(contactSet);
    }
    
    public List<Account> filteredAccountListBy(String billingCountry,String billingState, String billingCity){
    	return accountSelectorObject.getFilteredAccounts(AccountsHelper.getConditionString(billingCountry,billingState,billingCity),AccountsHelper.getAccountFields());
    }

}