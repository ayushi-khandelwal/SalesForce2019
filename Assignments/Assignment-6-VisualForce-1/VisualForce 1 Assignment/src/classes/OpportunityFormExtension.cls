public with sharing class OpportunityFormExtension {
    
    private final Opportunity opportunityObject;
    
    // The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    public OpportunityFormExtension(ApexPages.StandardController stdController) {
        this.opportunityObject = (Opportunity)stdController.getRecord();
    }
    
    public PageReference searchContact() {
		return Page.LookUpPageForBillToContacts;
	}
}