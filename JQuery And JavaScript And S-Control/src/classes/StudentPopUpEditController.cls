public with sharing class StudentPopUpEditController {
    
    public Student__c studentToBeAdded{get; set;}
    
    public Boolean showForm{get; set;}
    
    public StudentPopUpEditController(ApexPages.StandardController controller){
        studentToBeAdded = (Student__c)controller.getRecord();
        showForm = true;
    }
    
    public PageReference saveStudent(){
        Boolean updationFailed = false;
        if(studentToBeAdded.Name!=null && studentToBeAdded.Last_Name__c!=null ) {
            try{
                update studentToBeAdded;
            }catch(DMLException e){
                updationFailed=true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Insertion Failed :'+e.getMessage()));
            }
            if(!updationFailed){
                showForm = false;
                return closeWindow();
            }
        }
        return null;
    }
    
     public PageReference closeWindow(){
        return new PageReference('StudentListPage');
    }
}