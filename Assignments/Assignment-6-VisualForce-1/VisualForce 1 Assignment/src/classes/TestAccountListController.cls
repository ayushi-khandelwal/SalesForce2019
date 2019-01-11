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
private class TestAccountListController {

    static testMethod void myUnitTest() {
       Test.StartTest(); 
			PageReference pageRef = Page.Account_List_Page; // Add your VF page Name here
			Test.setCurrentPage(pageRef);
			
			ApexPages.StandardSetController controller;
			
			AccountListFilterController testAccPlan = new AccountListFilterController(controller);
			testAccPlan.searchAccount();
			
			
			testAccPlan.billingCity = 'Miss';
			testAccPlan.searchAccount();
			
			
			testAccPlan.nextPage();
			testAccPlan.nextPage();
			testAccPlan.nextPage();
			
			
			testAccPlan.billingCountry = 'Usa1';
			testAccPlan.searchAccount();
			
		Test.StopTest();
    }
    
      @testSetup
   public static void insertData(){
   		List<Account> accountList = new List<Account>();
   		for(Integer i = 0; i < 18 ; i++){
   			Account testAccount = new Account();
			testAccount.Name='Test Account'+i ;
			testAccount.BillingCountry = 'Usa'+i;
			testAccount.BillingState = 'Texas';
			testAccount.BillingCity = 'Missisippi';
			
			accountList.add(testAccount);
   		}
   		insert accountList;
	}
}