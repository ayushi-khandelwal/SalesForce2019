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
private class TestContactListExtension {

    static testMethod void myUnitTest() {
        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opportunity';
        opp.StageName = 'Closed Won';
        opp.CloseDate = Date.newInstance(2020, 1, 2);
        insert opp;
        ApexPages.StandardController controller = new ApexPages.StandardController(opp);
       List<Contact> contactList = new List<Contact>();
        for(Integer i=0;i<22;i++){
            Contact conctObj = new Contact();
            conctObj.LastName = 'Test Contact'+String.valueOf(i);
            contactList.add(conctObj);
        }
        insert contactList;
        
        ContactListExtension2 contactListExt = new ContactListExtension2(controller);
        contactListExt.name = 'Test Contact1';
        contactListExt.setContactList();
        List<Contact> contactListSearched = contactListExt.contactList;
        System.assertEquals(11,contactListExt.contactList.size());
        contactListExt.getItems();
        
        contactListExt.ContactId = contactListSearched.get(0).Id;
        contactListExt.saveBillToContact();
        
        List<Opportunity> opps = [SELECT Id,BillToContact__c FROM Opportunity WHERE Name='Test Opportunity'];
        
        System.assertEquals(contactListExt.ContactId,opps.get(0).BillToContact__c,'Bill TO Contact Added Successfully.');
    }
    
    static testMethod void myUnitTest2() {
        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opportunity';
        opp.StageName = 'Closed Won';
        opp.CloseDate = Date.newInstance(2020, 1, 2);
        insert opp;
        ApexPages.StandardController controller = new ApexPages.StandardController(opp);
       List<Contact> contactList = new List<Contact>();
        for(Integer i=0;i<22;i++){
            Contact conctObj = new Contact();
            conctObj.LastName = 'Test Contact'+String.valueOf(i);
            contactList.add(conctObj);
        }
        insert contactList;
        
        ContactListExtension2 contactListExt = new ContactListExtension2(controller);
        contactListExt.name = 'Test Contact1';
        contactListExt.setContactList();
        List<Contact> contactListSearched = contactListExt.contactList;
        System.assertEquals(11,contactListExt.contactList.size());
        contactListExt.getItems();
        
        contactListExt.ContactId = contactListSearched.get(0).Id;
        contactListExt.cancelBillToContact();
        
        List<Opportunity> opps = [SELECT Id,BillToContact__c FROM Opportunity WHERE Name='Test Opportunity'];
        
        System.assertNotEquals(contactListExt.ContactId,opps.get(0).BillToContact__c,'Action Canceled, BillToContact not Equal to selected radio button.');
    }
    
    static testMethod void myUnitTest3() {
        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opportunity';
        opp.StageName = 'Closed Won';
        opp.CloseDate = Date.newInstance(2020, 1, 2);
        insert opp;
        
       List<Contact> contactList = new List<Contact>();
        for(Integer i=0;i<22;i++){
            Contact conctObj = new Contact();
            conctObj.LastName = 'Test Contact'+String.valueOf(i);
            contactList.add(conctObj);
        }
        insert contactList;
        opp.BillToContact__c = contactList.get(0).Id;
        ApexPages.StandardController controller = new ApexPages.StandardController(opp);
        ContactListExtension2 contactListExt = new ContactListExtension2(controller);
        contactListExt.name = 'Test Contact0';
        contactListExt.setContactList();
        List<Contact> contactListSearched = contactListExt.contactList;
        System.assertEquals(1,contactListExt.contactList.size());
        contactListExt.getItems();
        
        contactListExt.ContactId = contactListSearched.get(0).Id;
        contactListExt.clearBillToContact();
        
        List<Opportunity> opps = [SELECT Id,BillToContact__c FROM Opportunity WHERE Name='Test Opportunity'];
        
        System.assertNotEquals(contactListExt.ContactId,opps.get(0).BillToContact__c,'BillToContact Cleared From opportunity record.');
    }
}