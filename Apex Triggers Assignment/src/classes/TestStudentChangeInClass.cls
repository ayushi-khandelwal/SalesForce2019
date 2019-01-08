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
private class TestStudentChangeInClass {

    static testMethod void myUnitTest() {
			Class__c classObject = new Class__c();
			classObject.Name__c = 'PT';
			classObject.Max_Size__c = 5;
			insert classObject;
			
			Class__c classObject2 = new Class__c();
			classObject2.Name__c = 'Chemistry';
			classObject2.Max_Size__c = 5;
			insert classObject2;
			
			Student__c studentObject = new Student__c();
			studentObject.Last_Name__c = 'TestName1';
			studentObject.Sex__c = 'F';
			studentObject.Class__c = classObject.Id;
			insert studentObject;
			
			Student__c studentObject3 = new Student__c();
			studentObject3.Last_Name__c = 'TestName3';
			studentObject3.Sex__c = 'F';
			studentObject3.Class__c = classObject.Id;
			insert studentObject3;
			
			Student__c studentObject2 = new Student__c();
			studentObject2.Last_Name__c = 'TestName2';
			studentObject2.Sex__c = 'F';
			studentObject2.Class__c = classObject2.Id;
			insert studentObject2;
			
			studentObject3.Class__c = classObject2.Id;
			
			try{
				update(studentObject3);  
			}catch(DMLException e){
			    System.debug('A DML exception has occurred: ' +e.getMessage());
			    System.debug(e.getMessage().contains('Student can\'t be added, Class reached Max Size.'));
			}
			
			Class__c class1 = [Select Number_Of_Pupils__c From Class__c where Name__c = 'PT'];
			Class__c class2 = [Select Number_Of_Pupils__c From Class__c where Name__c = 'Chemistry'];
			
			System.assertEquals(1,class1.Number_Of_Pupils__c);
			System.assertEquals(2,class2.Number_Of_Pupils__c);    
    }
    
     static testMethod void myUnitTest2() {
     		Class__c classObject = new Class__c();
			classObject.Name__c = 'PT';
			classObject.Max_Size__c = 1;
			insert classObject;
			
			Class__c classObject2 = new Class__c();
			classObject2.Name__c = 'Chemistry';
			classObject2.Max_Size__c = 1;
			insert classObject2;
			
			Student__c studentObject = new Student__c();
			studentObject.Last_Name__c = 'TestName1';
			studentObject.Sex__c = 'F';
			studentObject.Class__c = classObject.Id;
			insert studentObject;
			
			Student__c studentObject3 = new Student__c();
			studentObject3.Last_Name__c = 'TestName3';
			studentObject3.Sex__c = 'F';
			studentObject3.Class__c = classObject2.Id;
			insert studentObject3;
			
			studentObject3.Class__c = classObject.Id;
			
			try{
				update(studentObject3);  
			}catch(DMLException e){
			    System.debug('A DML exception has occurred: ' +e.getMessage());
			    System.assertEquals(true,e.getMessage().contains('Student can\'t be added, Class reached Max Size.'));
			}
     		
     		Class__c class1 = [Select Number_Of_Pupils__c From Class__c where Name__c = 'PT'];
			Class__c class2 = [Select Number_Of_Pupils__c From Class__c where Name__c = 'Chemistry'];
			
			System.assertEquals(1,class1.Number_Of_Pupils__c);
			System.assertEquals(1,class2.Number_Of_Pupils__c);    
     }
    
}