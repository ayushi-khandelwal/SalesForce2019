public with sharing class ClassService implements ClassServiceInterface{
    
    ClassesSelectorInterface classSelector = new ClassesSelector();
    
    public Map<Id,List<Student__c>> getStudentByClassId(Set<Id> classIds){
    	return classSelector.selectStudentByClassId(classIds);
    }
    
    public Map<Class__c,Set<Id>> getAllClassWithStudentId(){
    	List<Class__c> classList = classSelector.selectAllClassWithStudent();
    	Map<Class__c,Set<ID>> mapOfClassStudent = new Map<Class__c,Set<ID>>();
        for(Class__c classObject : listOfClass){
            Set<Id> studentSet=new Map<Id,Student__c>(classObject.Student__r).keyset();
           	mapOfClassStudent.put(classObject,studentSet);    
        }
        return mapOfClassStudent;
    }
}