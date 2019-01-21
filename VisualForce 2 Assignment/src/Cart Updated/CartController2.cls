public class CartController2 {

    public ApexPages.StandardSetController setConProducts {get;set;}
    public ApexPages.StandardSetController setConPurchaseOrders {get;set;}
    
    public Map<Id,Purchase_Line_Items__c> cartItems =  new Map<Id,Purchase_Line_Items__c>();
    public IProductService productServiceObject = new ProductService();
    public IPurchaseOrderService purchaseOrderService = new PurchaseOrderService();
    public IPurchaseLineItemService purchaseLineItemServiceObject = new PurchaseLineItemService();
    public Integer pageSize = 5;
    
    public Purchase_Order__c purchaseOrderObject{get;set;}
    public String productNameQuery{get;set;}
    public Boolean showProductBlock{get;set;}
    public Boolean showPurchaseOrderFormBlock{get;set;}
    public Boolean showCartItemsBlock{get;set;}
    public Boolean showPurchaseOrdersBlock{get;set;}
    public Id productId{get;set;}
    public Id cartItemId{get;set;}
    public Id purchaseOrderId{get;set;}
    public Integer orderCost{get{
                                    Integer totalCost = 0;
                                    for(Purchase_Line_Items__c purchaseLineItemObject : getCartItems()){
                                        totalCost = totalCost + Integer.valueOf(purchaseLineItemObject.Product__r.Price__c * purchaseLineItemObject.Quantity__c) ;
                                    }
                                    return Integer.valueOf(totalCost);
   								 }
                             set;}
    
    public CartController2(){
        purchaseOrderObject = new Purchase_Order__c();
        showProductBlock = false;
        showPurchaseOrderFormBlock = false;
        showCartItemsBlock = false;
        showPurchaseOrdersBlock = true;
    }
    
    public void viewPurchaseItemsOf(){
        if(purchaseOrderID!=null){
           cartItems.putAll(purchaseLineItemServiceObject.selectByPurchaseOrderId(new Set<Id>{purchaseOrderID})) ;
            if(cartItems.size()>0){
               showCartItemsBlock = true;
            }
        }
    }
    
    public List<Purchase_Order__c> getPurchaseOrders(){
        if(setConPurchaseOrders == null){
            setConPurchaseOrders = new ApexPages.StandardSetController(purchaseOrderService.getPurchaseOrderByOwnerId(new Set<Id>{UserInfo.getUserId()}));
            setConPurchaseOrders.setPageSize(pageSize);
            return setConPurchaseOrders.getRecords();
        }
        else{
            return setConPurchaseOrders.getRecords();
        }
    }
    
    public void createAPurchaseOrder(){
        showProductBlock = true;
        showPurchaseOrdersBlock = false;
    }
    
    public List<Product__c> getProducts(){
        if(setConProducts == null){
            setConProducts = new ApexPages.StandardSetController(productServiceObject.getProductsByName(productNameQuery));
            setConProducts.setPageSize(pageSize);
            return setConProducts.getRecords();
        }
        else{
            return setConProducts.getRecords();
        }
    }
    
    public void addToCart(){
        if(productId!=null){
            Purchase_Line_Items__c newCartProductObject = cartItems.get(productId);
            if(newCartProductObject == null ){
                newCartProductObject = new Purchase_Line_Items__c();
                Product__c productObject = new  Product__c();
                List<Product__c>  productList = productServiceObject.getProductsById(new Set<Id>{productId});
                if(productList!=null && productList.size()>0){
                    productObject = productList.get(0);
                } 
                newCartProductObject.Product__r = productObject;
                newCartProductObject.Quantity__c = 1;
                cartItems.put(productId,newCartProductObject);
                showCartItemsBlock = true;
            }
        	else if(newCartProductObject!=null){
            	newCartProductObject.Quantity__c ++;
                cartItems.put(productId,newCartProductObject);
        	}
    	}   
    }
    
    public List<Purchase_Line_Items__c> getCartItems(){
        return cartItems.values();
    }
    
    public void deleteCartItem(){
        if(cartItemId!=null){
            cartItems.remove(cartItemId);
        } 
    }
    
    public void checkOut(){
		showProductBlock = false;
		showPurchaseOrderFormBlock = true;        
    }
    
    public PageReference placeOrder(){
        Boolean purchaseOrderInsertionFailed = false;
        Boolean purchaseOrderItemsInsertionFailed = false;
        SavePoint sp = Database.setSavepoint();
        if(purchaseOrderObject==null || purchaseOrderObject.Name==null){
            purchaseOrderInsertionFailed = true;
            System.debug('XYZ');
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Name is Required.'));
        }
        if(!purchaseOrderInsertionFailed){
            try{
                purchaseOrderObject.Status__c = 'Order Placed';
                purchaseOrderObject.Order_Cost__c = orderCost;
                insert purchaseOrderObject;
            }catch(DMLException e){
                purchaseOrderInsertionFailed = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Order Can\'t be Purchased. Server Side Error.'));
                Database.rollback(sp);
            }
            System.debug(purchaseOrderInsertionFailed);
            if(!purchaseOrderInsertionFailed){
                try{
                 	List<Purchase_Line_Items__c> listToBeInserted = getCartItems();
                    if(listToBeInserted != null && listToBeInserted.size()>0){
                        for(Purchase_Line_Items__c purchaseLineItemObject : listToBeInserted){
                       			 purchaseLineItemObject.Product__c = purchaseLineItemObject.Product__r.Id;
                        		 purchaseLineItemObject.Purchase_Order__c = purchaseOrderObject.Id;
                    		}
                    	insert listToBeInserted ; 
                    }
                    else{
                       DMLException exp = new DMLException();
                       exp.setMessage('Cart Empty.');
                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Order Can\'t be Purchased. Cart is Empty.'));
                       throw exp;
                    }
                }catch(DMLException e){
                    purchaseOrderItemsInsertionFailed = true;
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Order Can\'t be Purchased. Cart Items can\'t be Saved.'));
                    Database.rollback(sp);
                }
                System.debug(purchaseOrderItemsInsertionFailed );
            }
            if(!purchaseOrderInsertionFailed && !purchaseOrderItemsInsertionFailed){
                cancelPurchase();
            }
        }
        return null;
    }
    
    public void addMoreItemsToCart(){
        showProductBlock = true;
        showPurchaseOrderFormBlock = false;
        showCartItemsBlock = true;
    }
    
    public void cancelPurchase(){
        purchaseOrderObject = new Purchase_Order__c();
        cartItems = new Map<Id,Purchase_Line_Items__c>();
        setConProducts = null;
        setConPurchaseOrders=null;
        showProductBlock = false;
        showPurchaseOrderFormBlock = false;
        showCartItemsBlock = false;
        showPurchaseOrdersBlock = true;
    }
}