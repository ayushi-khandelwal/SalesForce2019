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
private class TestAccountListController2 {
    
    //public static List<Account> accountList = new List<Account>();
    
    static testMethod void myUnitTest() {
        
        List<Account> accountList = new List<Account>();
        for(Integer i = 0; i < 18 ; i++){
            Account testAccount = new Account();
            testAccount.Name='Test Account Name'+i ;
            testAccount.BillingCountry = 'Us'+i;
            testAccount.BillingState = 'Tex';
            testAccount.BillingCity = 'Misippi';
            
            accountList.add(testAccount);
        }
        insert accountList;
        
        Test.StartTest();
        PageReference pageRef = Page.Account_List_Page; // Add your VF page Name here
        Test.setCurrentPage(pageRef);
        
        //ApexPages.StandardSetController controller =  new ApexPages.StandardSetController(accountList);
        
        AccountListFilterController2 testAccPlan = new AccountListFilterController2();
        testAccPlan.searchAccount();
        List<Account> accs = testAccPlan.getAccountList();
        System.assertEquals(AccountListFilterController2.size, accs.size(), '');
        
        Test.StopTest();
    }
    
    static testMethod void myUnitTest2() {
        
        List<Account> accountList = new List<Account>();
        for(Integer i = 0; i < 18 ; i++){
            Account testAccount = new Account();
            testAccount.Name='Test Account Name'+i ;
            testAccount.BillingCountry = 'Us'+i;
            testAccount.BillingState = 'Tex';
            testAccount.BillingCity = 'Misippi';
            
            accountList.add(testAccount);
        }
        insert accountList;
        
        Test.StartTest();
        PageReference pageRef = Page.Account_List_Page; // Add your VF page Name here
        Test.setCurrentPage(pageRef);
        
        //ApexPages.StandardSetController controller =  new ApexPages.StandardSetController(accountList);
        
        AccountListFilterController2 testAccPlan = new AccountListFilterController2();
        testAccPlan.billingCountry = 'Us1';
        testAccPlan.searchAccount();
        List<Account> accs = testAccPlan.getAccountList();
        System.debug(accs);
        System.assertEquals(5, accs.size(), 'Only Five Data Exists For Country Us1 for the first page.');
        Test.StopTest();
    }
    
    static testMethod void myUnitTest3() {
        
        List<Account> accountList = new List<Account>();
        for(Integer i = 0; i < 18 ; i++){
            Account testAccount = new Account();
            testAccount.Name='Test Account Name'+i ;
            testAccount.BillingCountry = 'Us'+i;
            testAccount.BillingState = 'Tex';
            testAccount.BillingCity = 'Misippi';
            
            accountList.add(testAccount);
        }
        insert accountList;
        
        Test.StartTest();
        PageReference pageRef = Page.Account_List_Page;
        Test.setCurrentPage(pageRef);
        
        AccountListFilterController2 testAccPlan = new AccountListFilterController2();
        testAccPlan.billingCountry = 'Us12';
        testAccPlan.billingState = 'Te';
        testAccPlan.searchAccount();
        List<Account> accs = testAccPlan.getAccountList();
        System.debug(accs);
        System.assertEquals(1, accs.size(), 'Only One Data Exist For Country Us12 and State Te for the first page.');
        Test.StopTest();
    }
    
}