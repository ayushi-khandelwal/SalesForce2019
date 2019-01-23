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
    	return accountSelectorObject.getFilteredAccounts(getConditionString(billingCountry,billingState,billingCity),getAccountFields());
    }
    
     public Set<String> getAccountFields(){
    	Set<String> accountFields =  new Set<String>{'Name','AnnualRevenue','AccountNumber','BillingCountry'};
    	return accountFields;
    }
    
    public String getConditionString(String billingCountry,String billingState, String billingCity){
    	String condition = '';
    	if(!('').equals(billingCountry)){
    		condition = condition + ' BillingCountry Like \''+billingCountry+'%\'';
    	}
    	if(!('').equals(billingCity)){
    		if(! ('').equals(condition)){
    			condition = condition + ' And';
    		}
 			condition = condition + ' BillingCity Like \''+billingCity+'%\'';   	
    	}
    	if(!('').equals(billingState)){
    		if(! ('').equals(condition)){
    			condition = condition + ' And';
    		}
 			condition = condition + ' BillingState Like \''+billingState+'%\'';   	
    	}
    	return condition;
    }
    
}