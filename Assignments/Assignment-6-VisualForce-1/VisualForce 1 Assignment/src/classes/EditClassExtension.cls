public with sharing class EditClassExtension {
    
    public IClassService classServiceObject = new ClassService();
    
   	public Class__c classObject{get; set;}
    
    public Boolean showEditPage{get; set;}
    
    public ID classId{get; set;}
  
    
    public EditClassExtension(ApexPages.StandardController controller){
         showEditPage = false;
         classObject = null;
    }
    
    public void editTheClass(){
        List<Class__c> classObjectsGet = classServiceObject.getClassById(new Set<Id>{classId});
        if(classObjectsGet.size()>0){
            this.classObject = classObjectsGet.get(0);
            showEditPage = true;
        }
    }
    
    public void deleteTheClass(){
        List<Class__c> classObjectsGet = classServiceObject.getClassById(new Set<Id>{classId});
        if(classObjectsGet.size()>0){
             delete classObjectsGet.get(0);
        }
       
    }
    
    public void saveTheClassObject(){
        if(classObject!=null && classObject.Id!=null){
            update classObject;
            showEditPage = false;
            resetClassObject();
        }
    }
    
    public void resetClassObject(){
        this.classObject = null;
    }
}