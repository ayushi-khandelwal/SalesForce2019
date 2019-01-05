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
private class TestStackImplementation {

    static testMethod void myUnitTest1() {
        Stack newObj = new Stack();
		newObj.push(2);
		newObj.push(3);
		Integer x = newObj.pop();
		System.assertEquals(3,x);
		System.assertEquals(null,newObj.maxSize());
    }
    
    static testMethod void myUnitTest2(){
    	Stack newObj1 = new Stack(3);
		newObj1.push(2);
		newObj1.push(3);
		newObj1.push(4);
		newObj1.push(5);
		System.assertEquals(false,(newObj1.push(6)));
		System.assertEquals(false,newObj1.push(7));
		Integer x1 = newObj1.pop();
		System.assertEquals(4,x1);
		 x1 = newObj1.pop();
		System.assertEquals(3,x1);
		 x1 = newObj1.pop();
		System.assertEquals(2,x1);
		 x1 = newObj1.pop();
		System.assertEquals(null,x1);
		System.assertEquals(3,newObj1.maxSize());
    }
}