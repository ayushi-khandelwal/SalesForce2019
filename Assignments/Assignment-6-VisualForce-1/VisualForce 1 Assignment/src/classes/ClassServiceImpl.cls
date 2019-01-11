public with sharing class ClassServiceImpl implements IClassService{
    
    ClassesSelector classSelector = new ClassesSelector();
    
    public static ClassServiceImpl getInstanceOf(){
    	return new ClassServiceImpl();
    }
    
    public Map<Id,List<Student__c>> getStudentByClassId(Set<Id> classIds){
    	Map<Id,Class__c> classObjectMap = classSelector.selectStudentByClassId(classIds);
    	Map<Id,List<Student__c>> resultMap = new Map<Id,List<Student__c>>();
    	for(Class__c classObject : classObjectMap.values()){
    		resultMap.put(classObject.Id,classObject.Student__r);
    	}
    	return resultMap;
    }
    
    public Map<Class__c,Set<Id>> getAllClassWithStudentId(){
    	List<Class__c> classList = classSelector.selectAllClassWithStudent();
    	Map<Class__c,Set<ID>> mapOfClassStudent = new Map<Class__c,Set<ID>>();
        for(Class__c classObject : classList){
            Set<Id> studentSet=new Map<Id,Student__c>(classObject.Student__r).keyset();
           	mapOfClassStudent.put(classObject,studentSet);    
        }
        return mapOfClassStudent;
    }
    
    public  List<Class__c> getClassById(Set<Id> idSet){
        return classSelector.selectById(idSet);
    }
}