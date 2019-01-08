public with sharing class ContactsSelector extends fflib_SObjectSelector {
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
        	Contact.Id,
        	Contact.Name,
        	Contact.AccountID
             };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Contact.sObjectType;
    }
    
    public List<Contact> selectById(Set<ID> idSet) {
        return (List<Contact>) selectSObjectsById(idSet);
    }
    
    public List<Contact> selectContactById (List<ID> idSet){
    	List<Contact> listOfContact = [Select Id,AccountId From Contact Where Id In : idSet];
    	return listOfContact;
    }
}