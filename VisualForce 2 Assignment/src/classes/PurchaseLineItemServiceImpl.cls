public with sharing class PurchaseLineItemServiceImpl implements IPurchaseLineItemService{
	
	public PurchaseLineItemSelector purchaseLineItemSelectorObject = new PurchaseLineItemSelector();
    
    public static PurchaseLineItemServiceImpl purchaseLineItemServiceObject= new PurchaseLineItemServiceImpl();
    
    public static PurchaseLineItemServiceImpl getInstanceOf(){
    	return purchaseLineItemServiceObject;
    }
    
    public List<Purchase_Line_Items__c> selectByPurchaseOrderId(Set<Id> idSet){
    	return purchaseLineItemSelectorObject.selectByPurchaseOrderId(idSet);
    }
}