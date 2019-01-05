public interface ClassesSelectorInterface {
	
     Map<Id,Class__c> selectStudentByClassId(Set<Id> classIds);
     
     List<Class__c> selectAllClassWithStudent();
}