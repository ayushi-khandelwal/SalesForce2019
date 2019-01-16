public with sharing class PurchaseOrderServiceImpl implements IPurchaseOrderService{
    
    PurchaseOrderSelector purchaseOrderSelectorObject = new PurchaseOrderSelector();
    
    public static PurchaseOrderServiceImpl purchaseOrderServiceImpl = new PurchaseOrderServiceImpl();
    
    public static PurchaseOrderServiceImpl getInstanceOf(){
    	return purchaseOrderServiceImpl;
    }
    
    public List<Purchase_Order__c> getPurchaseOrderById(Set<ID> idSet){
    	return purchaseOrderSelectorObject.selectById(idSet);
    }
    
    public List<Purchase_Order__c> getPurchaseOrderByOwnerId(Set<Id> idSet){
    	return purchaseOrderSelectorObject.selectByOwnerId(idSet);
    }
}