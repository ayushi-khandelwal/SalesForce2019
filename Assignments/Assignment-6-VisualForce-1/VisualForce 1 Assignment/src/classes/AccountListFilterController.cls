public with sharing class AccountListFilterController {

    private final Account acct {get; set;} 

   public IAccountService accountService = new AccountService();
   
    public List<Account> accountList {get; set ;}
   
   public String billingCountry {get ; set ;}
   
   public String billingCity {get ; set ;}
   
   public String billingState {get ; set ;}
    
   public Boolean showResult {get; set;}
   
   public Boolean getData = true;
   
   public final Integer size = 5; 
   
   public AccountListFilterController(){
   	
   }
    
    public AccountListFilterController(ApexPages.StandardSetController controller) {
        this.acct = (Account)controller.getRecord();
        
    }   
  
   public ApexPages.StandardSetController setCon {
        get {
            if(getData) {
                setCon = new ApexPages.StandardSetController(accountService.filteredAccountListBy(billingCountry,billingState,billingCity));
            	setCon.setPageSize(size);
                showResult = (setCon.getResultSize() > 0) ? true : false ;
            }
            return setCon;
        }
        private set;
    }

    // Initialize setCon and return a list of records
    public List<Account> getAccounts() {
        return (List<Account>) setCon.getRecords();
        //return accountService.filteredAccountListBy(getConditionString(),getAccountFields());
    }
    
    public void setAccountList(){
    	accountList = getAccounts();
    }
    
    public void searchAccount(){
        changeStatusGetData(true);
    	setAccountList();
        changeStatusGetData(false);
    }
    
    public void changeStatusGetData(Boolean status){
        getData = status;
    }
    
    public void nextPage(){
    	if(setCon!=null){
    		if(setCon.getHasNext()){
                setCon.next();
                setAccountList();
    		}
    	}
    }
    
    public void previousPage(){
    	if(setCon!=null){
	    	if(setCon.getHasPrevious()){
                setCon.previous();
                setAccountList();
	    	}
    	}
    }
    
    public void firstPage(){
        if(setCon!=null){
                setCon.first();
                setAccountList();
    		}
    }
    
    public void lastPage(){
        if(setCon!=null){
                setCon.last();
                setAccountList();
	    	}
    }
    
   
}