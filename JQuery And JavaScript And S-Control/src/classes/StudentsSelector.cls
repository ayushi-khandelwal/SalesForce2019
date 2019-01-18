public class StudentsSelector extends fflib_SObjectSelector{
    
     public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
        	Student__c.Name,
            Student__c.Id,
            Student__c.Sex__c,
            Student__c.Class__c,
            Student__c.Age__c,
            Student__c.DOB__c,
            Student__c.Married__c,
            Student__c.Wife_Name__c,
            Student__c.email__c
             };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Student__c.sObjectType;
    }
    
     public List<Student__c> selectById(Set<ID> idSet) {
        return (List<Student__c>) selectSObjectsById(idSet);
    }
    
    public List<Student__c> getAttachmentsOfStudent(Set<ID> idSet,Set<String> fieldSets){
    	 fflib_QueryFactory query = newQueryFactory();
         query.selectFields(fieldSets);
   		 query.setCondition('Id IN :idSet');
   		 new AttachmentsSelector().addQueryFactorySubSelect(query,'Attachments');
   		 return (List<Student__c>) Database.query(query.toSOQL());
    }
    
    public List<Student__c> getAllStudents(String condition, Set<String> fieldSets){
        fflib_QueryFactory query = newQueryFactory();
         query.selectFields(fieldSets);
        if(condition!=''){
           query.setCondition(condition); 
        }
         return (List<Student__c>) Database.query(query.toSOQL());
    }
    
}