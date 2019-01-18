public with sharing class StudentListController {
    
    public ApexPages.StandardSetController setCon {get; set;}
    
    Transient Integer pageSize = 5;
    Transient StudentsSelector studentSelectorObject = new StudentsSelector();
    public Id studentId{get; set;}
    
    public StudentListController(ApexPages.StandardController controller){
        
    }
    
    public List<Student__c> getRecords(){
        if(setCon==null){
            setCon = new ApexPages.StandardSetController(studentSelectorObject.getAllStudents('', new Set<String>{'Id','Name','email__c','Married__c'}));
            setCon.setPageSize(pageSize);
            return (List<Student__c>)setCon.getRecords();
        }else{
            return (List<Student__c>)setCon.getRecords();
        }
    }
}