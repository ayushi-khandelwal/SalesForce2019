public interface IClassService {
    
      Map<Id,List<Student__c>> getStudentByClassId(Set<Id> classIds);
   
   	  Map<Class__c,Set<Id>> getAllClassWithStudentId();
}