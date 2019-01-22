@isTest
public with sharing class TestDataListController {
    
    static testMethod void myUnitTest() {
        DataListController dataListController = new DataListController();
        dataListController.objectName = 'Opportunity';
        dataListController.fieldParams = 'Id,Name';
        dataListController.pageSize = 5;
        List<Opportunity> oppListCheck = dataListController.getRecords();
        System.debug(oppListCheck.size());
        System.assertEquals(dataListController.pageSize, oppListCheck.size());
    }
    
    static testMethod void myUnitTest2 (){
        DataListController dataListController = new DataListController();
        dataListController.objectName = 'Opportunity';
        dataListController.fieldParams = 'Id,Name';
        dataListController.pageSize = 5;
        List<Opportunity> oppListCheck = dataListController.getRecords();
        System.debug(oppListCheck.size());
        System.assertEquals(dataListController.pageSize, oppListCheck.size());
        dataListController.sortByField = 'Name';
        dataListController.sortByField();
        List<Opportunity> oppListSortedByName = dataListController.getRecords();
        System.assertEquals(oppListCheck.size(),oppListSortedByName.size());
        System.assertEquals('Test Opp0',oppListSortedByName.get(0).Name);
    }
    
    @testSetup
    public static void insertData(){
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i=0;i<100;i++){
            Opportunity opp = new Opportunity();
        	Date date1 = Date.newInstance(2016, 02, 5);
        	opp.Name = 'Test Opp'+String.valueOf(i);
        	opp.CloseDate = date1;
        	opp.StageName = 'Prospecting';
        	opp.Custom_Status__c = 'New';
            oppList.add(opp);
        }
        insert oppList;
    }
}