public interface IAccountService {
    
    List<Account> updateAccountContactIDs(Id contactId);
    
    List<Account> getAccountBySetIds(Set<Id> accountIds);
    
    List<Account> filteredAccountListBy(String billingCountry,String billingState, String billingCity);
}