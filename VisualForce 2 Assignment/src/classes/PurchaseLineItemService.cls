public with sharing class PurchaseLineItemService implements IPurchaseLineItemService{
	
	public List<Purchase_Line_Items__c> selectByPurchaseOrderId(Set<Id> idSet){
		return PurchaseLineItemServiceImpl.getInstanceOf().selectByPurchaseOrderId(idSet);
	}
    
}