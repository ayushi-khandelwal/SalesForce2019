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
@isTest(SeeAllData=true)
private class TestUpdateAccountContactIDs {

    static testMethod void myUnitTest() {
        AccountService accountServiceObject = new AccountService();
		Id contactId = Id.valueOf('00310000014StwmAAC');
        Set<Id> contactSet = new Set<Id>();
        contactSet.add(contactId);
       	List<Account>x = accountServiceObject.updateAccountContactIDs(contactId);
        String contactIds = x.get(0).ContactIDs__c ;
        List<String> contactsSplitted = contactIds.split(',');
		System.assertEquals(3,contactsSplitted.size());
    }
    
     static testMethod void myUnitTest2() {
        AccountService accountServiceObject = new AccountService();
		Id contactId = Id.valueOf('00310000014StwjAAC');
        Set<Id> contactSet = new Set<Id>();
        contactSet.add(contactId);
       	List<Account>x = accountServiceObject.updateAccountContactIDs(contactId);
        String contactIds = x.get(0).ContactIDs__c ;
        List<String> contactsSplitted = contactIds.split(',');
		System.assertEquals(1,contactsSplitted.size());
    }
}