public with sharing class StudentDeleteController {
    
    public ApexPages.StandardSetController setCon{get; set;}
    public List<Student__c> listOfStudents = new List<Student__c>();
    public Set<Id> studentIds = new Set<Id>();
    public Integer pageSize = 5;
    Transient StudentsSelector studentSelectorObject = new StudentsSelector();
    
    public Boolean showForm{get; set;}

    public StudentDeleteController(ApexPages.StandardSetController standardController){
        showForm=false;
        listOfStudents = standardController.getSelected();
        setStudentIds();
        if(studentIds.size()>0){
            showForm = true;
        }
    }
    
    public void setStudentIds(){
        for(Student__c stud: listOfStudents){
            studentIds.add(stud.Id);
        }
    }
    
    public List<Student__c> getRecords(){
        if(setCon==null){
            setCon = new ApexPages.StandardSetController(studentSelectorObject.selectById(studentIds));
            if(setCon!=null){
                 setCon.setPageSize(pageSize);
                 List<Student__c> studentList = (List<Student__c>)setCon.getRecords();
                 showForm = (studentList.size() > 0) ? true:false;
                 return studentList;
            }
            else{
                return new List<Student__c> ();
            }
        }else{
            return (List<Student__c>)setCon.getRecords();
        }
    }
    
    public PageReference deleteStudents(){
        boolean deletionFailed = false;
        try{
            delete listOfStudents;
        }catch(DMLException e){
            deletionFailed = true;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Deletion Failed :'+e.getMessage()));
        }
        if(!deletionFailed){
           return closeWindow();
        }
        return null; 
    }
    
    public PageReference closeWindow(){
        Schema.DescribeSObjectResult anySObjectSchema = Student__c.SObjectType.getDescribe();
		String objectIdPrefix = anySObjectSchema.getKeyPrefix();
		PageReference pageReference = new PageReference('/'+objectIdPrefix);
        return pageReference;
    }
}