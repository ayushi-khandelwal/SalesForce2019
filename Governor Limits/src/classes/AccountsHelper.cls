public with sharing class AccountsHelper {
    
    public static AccountsSelector accountSelectorObject = new AccountsSelector();
    
    public AccountsHelper(){
        
    }
    
    public static void updateParentAccountchildCounts(List<Account> records,Map<Id,Sobject> existingRecords,fflib_SObjectUnitOfWork uow){
        if(records!=null && records.size() > 0){
            List<Account> accountListToBeUpdated = new List<Account>();
            Set<Id> accountParentIdsToGet = new Set<Id>();
            for(Account accountObject : records){  
                Account accountToCompare = new Account();
                if(existingRecords!=null && existingRecords.size() > 0){
                    accountToCompare = (Account)existingRecords.get(accountObject.Id);
                }
                if(accountToCompare.Id != null){
                    if(accountToCompare.ParentId!=null  && accountToCompare.ParentId != accountObject.ParentId ){
                        accountParentIdsToGet.add(accountToCompare.ParentId);
                    }
                }
                if(accountObject.ParentId != null){
                    accountParentIdsToGet.add(accountObject.ParentId);
                }
            }
            Map<Id,Account> accountListMap = new Map<Id,Account>(accountSelectorObject.selectById(accountParentIdsToGet));
            for(Account account : accountListMap.values()){
                account.Child_Count__c = 0;
            }
            AggregateResult[] groupedResults;
            if(accountIdsToGet.size()>0){
                groupedResults = [SELECT count(Id)childCounts,ParentId FROM Account WHERE ParentId IN :accountParentIdsToGet group by ParentId ];
            }
            if(groupedResults!=null){
                for(AggregateResult aggResult: groupedResults){
                    accountListMap.get(Id.valueOf(String.valueOf(aggResult.get('ParentId')))).Child_Count__c = Integer.valueOf(aggResult.get('childCounts'));
            	}
            }
            for(Account account : accountListMap.values()){
                System.debug(account.Child_Count__c);
            }
            if(accountListMap.values().size()>0){
                uow.registerDirty(accountListMap.values()); 
            }
        }
    }
}