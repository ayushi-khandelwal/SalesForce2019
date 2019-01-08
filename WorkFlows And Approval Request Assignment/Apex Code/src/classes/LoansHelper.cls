public class LoansHelper {
    
    public static void insertManagerInLoanEntry(List<Loan__c> recordList){
    	CityManagersSelector cityManagerSelectorObject = new CityManagersSelector();
    	Set<String> cityNames = new Set<String>();
   		for(Loan__c loanObject : recordList){
   			cityNames.add(loanObject.City__c);
   		}
   		if(cityNames.size() > 0){
	    	Map<String,CityManager__c> cityManagerMap = new Map<String,CityManager__c>();
	    	List<CityManager__c> cityManagerList = cityManagerSelectorObject.selectCityManagerByName(cityNames);
	    	for(CityManager__c cityManagerObject : cityManagerList){
	    		cityManagerMap.put(cityManagerObject.Name,cityManagerObject);
	    	}
	    	for(Loan__c loanObject : recordList){
	    		CityManager__c cityManagerObject = cityManagerMap.get(loanObject.City__c);
	    		if(cityManagerObject!= null){
	    			loanObject.Manager__c = cityManagerObject.Manager__c;
	    		}
	    	}
   		}	
    }
}