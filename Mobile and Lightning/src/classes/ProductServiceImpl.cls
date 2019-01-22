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
        System.debug(query+'-------');
        System.debug(productSelectorObject.selectByName(new Set<String>{'Name','Id','Price__c','Status__c'},query));
    	return productSelectorObject.selectByName(new Set<String>{'Name','Id','Price__c','Status__c'},query);
    }
}