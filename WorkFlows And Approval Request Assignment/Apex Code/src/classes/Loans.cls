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
}