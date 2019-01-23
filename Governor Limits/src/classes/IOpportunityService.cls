public interface IOpportunityService {
    
     List<Opportunity> opportunityLastModifiedLastMonth();
    
     List<Opportunity> getOpportunities(Set<Id> opportunityIds);
}