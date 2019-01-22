public interface IPurchaseLineItemService {
    
    List<Purchase_Line_Items__c> selectByPurchaseOrderId(Set<Id> idSet);
    
}