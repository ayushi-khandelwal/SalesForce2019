public class Students extends fflib_SObjectDomain {
    
     
    public Students(List<Student__c> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Students(sObjectList);
        }
    }
    
    public override void onBeforeInsert(){
    	StudentsHelper.checkMaxSizeOfClass((List<Student__c>)Records);
    }
    
    public override void onAfterInsert(){
    	fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] { Class__c.SObjectType });
    	StudentsHelper.updateClassStrengthWithStudentUpdationOrInsertion((List<Student__c>) Records , new Map<Id,SObject>(), 'Insert',uow);
    	uow.commitWork();
    }
    
    public override void onAfterUpdate(Map<Id,SObject> existingRecords){
    	fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] { Class__c.SObjectType });
    	StudentsHelper.updateClassStrengthWithStudentUpdationOrInsertion((List<Student__c>) Records, existingRecords, 'Update',uow);
    	uow.commitWork();
    }
}