public with sharing class ContactService implements IContactService {
    
    public List<Contact> getContacts(Set<Id> contactIds){
    	return ContactServiceImpl.getInstanceOf().getContacts(contactIds);
    }
    
    public List<Contact> getContactByName(String contactName){
    	return ContactServiceImpl.getInstanceOf().getContactByName(contactName);
    }
}