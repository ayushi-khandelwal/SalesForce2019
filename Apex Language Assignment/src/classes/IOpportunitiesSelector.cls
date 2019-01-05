public interface IOpportunitiesSelector {
  
  List<Opportunity> selectMonthWiseLastOpportunityUpdated(DateTime aMonthAgo);
  
  List<Opportunity> selectOpportunityById(Set<ID> idSet);
}