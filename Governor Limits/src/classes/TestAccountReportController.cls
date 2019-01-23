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
private class TestAccountReportController {
    
    static testMethod void myUnitTest() {
        AccountReportController acctRepController = new AccountReportController();
        List<AccountReportController.Report> reportList = acctRepController.getRecords();
        System.assertEquals(10,reportList.size());
    }
    
    @testSetup
    private static void insertData(){
        List<Account> accountList = new List<Account>();
        for(Integer i =0;i<10;i++){
            Account acct = new Account();
            acct.Name= 'Test Account'+String.valueOf(i);
                accountList.add(acct);
        }
        insert accountList;
        List<Opportunity> oppList = new List<Opportunity>();
        for(Account account:accountList){
            for(Integer i=0;i<10;i++){
                Opportunity opp = new Opportunity();
                Date date1 = Date.newInstance(2016, 02, 5);
                opp.Name = 'Test Opp';
                opp.CloseDate = date1;
                opp.StageName = 'Prospecting';
                opp.Custom_Status__c = 'New';
                opp.AccountId = account.Id;
                oppList.add(opp);
            }
        }
        insert oppList;
    }
}