public with sharing class ProductService implements IProductService{
    
    public List<Product__c> getProductsById(Set<Id> idSet){
    	return ProductServiceImpl.getInstanceOf().getProductsById(idSet);
    }
    
    public List<Product__c> getProductsByName(String query){
    	return ProductServiceImpl.getInstanceOf().getProductsByName(query);
    }
}