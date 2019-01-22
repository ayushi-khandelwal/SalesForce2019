public with sharing class PurchaseOrderService implements IPurchaseOrderService{
	
	public List<Purchase_Order__c> getPurchaseOrderById(Set<ID> idSet){
		return PurchaseOrderServiceImpl.getInstanceOf().getPurchaseOrderById(idSet);
	}
	
	public List<Purchase_Order__c> getPurchaseOrderByOwnerId(Set<Id> idSet){
    	return PurchaseOrderServiceImpl.getInstanceOf().getPurchaseOrderByOwnerId(idSet);
    }
}