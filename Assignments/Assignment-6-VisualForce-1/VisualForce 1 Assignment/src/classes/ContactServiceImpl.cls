public with sharing class ContactServiceImpl implements IContactService{
    
    ContactsSelector contactSelectorObject = new ContactsSelector();
    
    public static ContactServiceImpl getInstanceOf(){
    	return new ContactServiceImpl();
    }
    
    public List<Contact> getContacts(Set<Id> contactIds){
    	return contactSelectorObject.selectById(contactIds);
    }
    
    public List<Contact> getContactByName(String contactName){
    	return contactSelectorObject.selectContactsByName(ContactsHelper.getContactFields(),ContactsHelper.getConditionString(contactName));
    }
}