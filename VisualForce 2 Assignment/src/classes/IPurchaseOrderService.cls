public interface IPurchaseOrderService {
   
   List<Purchase_Order__c> getPurchaseOrderById(Set<ID> idSet);
   
   List<Purchase_Order__c> getPurchaseOrderByOwnerId(Set<ID> idSet);
}