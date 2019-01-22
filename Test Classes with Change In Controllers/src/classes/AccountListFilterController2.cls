public class AccountListFilterController2 {
    
    public IAccountService accountService = new AccountService();
    
    public String billingCountry {get ; set ;}
    
    public String billingCity {get ; set ;}
    
    public String billingState {get ; set ;}
    
    public Boolean showResult {get; set;}
    
    public static final Integer size = 5; 
    
    public AccountListFilterController2(){
        billingCountry = '';
        billingCity = '';
        billingState = '';
    }
    
    public ApexPages.StandardSetController setCon {
        get ; set;
    }
    
    public List<Account> getAccountList() {
        if(setCon==null) {
            setCon = new ApexPages.StandardSetController(accountService.filteredAccountListBy(billingCountry,billingState,billingCity));
            setCon.setPageSize(size);
            showResult = (setCon.getResultSize() > 0) ? true : false ;
            return (List<Account>)setCon.getRecords();
        }
        return (List<Account>) setCon.getRecords();
    }
    
    public void searchAccount(){
        setCon=null;
    }
    
}