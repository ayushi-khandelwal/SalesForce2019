public interface AccountServiceI {
    
    List<Account> updateAccountContactIDs(Id contactId);
    
    List<Account> getAccountBySetIds(Set<Id> accountIds);
}