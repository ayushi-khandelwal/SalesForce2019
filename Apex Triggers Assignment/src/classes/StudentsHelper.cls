public class StudentsHelper {
    
    public static void checkMaxSizeOfClass(List<Student__c> recordsToBeInserted){
    	Set<Id> classIds = new Set<Id>();
    	for(Student__c studentObject : recordsToBeInserted){
    		if(studentObject.Class__c != null) {
    			classIds.add(studentObject.Class__c);
    		}
    	}
    	if(classIds.size() > 0){
    		ClassesSelector classSelectorObject = new ClassesSelector();
    		Map<Id,Class__c> classesList = classSelectorObject.selectStudentByClassId(classIds);
    		for(Student__c studentObject : recordsToBeInserted){
    			Class__c classObject = classesList.get(studentObject.Class__c);
    			if(classObject != null && classObject.Max_Size__c != null && classObject.Student__r != null){
    				if((classObject.Max_Size__c - 1) < classObject.Student__r.size()){
    					studentObject.addError('Class has Reached its Maximum Strength.');
    				}
    			}
    		}		
    	}
    	
    }
    
    public static void updateClassStrengthWithStudentUpdationOrInsertion(List<Student__c> recordsUpdated , Map<Id,SObject> existingRecordsBeforeUpdation , String action, fflib_SObjectUnitOfWork uow){
		Set<Id> classIds = new Set<Id>();
		if(('Insert').equals(action)){
			for(Student__c studentObject : recordsUpdated){
				classIds.add(studentObject.Class__c);
			}
		}else if(('Update').equals(action)){ 	
			for(Student__c studentObject : recordsUpdated){
				Student__c studentObjectBeforeUpdate = (Student__c)existingRecordsBeforeUpdation.get(studentObject.Id);
				if(studentObjectBeforeUpdate!=null && studentObject.Class__c != studentObjectBeforeUpdate.Class__c){
					classIds.add(studentObject.Class__c);
					classIds.add(studentObjectBeforeUpdate.Class__c);
				}
			}
		}
		if(classIds.size()>0){
			ClassesSelector classSelectorObject = new ClassesSelector();
			Map<Id,Class__c> classMap = classSelectorObject.selectStudentByClassId(classIds);
			for(Class__c classObject : classMap.values()){
				if(classObject.Student__r.size() <= classObject.Max_Size__c){
					classObject.Number_Of_Pupils__c = classObject.Student__r.size();
				}else{
					Map<Id,Student__c> mapOfErrorStudent = new Map<Id,Student__c>(classObject.Student__r);
					for(Student__c studentObject : recordsUpdated){
						if(mapOfErrorStudent.get(studentObject.Id)!= null){
							studentObject.addError('Student can\'t be added, Class reached Max Size.');
						}
					}
				}
			}
			List<Class__c> classList = classMap.values();
			uow.registerDirty(classList);
		}   
    }
}