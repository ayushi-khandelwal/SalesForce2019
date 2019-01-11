public with sharing class ManageClassExtension {
    
    public List<Class__c> classList {
                                    get{ return getClassList();} 
                                    set;
                                }
    
    public Boolean getData = true;
    
    public final Integer size = 5;
    
    public IClassService classServiceObject = new ClassService();
    
    public ManageClassExtension(ApexPages.StandardController controller){
    }
    
    public ApexPages.StandardSetController setCon {
        get {
            if(getData) {
                setCon = new ApexPages.StandardSetController(new List<Class__c>(classServiceObject.getAllClassWithStudentId().keySet()));
                setCon.setPageSize(size);
            }
            return setCon;
        }
        private set;
    }
    
    public List<Class__c> getClassList(){
        return (List<Class__c>) setCon.getRecords();
    }
    
    public void setClassList(){
        this.classList = getClassList();
    }
    
    public void searchClassList(){
        getData = true;
        setClassList();
        getData = false;
    }
   
}