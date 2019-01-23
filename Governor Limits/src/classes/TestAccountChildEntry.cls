/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestAccountChildEntry {

    static testMethod void myUnitTestForInsertion() {
      	//List<Account> accountList = [Select Id, Name from Account Limit 1];
      	List<Account> accountList = new List<Account>();
        for(Integer i=0;i<100;i++){
            Account acct = new Account();
            acct.Name='Test Account'+String.valueOf(i);
            accountList.add(acct);
        }
        insert accountList;
        List<Account> accountListToBeInserted = new List<Account>();
        for(Account account : accountList){
            for(Integer i=0;i<10;i++){
                Account accountToInsert = new Account();
                accountToInsert.Name = 'Test Insert Account'+String.valueOf(i);
                accountToInsert.ParentId = account.Id;
                accountListToBeInserted.add(accountToInsert);
            }
        }
        Boolean  insertionFailed= false;
        try{
            insert accountListToBeInserted;
        }catch(DMLException e){
            System.debug(e.getMessage());
            insertionFailed= true;
        }
        System.assertEquals(false,insertionFailed);
        List<Account> accountListToCheck = [SELECT Id, Name, Child_Count__c FROM Account WHERE Id In:accountList];
        for(Account accountToCheck : accountListToCheck){
            System.assertEquals(10,accountToCheck.Child_Count__c);
        }
    }
    
    static testMethod void myUnitTestForUpdation() {
      	List<Account> accountList = new List<Account>();
        for(Integer i=0;i<100;i++){
            Account acct = new Account();
            acct.Name='Test Account'+String.valueOf(i);
            accountList.add(acct);
        }
        insert accountList;
        List<Account> accountListToBeInserted = new List<Account>();
        for(Account account : accountList){
            for(Integer i=0;i<10;i++){
                Account accountToInsert = new Account();
                accountToInsert.Name = 'Test Insert Account'+String.valueOf(i);
                accountToInsert.ParentId = account.Id;
                accountListToBeInserted.add(accountToInsert);
            }
        }
        Boolean  insertionFailed= false;
        try{
            insert accountListToBeInserted;
        }catch(DMLException e){
            System.debug(e.getMessage());
            insertionFailed= true;
        }
        System.assertEquals(false,insertionFailed);
        List<Account> accountListNew = [SELECT id,ParentID FROM Account WHERE Id IN: accountListToBeInserted];
        Account newAcct = new Account();
        newAcct.Name='Test Account For Updation';
        insert newAcct;
        for(Account account : accountListNew){
        	account.ParentId = newAcct.Id;     
        }
        try{
            System.assertEquals(accountListNew[0].ParentId, newAcct.Id);
            update accountListNew;
        }catch(DMLException e){
            System.debug(e);
            insertionFailed= true;
        }
        System.assertEquals(false,insertionFailed);
        Account accountToCheck = [SELECT Id, Name, Child_Count__c FROM Account WHERE Name='Test Account For Updation' Limit 1];
        System.assertEquals(1000,accountToCheck.Child_Count__c);
        List<Account> accountListToCheckForUpdation = [SELECT Id,Name,Child_Count__c FROM Account WHERE ID In:accountList];
        for(Account acct : accountListToCheckForUpdation){
             System.assertEquals(0,acct.Child_Count__c);
         }
    }
    
    static testMethod void myUnitTestForUpdation2() {
      	List<Account> accountList = new List<Account>();
        for(Integer i=0;i<1;i++){
            Account acct = new Account();
            acct.Name='Test Account'+String.valueOf(i);
            accountList.add(acct);
        }
        insert accountList;
        List<Account> accountListToBeInserted = new List<Account>();
        for(Account account : accountList){
            for(Integer i=0;i<1;i++){
                Account accountToInsert = new Account();
                accountToInsert.Name = 'Test Insert Account'+String.valueOf(i);
                accountToInsert.ParentId = account.Id;
                accountListToBeInserted.add(accountToInsert);
            }
        }
        Boolean  insertionFailed= false;
        try{
            insert accountListToBeInserted;
        }catch(DMLException e){
            System.debug(e.getMessage());
            insertionFailed= true;
        }
        System.assertEquals(false,insertionFailed);
        List<Account> accountListNew = [SELECT id,ParentID FROM Account WHERE Id IN: accountListToBeInserted];
        Account newAcct = new Account();
        newAcct.Name='Test Account For Updation';
        insert newAcct;
        for(Account account : accountListNew){
        	account.ParentId = newAcct.Id;     
        }
        try{
            System.assertEquals(accountListNew[0].ParentId, newAcct.Id);
            update accountListNew;
        }catch(DMLException e){
            System.debug(e);
            insertionFailed= true;
        }
        System.assertEquals(false,insertionFailed);
        Account accountToCheck = [SELECT Id, Name, Child_Count__c FROM Account WHERE Name='Test Account For Updation' Limit 1];
        System.assertEquals(1,accountToCheck.Child_Count__c);
        List<Account> accountListToCheckForUpdation = [SELECT Id,Name,Child_Count__c FROM Account WHERE ID In:accountList];
        for(Account acct : accountListToCheckForUpdation){
             System.assertEquals(0,acct.Child_Count__c);
        }
    }
    
    
    static testMethod void myUnitTestCaseForDeletion(){
        List<Account> accountList = new List<Account>();
        for(Integer i=0;i<100;i++){
            Account acct = new Account();
            acct.Name='Test Account'+String.valueOf(i);
            accountList.add(acct);
        }
        insert accountList;
        List<Account> accountListToBeInserted = new List<Account>();
        for(Account account : accountList){
            for(Integer i=0;i<10;i++){
                Account accountToInsert = new Account();
                accountToInsert.Name = 'Test Insert Account'+String.valueOf(i);
                accountToInsert.ParentId = account.Id;
                accountListToBeInserted.add(accountToInsert);
            }
        }
        Boolean  insertionFailed= false;
        try{
            insert accountListToBeInserted;
        }catch(DMLException e){
            System.debug(e.getMessage());
            insertionFailed= true;
        }
        System.assertEquals(false,insertionFailed);
        Boolean deletionFailed = false;
        try{
            delete accountListToBeInserted;
        }catch(DMLException e){
            System.debug(e.getMessage());
            deletionFailed = true;
        }
        List<Account> accountListToCheck = [SELECT Id, Name, Child_Count__c FROM Account WHERE Id In:accountList];
        for(Account accountToCheck : accountListToCheck){
            System.assertEquals(0,accountToCheck.Child_Count__c);
        } 
    }
}