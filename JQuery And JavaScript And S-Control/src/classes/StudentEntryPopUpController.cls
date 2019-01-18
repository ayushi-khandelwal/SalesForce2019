public with sharing class StudentEntryPopUpController {
 
	public Student__c studentToBeAdded{get; set;}
    
    public Boolean showForm{get; set;}
    
    public StudentEntryPopUpController(){
        studentToBeAdded = new Student__c();
        studentToBeAdded.Class__c = ApexPages.currentPage().getParameters().get('id');
        showForm = true;
    }
    
    public PageReference saveStudent(){
        Boolean insertionFailed = false;
        if(studentToBeAdded.Name!=null && studentToBeAdded.Last_Name__c!=null ) {
            try{
                insert studentToBeAdded;
            }catch(DMLException e){
                insertionFailed=true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Insertion Failed :'+e.getMessage()));
            }
            if(!insertionFailed){
                showForm = false;
                return new PageReference('javascript:window.close()');
            }
        }
        return null;
    }
    
     public PageReference closeWindow(){
        return new PageReference('StudentListPage');
    } 	   
}