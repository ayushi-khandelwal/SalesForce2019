public with sharing class OpportunityServiceImpl implements IOpportunityService{
    
    OpportunitiesSelector opportunitiesSelectorObject = new OpportunitiesSelector();
    
    public static OpportunityServiceImpl getInstanceOf(){
    	return new OpportunityServiceImpl();
    }
    
    public List<Opportunity> opportunityLastModifiedLastMonth(){
    	return opportunitiesSelectorObject.selectMonthWiseLastOpportunityUpdated(Datetime.now().addDays(-15));
    }
    
    public List<Opportunity> getOpportunities(Set<Id> opportunityIds){
    	return opportunitiesSelectorObject.selectById(opportunityIds);
    }
}