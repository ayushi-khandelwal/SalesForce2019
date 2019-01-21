public with sharing class Loans extends fflib_SObjectDomain{
    
    public Loans(List<Loan__c> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Loans(sObjectList);
        }
    }
    
    public override void onBeforeInsert(){
    	LoansHelper.insertManagerInLoanEntry((List<Loan__c>)Records);
    }
    
    public override void onAfterInsert(){
        LoansHelper.emailStatusChange((List<Loan__c>)Records,new Map<Id,SObject>(),'onAfterInsert');
    }
    
    public override void onAfterUpdate(Map<Id,SObject> existingRecords){
        LoansHelper.emailStatusChange((List<Loan__c>)Records,existingRecords,'onAfterUpdate');
    }
}