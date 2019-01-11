public with sharing class AccountsHelper {
   
     public static Set<String> getAccountFields(){
    	Set<String> accountFields =  new Set<String>{'Name','AnnualRevenue','AccountNumber','BillingCountry'};
    	return accountFields;
    } 
    
     public static String getConditionString(String billingCountry,String billingState, String billingCity){
    	String condition = '';
    	if(!('').equals(billingCountry)){
    		condition = condition + ' BillingCountry Like \''+billingCountry+'%\'';
    	}
    	if(!('').equals(billingCity)){
    		if(! ('').equals(condition)){
    			condition = condition + ' And';
    		}
 			condition = condition + ' BillingCity Like \''+billingCity+'%\'';   	
    	}
    	if(!('').equals(billingState)){
    		if(! ('').equals(condition)){
    			condition = condition + ' And';
    		}
 			condition = condition + ' BillingState Like \''+billingState+'%\'';   	
    	}
    	return condition;
    }
}