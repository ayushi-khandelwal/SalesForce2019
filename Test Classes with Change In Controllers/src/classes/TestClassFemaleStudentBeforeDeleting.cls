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
private class TestClassFemaleStudentBeforeDeleting {

    static testMethod void myUnitTest() {
        Class__c classObject = new Class__c();
		classObject.Name__c = 'Biology';
		classObject.Max_Size__c = 10;
		insert classObject;
		
		List<Student__c> studentList = new List<Student__c>();
		Student__c studentObject = new Student__c();
		studentObject.Last_Name__c = 'TestName1';
		studentObject.Sex__c = 'F';
		studentObject.Class__c = classObject.Id;
		studentList.add(studentObject);
		
		Student__c studentObject2 = new Student__c();
		studentObject2.Last_Name__c = 'TestName2';
		studentObject2.Sex__c = 'F';
		studentObject2.Class__c = classObject.Id;
		studentList.add(studentObject2);
		
		Student__c studentObject3 = new Student__c();
		studentObject3.Last_Name__c = 'TestName2';
		studentObject3.Sex__c = 'F';
		studentObject3.Class__c = classObject.Id;
		studentList.add(studentObject3);
		
		insert studentList;
		
		try{
			delete classObject;    
		}catch(DMLException e){
		    System.debug('A DML exception has occurred: ' +e.getMessage());
		    System.assertEquals(true,e.getMessage().contains('Class can\'t be deleted with more than 2 Female Students.'));
		}
    }
    
    static testMethod void myUnitTest2(){
    	Class__c classObject = new Class__c();
		classObject.Name__c = 'Biology';
		classObject.Max_Size__c = 10;
		insert classObject;
		
		List<Student__c> studentList = new List<Student__c>();
		Student__c studentObject = new Student__c();
		studentObject.Last_Name__c = 'TestName1';
		studentObject.Sex__c = 'F';
		studentObject.Class__c = classObject.Id;
		studentList.add(studentObject);
		
		Student__c studentObject2 = new Student__c();
		studentObject2.Last_Name__c = 'TestName2';
		studentObject2.Sex__c = 'F';
		studentObject2.Class__c = classObject.Id;
		studentList.add(studentObject2);
		
		insert studentList;
		Boolean flag  = false;
		try{
			delete classObject;    
		}catch(DMLException e){
		    flag =true;
		    System.debug('A DML exception has occurred: ' +e.getMessage());
		}
		if(!flag){
			System.assertEquals(true,true);
		}
    }
    
    static testmethod void myUnitTestCaseForBulkDeletion(){
        List<Class__c> classList = new List<Class__C>();
        for(Integer i=0; i<500;i++){
            Class__c classObject = new Class__c();
			classObject.Name__c = 'Biology'+String.valueOf(i);
			classObject.Max_Size__c = 3;
            classList.add(classObject);
        }
        insert classList;
        List<Student__c> studentList = new List<Student__c>();
        for(Class__c classObj : classList){
            for(Integer i =0 ;i<3;i++){
                Student__c studentObject = new Student__c();
				studentObject.Last_Name__c = 'TestName'+String.valueOf(i);
				studentObject.Sex__c = 'F';
				studentObject.Class__c = classObj.Id;
                studentList.add(studentObject);
            }
        }
        insert studentList;
        Boolean deletionFailed = false;
        try{
            delete classList;
        }catch(DMLException e){
            deletionFailed = true;
            System.assertEquals(true,e.getMessage().contains('Class can\'t be deleted with more than 2 Female Students.'));
        }
        System.assertEquals(true, deletionFailed);
    }
    
    static testmethod void myUnitTestCaseForBulkDeletion2(){
        List<Class__c> classList = new List<Class__C>();
        for(Integer i=0; i<500;i++){
            Class__c classObject = new Class__c();
			classObject.Name__c = 'Biology'+String.valueOf(i);
			classObject.Max_Size__c = 3;
            classList.add(classObject);
        }
        insert classList;
        List<Student__c> studentList = new List<Student__c>();
        for(Class__c classObj : classList){
            for(Integer i =0 ;i<3;i++){
                Student__c studentObject = new Student__c();
				studentObject.Last_Name__c = 'TestName'+String.valueOf(i);
				studentObject.Sex__c = 'M';
				studentObject.Class__c = classObj.Id;
                studentList.add(studentObject);
            }
        }
        insert studentList;
        Boolean deletionFailed = false;
        try{
            delete classList;
        }catch(DMLException e){
            deletionFailed = true;
        }
        System.assertEquals(false, deletionFailed);
    }
}