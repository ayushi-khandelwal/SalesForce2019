public with sharing class ContactListExtension2 {
    
    public Opportunity opportunity = new Opportunity();
    
    public IContactService contactServiceObject= new ContactService();
    
    public IOpportunityService opportunityServiceObject  = new OpportunityService();
    
    public List<Contact> contactList {get; set;}
    
    public String name{get; set;}
    
    public Id contactId{get; set;}
    
    public ContactListExtension2(ApexPages.StandardController controller) {
        this.opportunity = (Opportunity)controller.getRecord(); 
    }   
    
    public void setContactList(){
        contactList = (List<Contact>) contactServiceObject.getContactByName(name);
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