public with sharing class ManageClassExtension2 {
    
    public final Integer size = 5;
    
    public IClassService classServiceObject = new ClassService();
    
    public ManageClassExtension2(ApexPages.StandardController controller){
    }
    
    public ApexPages.StandardSetController setCon {
        get ; set;
    }
    
    public List<Class__c> getClassList(){
        if(setCon==null){
            setCon = new ApexPages.StandardSetController(new List<Class__c>(classServiceObject.getAllClassWithStudentId().keySet()));
            setCon.setPageSize(size);
            return (List<Class__c>) setCon.getRecords();
        }
        return (List<Class__c>) setCon.getRecords();
    }
   
}
