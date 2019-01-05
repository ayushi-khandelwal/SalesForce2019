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
@isTest(SeeAllData=true)
private class TestManagerAndBillToContact {

    static testMethod void myUnitTest() {
     Id opportunityId = Id.valueOf('00610000018694FAAQ');
       Id accountId = Id.valueOf('0011000001LQZQ2AAP');
       Opportunity opp = [Select Id,Name,Amount,BillToContact__r.Name,Manager__r.Name From Opportunity Where Id =: opportunityId];
	   Contact conct = [Select Id,Name From Contact Limit 1];
       opp.Amount = 1000;
	   opp.BillToContact__r.Id = conct.Id;
       update opp; 
       Set<Id> opportunitySet = new Set<Id>();
       opportunitySet.add(opportunityId);
       List<Opportunity> opp1 = new OpportunitiesSelector().selectOpportunityById(opportunitySet);
       System.assertEquals(accountId,opp1[0].Manager__r.Id);
    }
}