public class ContactsHelper {
    
    public static void checkHindiSubjectTeacher(List<Contact> recordsToBeInserted, Map<Id,SObject> existingRecordsIn,String action){
    	if(('Insert').equals(action)){
    		for(Contact contactObject : recordsToBeInserted){
    			String[] pickListValues;
    			if( contactObject.Subjects__c.contains(';')){
    				pickListValues = contactObject.Subjects__c.split(';');
    			}else{
    				pickListValues[0] = contactObject.Subjects__c;
    			}
    			for(String subjectName : pickListValues){
    				if(('Hindi').equals(subjectName)){
    					contactObject.Subjects__c.addError('Teacher is not allowed to Insert with Hindi as a Subject');
    				}
    			}
    		}
    	}
    	else if(('Update').equals(action)){
    		for(Contact contactObject : recordsToBeInserted){
    			Contact existingContactObject = (Contact)existingRecordsIn.get(contactObject.Id);
    			String[] pickListValues;
    			if( existingContactObject.Subjects__c.contains(';')){
    				pickListValues = existingContactObject.Subjects__c.split(';');
    			}else{
    				pickListValues[0] = existingContactObject.Subjects__c;
    			}
    			for(String subjectName : pickListValues){
    				if(('Hindi').equals(subjectName)){
    					contactObject.Subjects__c.addError('Teacher is not allowed to Update with Hindi as a Subject');
    				}
    			}
    		}
    	}
    }
}