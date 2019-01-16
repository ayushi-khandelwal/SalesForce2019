public with sharing class CartController {
    
    public PurchaseOrderService purchaseOrderService = new PurchaseOrderService();
    
    public ProductService productServiceObject = new ProductService();
    
    public List<Purchase_Order__c> purchaseOrderList{get{
        					purchaseOrderList = getPurchaseOrderList();
        					return purchaseOrderList;} 
                             set;}
    
    public PurchaseLineItemService purchaseLineItemService = new PurchaseLineItemService();
    
    public List<Purchase_Line_Items__c> listOfPurchaseLineItems{get; set;
                                                               }
    public List<Product__c> productList{get{productList = productServiceObject.getProductsByName(productQuery);
                                           	return productList;} 
                                        set;}
    
    public Purchase_Line_Items__c purchaseLineItemObject{get; set;}
    
    public Purchase_Order__c purchaseOrderObject{get; set;}
    
    public Id purchaseOrderID { get; set;}
    
    public Id purchaseLineItemsId {get; set;}
    
    public Id productId {get;set;}
    
    public String productQuery{get;set;}
    
    public Boolean showList {get; set;}
    
    public Boolean showAddPage {get; set;}
    
    public CartController(){
        purchaseLineItemObject = new Purchase_Line_Items__c();
        purchaseOrderObject = new Purchase_Order__c();
        showList = false;
        showAddPage = false;
        productQuery = '';
    }
    
    public List<Purchase_Order__c> getPurchaseOrderList(){
    	return purchaseOrderService.getPurchaseOrderByOwnerId(new Set<Id>{UserInfo.getUserId()});
    }
                                                                
    public List<Purchase_Line_Items__c>  getPurchaseLineItemList(){
        if(purchaseOrderID!=null){
            return purchaseLineItemService.selectByPurchaseOrderId(new Set<Id>{purchaseOrderID});
        }
        return null;
    } 
    
    public void createAPurchaseOrder(){
        
    }
    
    public void addPurchaseItems(){
       purchaseLineItemObject.Purchase_Order__c = purchaseOrderId;
       List<Purchase_Order__c> purchaseOrderObjects = purchaseOrderService.getPurchaseOrderById(new Set<Id>{purchaseOrderId});
       purchaseOrderObject = purchaseOrderObjects.get(0);
       listOfPurchaseLineItems = getPurchaseLineItemList();
       showAddPage = true;
    }
    
    public void savePurchaseItems(){
        boolean insertionFailed = false;
        try{
        	insert purchaseLineItemObject;    
        }catch(DMLException e)
        {
            insertionFailed = true;
        }
        if(!insertionFailed){
             listOfPurchaseLineItems = getPurchaseLineItemList();
        }
        purchaseLineItemObject = new Purchase_Line_Items__c();
        showAddPage = false;
    }
    
    public PageReference viewPurchaseItemsOf(){
        listOfPurchaseLineItems = getPurchaseLineItemList();
        List<Purchase_Order__c> purchaseOrderObjects = purchaseOrderService.getPurchaseOrderById(new Set<Id>{purchaseOrderId});
        purchaseOrderObject = purchaseOrderObjects.get(0);
        if(listOfPurchaseLineItems.size() > 0){
            if(showAddPage!=null && showAddPage){
                showAddPage =false;
            }
        }
        return null;
    }
    
    public void saveList(){
        System.debug('Quantity : '+listOfPurchaseLineItems.get(0).Quantity__c);
        if(listOfPurchaseLineItems != null){
            Boolean listInsertionFailed = false;
            Boolean updationOfPurchaseOrderFailed = false;
            Integer orderCost = 0;
            for(Purchase_Line_Items__c listItem : listOfPurchaseLineItems ){
                orderCost = orderCost + Integer.valueOf(listItem.Total_Price__c) ;
            }
            Purchase_Order__c purchaseOrderObjectToUpdate = new Purchase_Order__c();
            purchaseOrderObjectToUpdate.Id = purchaseOrderObject.Id;
            purchaseOrderObjectToUpdate.Order_Cost__c = orderCost ;
            try{
                update purchaseOrderObjectToUpdate;
            }catch(DMLException e){
                System.debug(e.getMessage());
                listInsertionFailed = true;
            }
            if(!listInsertionFailed){
                try{
                    update listOfPurchaseLineItems;
                }catch(DMLException e){
                     System.debug(e.getMessage());
                    updationOfPurchaseOrderFailed = true;
                }
            }
            System.debug(updationOfPurchaseOrderFailed);
            if(!updationOfPurchaseOrderFailed){
               listOfPurchaseLineItems = getPurchaseLineItemList();
            }
        }
    }
    
    public void searchProduct(){
        if(productQuery!=''){
            System.debug(productQuery);
            productList = productServiceObject.getProductsByName(productQuery);
        }
    }
    
    public void addToCart(){
        if(productId!=null && purchaseOrderId!=null){
            Boolean insertionfailed = false;
            Purchase_Line_Items__c newPurchaseOrderLineItemObject = new Purchase_Line_Items__c();
            newPurchaseOrderLineItemObject.Purchase_Order__c = purchaseOrderId;
            newPurchaseOrderLineItemObject.Product__c = productId;
            newPurchaseOrderLineItemObject.Quantity__c = 1;
            try{
                insert newPurchaseOrderLineItemObject;
            }
            catch(DMLException e){
                System.debug(e.getMessage() );
                insertionFailed = true;
            }
            if(!insertionFailed){
               	listOfPurchaseLineItems = getPurchaseLineItemList();
             //   for(Purchase_Line_Items__c listItem : listOfPurchaseLineItems ){
             //  		 System.debug(listItem.Quantity__c);
           	//	 }
              }
             //listOfPurchaseLineItems.add(newPurchaseOrderLineItemObject);
            }
         }
    
    public void deletePurchaseItem(){
        Purchase_Line_Items__c purchaseListItemsObject = new Purchase_Line_Items__c();
        System.debug('Id -> '+purchaseLineItemsId);
        if(purchaseLineItemsId!=null){
            boolean deletionFailed = false;
            purchaseListItemsObject.Id = purchaseLineItemsId;
            Integer index = 0;
            try{
                delete purchaseListItemsObject;
            	}
             catch(DMLException e){
                deletionFailed = true;
			}
            if(!deletionFailed){
              listOfPurchaseLineItems = getPurchaseLineItemList();
            }
            //for(Purchase_Line_Items__c listItem : listOfPurchaseLineItems ){
              //  if(listItem.Id == purchaseLineItemsId){
              //      break;
              //  } 
               // index++;
           //	}
           // listOfPurchaseLineItems.remove(index);
        }
    }
 
}