public with sharing class ContactsSelector extends fflib_SObjectSelector {
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
        	Contact.Id,
        	Contact.Name,
        	Contact.AccountId
             };
    }
    
    public Schema.SObjectType getSObjectType() {
        return Contact.sObjectType;
    }
    
    public List<Contact> selectById(Set<ID> idSet) {
        return (List<Contact>) selectSObjectsById(idSet);
    }
    
    public List<Contact> selectContactById (List<ID> idSet){
    	List<Contact> listOfContact = [Select Id,AccountId From Contact Where Id In : idSet];
    	return listOfContact;
    }
    
    public List<Contact> selectAllContacts(){
    		fflib_QueryFactory query = newQueryFactory();
   			return (List<Contact>) Database.query(query.toSOQL());
    }
    
    public List<Contact> selectContactsByName(Set<String> fieldSet, String condition){
    	fflib_QueryFactory query = newQueryFactory();
    	if(fieldSet.size()>0){
    			query.selectFields(fieldSet);
    		}
    	if(condition!=null && condition!= ''){
    			query.setCondition(condition);
    	}
   		return (List<Contact>) Database.query(query.toSOQL());
    }
}