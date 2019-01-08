public interface AccountsSelectorInterface {
    
    List<Account> getAccountWithContacts(Set<ID> idSet);
    List<Account> getAccountByContactId(Set<ID> contactIdSet);
}