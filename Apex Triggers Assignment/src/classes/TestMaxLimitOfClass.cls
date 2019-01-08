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
private class TestMaxLimitOfClass {

    static testMethod void myUnitTest() {
		Class__c classObject = new Class__c();
		classObject.Name__c = 'Biology';
		classObject.Max_Size__c = 1;
		insert classObject;
		
		Student__c studentObject = new Student__c();
		studentObject.Last_Name__c = 'TestName1';
		studentObject.Sex__c = 'F';
		studentObject.Class__c = classObject.Id;
		insert studentObject;
		
		Student__c studentObject2 = new Student__c();
		studentObject2.Last_Name__c = 'TestName2';
		studentObject2.Sex__c = 'F';
		studentObject2.Class__c = classObject.Id;
	
		try{
			insert studentObject2;    
		}catch(DMLException e){
		    System.debug('A DML exception has occurred: ' +e.getMessage());
		    System.assertEquals(true,e.getMessage().contains('Class has Reached its Maximum Strength.'));
		}
        
    }
}