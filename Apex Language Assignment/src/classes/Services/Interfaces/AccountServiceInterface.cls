public with sharing interface AccountServiceInterface {
    
    List<Account> updateAccountContactIDs(String contactId,Set<Id> accountIds);
}