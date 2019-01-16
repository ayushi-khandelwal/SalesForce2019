public interface IProductService {
    
    List<Product__c> getProductsById(Set<Id> idSet);
    
    List<Product__c> getProductsByName(String query);
}