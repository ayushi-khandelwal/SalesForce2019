public with sharing class OpportunityService implements IOpportunityService{
	
   	public List<Opportunity> opportunityLastModifiedLastMonth(){
   		List<Opportunity> opportunityList = OpportunityServiceImpl.getInstanceOf().opportunityLastModifiedLastMonth();
   		return opportunityList;
   	}
   	
   	public List<Opportunity> getOpportunities(Set<Id> opportunityIds){
   		return OpportunityServiceImpl.getInstanceoF().getOpportunities(opportunityIds);
   	}
}