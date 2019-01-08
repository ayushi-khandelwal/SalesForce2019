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
private class TestOpportunityStageChange {

    static testMethod void myUnitTest() {
		Opportunity opp = new Opportunity();
		Date date1 = Date.newInstance(2016, 02, 5);
		opp.Name = 'Test Opp';
		opp.CloseDate = date1;
		opp.StageName = 'Prospecting';
		
		insert opp;
		
		System.debug(opp.CloseDate);
		opp.StageName = 'Closed Won';
		
		update opp;
		Opportunity opp2 = [Select CloseDate From Opportunity where Id=:opp.Id];
		System.debug(opp2.CloseDate);
		System.assertEquals(Date.today(),opp2.CloseDate);
    }
}
