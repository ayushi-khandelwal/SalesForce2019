public class ContactsHelper {
    
    public static void checkHindiSubjectTeacher(List<Contact> recordsToBeInserted, Map<Id,SObject> existingRecordsIn,String action){
    	if(('Insert').equals(action)){
    		for(Contact contactObject : recordsToBeInserted){
    			List<String> pickListValues = new List<String>();
    			if(contactObject.Subjects__c!=null && contactObject.Subjects__c.contains(';')){
    				pickListValues = contactObject.Subjects__c.split(';');
    			}else if(contactObject.Subjects__c!=null){
    				pickListValues.add(contactObject.Subjects__c);
    			}
    			if(pickListValues!=null){
    			for(String subjectName : pickListValues){
    				if(('Hindi').equals(subjectName)){
    					contactObject.Subjects__c.addError('Teacher is not allowed to Insert with Hindi as a Subject');
    				}
    			}
    		  }
    		}
    	}
    	else if(('Update').equals(action)){
    		for(Contact contactObject : recordsToBeInserted){
    			Contact existingContactObject = (Contact)existingRecordsIn.get(contactObject.Id);
    			List<String> pickListValues = new List<String>();
    			if( existingContactObject.Subjects__c!=null && existingContactObject.Subjects__c.contains(';')){
    				pickListValues = existingContactObject.Subjects__c.split(';');
    			}else if(existingContactObject.Subjects__c!=null){
    				pickListValues.add(existingContactObject.Subjects__c);
    			}
    			if(pickListValues!=null){
    			for(String subjectName : pickListValues){
    				if(('Hindi').equals(subjectName)){
    					contactObject.Subjects__c.addError('Teacher is not allowed to Update with Hindi as a Subject');
    				}
    			}
    		  }
    		}
    	}
    }
    
     public static Set<String> getContactFields(){
    	Set<String> accountFields =  new Set<String>{'Name','Id','AccountId'};
    	return accountFields;
    } 
    
    public static String getConditionString(String contactName){
    	String condition = '';
    	if(!('').equals(contactName)){
    		condition = condition + ' Name Like \''+contactName+'%\'';
    	}
    	return condition;
    }
}