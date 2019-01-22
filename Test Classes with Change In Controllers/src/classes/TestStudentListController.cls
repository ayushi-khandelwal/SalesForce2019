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
private class TestStudentListController {

    static testMethod void myUnitTest() {
        StudentListController studentListController = new StudentListController();
        studentListController.pageSize = 5;
        studentListController.setCon = null;
        List<Student__c> studentList = studentListController.getRecords();
        System.assertEquals( studentListController.pageSize,studentList.size());  
    }
   
    @testSetup
    public static void insertDate(){
        Class__c classObject = new Class__c();
        classObject.Name__c = 'PT';
        classObject.Max_Size__c = 100;
        insert classObject;
		List<Student__c> studentList = new List<Student__c>();
        for(Integer i =0; i<100;i++){
           Student__c studentObject = new Student__c();
           studentObject.Name='Test'+String.valueOf(i);
           studentObject.Last_Name__c = 'TestName1';
           studentObject.Sex__c = 'M';
           studentObject.Class__c = classObject.Id; 
           studentList.add(studentObject);
        }
        insert studentList;        
    }
}