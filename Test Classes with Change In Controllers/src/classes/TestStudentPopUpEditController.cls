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
private class TestStudentPopUpEditController {

    static testMethod void myUnitTest() {
        Class__c classObject = new Class__c();
        classObject.Name__c = 'PT';
        classObject.Max_Size__c = 200;
        insert classObject;
        
        Student__c studentObject = new Student__c();
        studentObject.Last_Name__c = 'TestName1';
        studentObject.Sex__c = 'F';
        studentObject.Class__c = classObject.Id;
        insert studentObject;
        
        Test.StartTest();
        PageReference pageRef = new PageReference('Student_Pop_Up_Edit?id='+studentObject.id);
        Test.setCurrentPage(pageRef);

        StudentPopUpEditController studPopUpController = new StudentPopUpEditController(new ApexPages.StandardController(studentObject));
        studPopUpController.studentToBeAdded.Id = studentObject.Id;
        studPopUpController.studentToBeAdded.Name = 'Test name Changed';
        studPopUpController.studentToBeAdded.email__c = 'xyz@mail.com';
        studPopUpController.studentToBeAdded.Last_Name__c = 'Test last name Changed';
        studPopUpController.saveStudent();
        Student__c studObject = [SELECT Id, Name,Last_Name__c,email__c FROM Student__c WHERE Name LIKE 'Test name Changed%' LIMIT 1];
        
        System.assertEquals('Test name Changed',studObject.Name);
        System.assertEquals('xyz@mail.com',studObject.email__c);
        System.assertEquals('Test last name Changed',studObject.Last_Name__c);
    }
}