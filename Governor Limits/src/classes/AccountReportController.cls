public with sharing class AccountReportController {
    
    public class Report{
        public String Name {get;set;}
        public String Amount{get;set;}
    }
    
    public List<Report> getRecords(){
        List<Report> listReports = new List<Report>();
        AggregateResult[] groupedResults = [SELECT SUM(Amount)Amount,Account.Name FROM Opportunity GROUP BY Account.Name LIMIT 10] ;
        for(AggregateResult aggResult: groupedResults){
            Report reportObject = new Report();
            reportObject.Name = String.valueOf(aggResult.get('Name'));
            reportObject.Amount = String.valueOf(aggResult.get('Amount'));
            listReports.add(reportObject);
		}
        return listReports;
    }
}