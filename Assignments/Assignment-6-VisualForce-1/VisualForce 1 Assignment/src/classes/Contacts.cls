public class Contacts extends fflib_SObjectDomain{
    
    public Contacts(List<Contact> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Contacts(sObjectList);
        }
    }
    
    public override void onBeforeUpdate(Map<Id,SObject> existingRecords){
     	ContactsHelper.checkHindiSubjectTeacher((List<Contact>)Records,existingRecords,'Update');
    }
    
     public override void onBeforeInsert(){
    	ContactsHelper.checkHindiSubjectTeacher((List<Contact>)Records,new Map<Id,Contact>(),'Insert');
    }
}