public with sharing class ProductServiceImpl implements IProductService{
	
	public ProductSelector productSelectorObject = new ProductSelector();
    
    public static ProductServiceImpl productServiceImplObject = new ProductServiceImpl();
    
    public static ProductServiceImpl getInstanceOf(){
    	return productServiceImplObject;
    }
    
    public List<Product__c> getProductsById(Set<Id> idSet){
    	return productSelectorObject.selectById(idSet);
    }
    
    public List<Product__c> getProductsByName(String query){
    	return productSelectorObject.selectByName(new Set<String>(),query);
    }
}