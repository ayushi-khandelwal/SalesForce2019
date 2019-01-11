public with sharing class ClassService implements IClassService{
    
    ClassesSelector classSelector = new ClassesSelector();
    
    public Map<Id,List<Student__c>> getStudentByClassId(Set<Id> classIds){
    	return ClassServiceImpl.getInstanceOf().getStudentByClassId(classIds);
    }
    
    public Map<Class__c,Set<Id>> getAllClassWithStudentId(){
    	return ClassServiceImpl.getInstanceOf().getAllClassWithStudentId();
    }
    
    public  List<Class__c> getClassById(Set<Id> idSet){
        return ClassServiceImpl.getInstanceOf().getClassById(idSet);
    }
}