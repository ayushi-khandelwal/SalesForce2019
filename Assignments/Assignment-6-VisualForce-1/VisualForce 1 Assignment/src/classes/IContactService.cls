public interface IContactService {
    
    List<Contact> getContacts(Set<Id> contactIds);
    
    List<Contact> getContactByName(String contactName);
}