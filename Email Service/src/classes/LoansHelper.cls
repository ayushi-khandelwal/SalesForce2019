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
    
    
    public static void emailStatusChange(List<Loan__c> recordsInserted, Map<Id,SObject> existingRecords, String action){
        List<Loan__c> emailApplicants = new List<Loan__c>();
        if(('onAfterInsert').equals(action)){
            emailApplicants.addAll(recordsInserted);
        }else if(('onAfterUpdate').equals(action)){
            for(Loan__c loanObject: recordsInserted){
               Loan__c loanObjectToCompare = (Loan__c)existingRecords.get(loanObject.Id);
                if(loanObjectToCompare.Loan_Status__c != loanObject.Loan_Status__c && (loanObject.Loan_Status__c == 'Approved' || loanObject.Loan_Status__c == 'Rejected')){
                    emailApplicants.add(loanObject);
                }
            }
        }
        EmailTemplate eTemp = [SELECT id,name FROM EmailTemplate WHERE name ='Loan Status Info VF' AND isActive = true LIMIT 1];
        List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
        for(Loan__c emailApplicant : emailApplicants){
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setReplyTo('sankalp.vyas@metacube.com');
            email.setSaveAsActivity(false);
   			email.setTemplateId(eTemp.Id);
            email.setTargetObjectId(emailApplicant.OwnerId);
            email.setTreatTargetObjectAsRecipient(false);
            email.setToAddresses(new String[]{emailApplicant.Applicant_Email__c});
            emailMessages.add(email);
        }
   		Messaging.sendEmail(emailMessages); 
    }
}
