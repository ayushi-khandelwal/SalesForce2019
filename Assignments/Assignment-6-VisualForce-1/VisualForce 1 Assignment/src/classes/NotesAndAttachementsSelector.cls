public class NotesAndAttachementsSelector extends fflib_SObjectSelector{
    
     public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
        	NoteAndAttachment.Id,
            NoteAndAttachment.IsNote,
            NoteAndAttachment.Title
             };
    }
    
    public Schema.SObjectType getSObjectType() {
        return NoteAndAttachment.sObjectType;
    }
    
    public List<NoteAndAttachment> selectById(Set<ID> idSet) {
        return (List<NoteAndAttachment>) selectSObjectsById(idSet);
    }
    
}