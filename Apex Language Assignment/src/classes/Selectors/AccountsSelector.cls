public with sharing class AccountsSelector extends fflib_SObjectSelector implements AccountsSelectorInterface{
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
        	Account.Id,
        	Account.Name,
        	Account.Description,
        	Account.ContactIDs,
        	Account.Contacts
             };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Account.sObjectType;
    }
    
    public List<Account> selectById(Set<ID> idSet) {
        return (List<Account>) selectSObjectsById(idSet);
    }
}