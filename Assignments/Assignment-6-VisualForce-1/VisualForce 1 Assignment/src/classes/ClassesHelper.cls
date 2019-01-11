public with sharing class ClassesHelper {
    
    public static void checkFemaleStudentsBeforeDelete(List<Class__c> recordsToBeDeleted){
    	ClassesSelector classSelectorObject = new ClassesSelector();
    	Map<Id,Class__c> classList = new Map<Id,Class__c>( classSelectorObject.selectAllClassWithFemaleStudents(recordsToBeDeleted));
    	for(Class__c classObject : recordsToBeDeleted){
    			Class__c classObjectForCheck = classList.get(classObject.Id);
    			if(classObjectForCheck != null){
    				if(classObjectForCheck.Student__r.size() > 2){
    					classObject.addError('Class can\'t be deleted with more than 2 Female Students.');
    				} 
    			}			
    		}
    	}
    }