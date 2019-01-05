public with sharing class Classes extends fflib_SObjectDomain{
    
    public Classes(List<Class__c> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Classes(sObjectList);
        }
    }
}