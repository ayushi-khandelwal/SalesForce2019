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
private class TestWorkingDays {

    static testMethod void myUnitTest() {
        Date date1= Date.newInstance(2019, 1, 7);
		Date date2 = Date.newInstance(2018,12,25);
		Integer days = UtilityServices.workingDaysCalculator(date1, date2);
		Integer days2 = UtilityServices.workingDaysCalculator(date2, date1);
		System.assertEquals(days,days2);
    }
    
     static testMethod void myUnitTest2() {
        Date date1;
		Date date2;
		Integer days = UtilityServices.workingDaysCalculator(date1, date2);
		System.assertEquals(null,days);
    }
}