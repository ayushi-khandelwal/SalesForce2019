public with sharing interface ClassServiceInterface {
    
      Map<Id,List<Student__c>> getStudentByClassId(Set<Id> classIds);
}