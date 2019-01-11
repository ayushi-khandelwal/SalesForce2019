public with sharing class StudentPdfExtension {
    
    public Student__c student{get; set;}
    
    Transient Id studentIdToBePassed;

    public StudentsSelector studentSelectorObject = new StudentsSelector();
    
    public AttachmentsSelector attachmentSelectorObject = new AttachmentsSelector();
    
    public StudentPdfExtension(ApexPages.StandardController controller){
        /*Id studentId = ApexPages.currentPage().getParameters().get('id');
        List<Student__c> studentList = studentSelectorObject.selectById(new Set<Id>{studentId});
        System.debug('asdasdadad');
        if(studentList.size()>0){
            this.student = studentList.get(0);
            this.studentToBePassed = studentList.get(0);
        }*/
        this.student = (Student__c)controller.getRecord();
        this.studentIdToBePassed = (Id)controller.getId();
    }
    
    public PageReference generateAndAttachPdf(){
        PageReference currentPageRef = Page.StudentDetailPage;
        currentPageRef.getParameters().put('id',studentIdToBePassed);
        Blob pageData;
        if(Test.isRunningTest()) { 
  				pageData = blob.valueOf('Unit.Test');
			} else {
  				pageData = currentPageRef.getContentAsPDF();
			}
        
        Attachment att = new Attachment(
                                ParentId=student.Id,
                                Body=pageData,
                                Name='Student Details.pdf'
                            );
        //List<Student__c> studentList = studentSelectorObject.getAttachmentsOfStudent(new Set<Id>{student.Id},getStudentFieldSet());
        List<Attachment> attachmentList = attachmentSelectorObject.getAttachmentsByOwnerId(new Set<Id>{student.Id});
        List<Attachment> attachmentListToBeDeleted = new List<Attachment>();
        if(attachmentList.size()>0){
            for(Attachment attachment : attachmentList){
                if(attachment.Name.contains('Student Details ')){
                    attachmentList.add(attachment); 
                }
            }
            if(attachmentListToBeDeleted.size()>0){
                delete attachmentListToBeDeleted;
            }
        }
        insert att;
        return returnUrl();
    }
    
    public PageReference returnUrl(){
        return new PageReference('/'+student.Id);
    }
    
    public Set<String> getStudentFieldSet(){
        return new Set<String>{'Name','Id'};
    }
    
    public Set<String> getAttachmentFieldSet(){
        return new Set<String>{'Id','Name','OwnerId'};
    }
}