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
@isTest(SeeAllData = true)
private class TestTeacherHindiInsertAndUpdate {
    
    static testMethod void myUnitTestForUpdation() {
        Contact contactObject = [Select Id,LastName,Subjects__c From Contact where Id = '00310000014NBxZAAW'];
        contactObject.LastName = 'Gandhi';
        contactObject.Subjects__c = contactObject.Subjects__c + ';' + 'English';
        try{
            update contactObject;
        }catch(DMLException e){
            System.debug('A DML exception has occurred 1: ' +e.getMessage());
            System.assertEquals(true,e.getMessage().contains('Teacher is not allowed to Update with Hindi as a Subject'));
        }
    }
    
    static testMethod void myUnitTestForInsertion() {
        Contact contactObject = new Contact();
        contactObject.LastName = 'Gandhi';
        contactObject.Subjects__c = 'Hindi';
        contactObject.Subjects__c = contactObject.Subjects__c + ';' + 'English';
        try{
            insert contactObject;
        }catch(DMLException e){
            System.debug('A DML exception has occurred 2: ' +e.getMessage());
            System.assertEquals(true,e.getMessage().contains('Teacher is not allowed to Insert with Hindi as a Subject'));
        }
    }
    
    static testMethod void myUnitTestForBulkInsertion(){
        List<Contact> contactList = new List<Contact>();
        for(Integer i =0 ; i<200;i++){
            Contact contactObject = new Contact();
            contactObject.LastName = 'Gandhi'+String.valueOf(i);
            contactObject.Subjects__c = 'Hindi';
            contactList.add(contactObject);
        }
        try{
            insert contactList;
        }catch(DMLException e){
            System.assertEquals(true,e.getMessage().contains('Teacher is not allowed to Insert with Hindi as a Subject'));
        }
    }
    
     static testMethod void myUnitTestForBulkUpdation(){
        List<Contact> contactList = new List<Contact>();
        for(Integer i =0 ; i<200;i++){
            Contact contactObject = new Contact();
            contactObject.LastName = 'Gandhi'+String.valueOf(i);
            contactObject.Subjects__c = 'English';
            contactList.add(contactObject);
        }
        insert contactList;
         for(Contact cont: contactList){
             cont.Subjects__c=cont.Subjects__c + ';' + 'Hindi';
         }
        try{
            update contactList;
        }catch(DMLException e){
            System.debug('A DMLExcetion has Occured cont'+e.getMessage());
            System.assertEquals(true,e.getMessage().contains('Teacher is not allowed to Update with Hindi as a Subject'));
        }
    }
    
    
}