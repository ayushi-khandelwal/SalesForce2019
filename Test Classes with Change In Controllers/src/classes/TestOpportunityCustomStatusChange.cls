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
private class TestOpportunityCustomStatusChange {

    static testMethod void myUnitTest() {
		Opportunity opp2 = [Select Custom_Status__c,(Select OpportunityId,TotalPrice From OpportunityLineItems) From Opportunity WHere Name = 'Test Opp'];
		System.debug(opp2.Custom_Status__c);
		System.debug(opp2.OpportunityLineItems.size());
		System.assertEquals(opp2.Custom_Status__c,'Reset');
		System.assertEquals(opp2.OpportunityLineItems.size(),0);
        
    }
    
     @testSetup
   public static void insertData(){
   		Opportunity opp = new Opportunity();
		Date date1 = Date.newInstance(2016, 02, 5);
		opp.Name = 'Test Opp';
		opp.CloseDate = date1;
		opp.StageName = 'Prospecting';
		opp.Custom_Status__c = 'New';
		insert opp;
		
		Id pricebookId = Test.getStandardPricebookId();
		
		Product2 product = new Product2();
		product.Name = 'Test Product';
		product.ProductCode = 'Pro-X';
		product.isActive = true;
		insert product;
		
		PricebookEntry pbEntry = new PricebookEntry(
		    Pricebook2Id = pricebookId,
		    Product2Id = product.Id,
		    UnitPrice = 100.00,
		    IsActive = true
		);
		insert pbEntry;
		
		OpportunityLineItem newOppLineItem = new OpportunityLineItem();
		newOppLineItem.OpportunityId = opp.Id;
		newOppLineItem.Product2Id = product.Id;
		newOppLineItem.Quantity = 3;
		newOppLineItem.PricebookEntryId = pbEntry.Id;
		newOppLineItem.TotalPrice = 5 * pbEntry.UnitPrice;
		insert newOppLineItem;
		opp.Custom_Status__c = 'Reset';
        update opp;
	}
}