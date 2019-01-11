public with sharing class AttachmentsSelector extends fflib_SObjectSelector{ 
   
     public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
        	Attachment.Id,
            Attachment.Name
             };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Attachment.sObjectType;
    }
    
    public List<Attachment> selectById(Set<ID> idSet) {
        return (List<Attachment>) selectSObjectsById(idSet);
    }
    
    public List<Attachment> getAttachmentsByOwnerId(Set<ID> idSet){
         //fflib_QueryFactory query = newQueryFactory();
         //query.selectFields(fieldSets);
   		// query.setCondition('OwnerId IN :idSet');
         //return (List<Attachment>) Database.query(query.toSOQL());
        List<Attachment> attachList = [Select Id,Name FROM Attachment WHERE OwnerId In :idSet];
        return attachList;
    }
}