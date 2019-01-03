public with sharing interface ClassesSelectorInterface {
    
     Map<Id,List<Student__c>> selectStudentByClassId(Set<Id> classIds);
}