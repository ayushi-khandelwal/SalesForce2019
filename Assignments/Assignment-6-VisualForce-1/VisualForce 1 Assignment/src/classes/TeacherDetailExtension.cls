public with sharing class TeacherDetailExtension {
    public Contact contact{get;set;}
    
    public TeacherDetailExtension(ApexPages.StandardController controller){
        this.contact = (Contact)controller.getRecord();
    }
}