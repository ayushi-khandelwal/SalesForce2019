public with sharing class ContactListExtension {
        
    public Opportunity opportunity = new Opportunity();
    
    public IContactService contactServiceObject= new ContactService();
    
    public IOpportunityService opportunityServiceObject  = new OpportunityService();
    
    public List<Contact> contactList {get; set;}
    
    public String name{get; set;}
    
    public Boolean getData = false;
    
    public Id ContactId{get; set;}
    
    public ContactListExtension(ApexPages.StandardController controller) {
        this.opportunity = (Opportunity)controller.getRecord(); 
    }   

    // Initialize setCon and return a list of records
    public List<Contact> getContacts() {
        return (List<Contact>) contactServiceObject.getContactByName(name);
    }
    
    public void setContactList(){
        contactList = getContacts();
    }
    
    public List<SelectOption> getItems(){
        List<SelectOption> options = new List<SelectOption>();
        if(contactList != null){
             for(Contact contactObject : contactList){
            	options.add(new SelectOption(contactObject.Id, contactObject.Name));
        	}
        }
        return options;
    }
    
    public void searchContacts(){
        getData = true;
        setContactList();
        getData = false;
    }
    
    public PageReference saveBillToContact(){
        if(ContactId!=null){
            this.opportunity.BillToContact__c = ContactId ;
    		update opportunity;  
        }
    	return returnUrl();
    }
    
    public PageReference cancelBillToContact(){
    	return returnUrl();
    }
    
    public PageReference clearBillToContact(){
    	this.opportunity.BillToContact__c = null;
    	update opportunity;
    	return returnUrl();
    }
    
    public PageReference returnUrl(){
    	return new PageReference('/'+ApexPages.currentPage().getParameters().get('id'));
    }
}