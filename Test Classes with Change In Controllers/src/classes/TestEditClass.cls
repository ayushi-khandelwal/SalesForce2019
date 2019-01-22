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
private class TestEditClass {

    static testMethod void myUnitTest() {
        List<Class__c> classList = new List<Class__c>();
        for(Integer i=0;i<20;i++){
            Class__c classObject = new Class__c();
            classObject.Name = 'Test Class'+String.valueOf(i);
            classObject.Name__c = 'Test Class Name'+String.valueOf(i);
            classList.add(classObject);
        }
        insert classList;
        ApexPages.StandardController control = new ApexPages.StandardController(classList.get(0));
        ManageClassExtension2 manageClassExtension = new ManageClassExtension2(control);
        manageClassExtension.setCon = new ApexPages.StandardSetController(classList);
        
        EditClassExtension editClassExtension =  new EditClassExtension(control);
        editClassExtension.classId = classList.get(0).Id;
        editClassExtension.editTheClass();
        editClassExtension.classObject.Name__c = 'Test Case Change';
        editClassExtension.saveTheClassObject();
        
        List<Class__c> classObjectCheckList = [SELECT Id, Name,Name__c FROM Class__c WHERE ID=:editClassExtension.classId];
        if(classObjectCheckList!=null && classObjectCheckList.size()>0){
            System.assertEquals(classList.get(0).Id,classObjectCheckList.get(0).id);
        	System.assertNotEquals(classList.get(0).Name__c,classObjectCheckList.get(0).Name__c);
        	System.assertEquals('Test Case Change',classObjectCheckList.get(0).Name__c);
        }
    }
    
    
    static testMethod void myUnitTest2() {
        List<Class__c> classList = new List<Class__c>();
        for(Integer i=0;i<20;i++){
            Class__c classObject = new Class__c();
            classObject.Name = 'Test Class'+String.valueOf(i);
            classObject.Name__c = 'Test Class Name'+String.valueOf(i);
            classList.add(classObject);
        }
        insert classList;
        ApexPages.StandardController control = new ApexPages.StandardController(classList.get(0));
        ManageClassExtension2 manageClassExtension = new ManageClassExtension2(control);
        manageClassExtension.setCon = new ApexPages.StandardSetController(classList);
        
        EditClassExtension editClassExtension =  new EditClassExtension(control);
        editClassExtension.classId = classList.get(0).Id;
        editClassExtension.deleteTheClass();
        
        List<Class__c> classObjectCheckList = [SELECT Id, Name,Name__c FROM Class__c WHERE ID=:editClassExtension.classId];
       	System.assertEquals(0,classObjectCheckList.size());
    }
}