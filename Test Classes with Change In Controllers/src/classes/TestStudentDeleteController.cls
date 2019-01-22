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
private class TestStudentDeleteController {

    static testMethod void myUnitTest() {
        Class__c classObject = new Class__c();
        classObject.Name__c = 'PT';
        classObject.Max_Size__c = 200;
        insert classObject;
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i =0; i<100;i++){
           Student__c studentObject = new Student__c();
           studentObject.Last_Name__c = 'TestName1';
           studentObject.Sex__c = 'F';
           studentObject.Class__c = classObject.Id; 
           studentList.add(studentObject);
        }
        insert studentList;
        List<Student__c> selectedStudentList = new List<Student__c>();
        for(Integer i=0; i<10 ; i++){
            selectedStudentList.add(studentList.get(i));
        }
        ApexPages.StandardSetController controller = new ApexPages.StandardSetController(selectedStudentList);
        StudentDeleteController studDelController = new StudentDeleteController(controller);
        studDelController.listOfStudents = selectedStudentList;
        System.debug(studDelController.listOfStudents);
        studDelController.setStudentIds();
        studDelController.getRecords();
        System.debug(studDelController.listOfStudents);
        studDelController.deleteStudents();
		List<Student__c> studentListCheck = [Select Id,Name,Class__c FROM Student__c where Last_Name__c Like 'TestName1'];
		System.assertEquals(studentList.size()-10, studentListCheck.size());
    }
   
}