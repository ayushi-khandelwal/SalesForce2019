public with sharing class AccountsSelector extends fflib_SObjectSelector implements AccountsSelectorInterface{
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
        	Account.Id,
        	Account.Name,
        	Account.Description,
        	Account.AccountNumber,
        	Account.ContactIDs__c
             };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Account.sObjectType;
    }
    
    public List<Account> selectById(Set<ID> idSet) {
        return (List<Account>) selectSObjectsById(idSet);
    }
    
    public List<Account> getAccountWithContacts(Set<ID> idSet){
    	List<Account> accountList = [Select Id,Name,Description,ContactIDs__c,(Select ID,Name From Contacts) From Account Where Id In : idSet];
    	return accountList;
    }
    
    public List<Account> getAccountByContactId(Set<ID> contactIdSet){
    	List<Account> accountList = [Select Id,Name,Description,ContactIDs__c,(Select ID,Name From Contacts) From Account Where Id In (SELECT AccountId FROM Contact WHERE Id = :contactIdSet)];
    	return accountList;
    }
}