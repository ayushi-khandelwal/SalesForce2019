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
private class TestJsonStringGeneration {

    static testMethod void myUnitTest() {
         Test.StartTest();
        	Student__c student = [Select Id From Student__c Where Last_Name__c = 'Test___Student'];
            PageReference pageRef = Page.Student_Detail_PDF; // Add your VF page Name here
            pageRef.getParameters().put('id', student.Id);
            Test.setCurrentPage(pageRef);
            
            //ApexPages.StandardSetController controller =  new ApexPages.StandardSetController(accountList);
            JSONExtension.recordId = student.Id;
        	JSONExtension.setJson();
        	String jsonObject = JSONExtension.jsonObject;
        	System.assertEquals(true, jsonObject.contains(student.Id));
        	System.assertEquals(true, jsonObject.contains('Test___Name'));
        	System.assertEquals(true, jsonObject.contains('Test___Student'));
        Test.StopTest();
    }
    
    @TestSetUp
    public static void insertData(){
        Class__c classObject = new Class__c();
        classObject.Name = 'Test____Class';
        classObject.Name__c = 'Test____Class';
        classObject.Max_Size__c = 20;
        insert classObject;
        
        Student__c studentObject = new Student__c();
        studentObject.Name = 'Test___Name';
        studentObject.Last_Name__c = 'Test___Student';
        studentObject.Class__c = classObject.id;
        insert studentObject;
    }
}