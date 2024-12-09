public with sharing class RestrictCartAdditionHandler {
    public static void validateStockAvailability(List<Cart__c> cartRecords) {
        
        // Collect product IDs from cart records
        Set<Id> productIds = new Set<Id>();
        for (Cart__c cart : cartRecords) {
            if (cart.Product__c != null) {
                productIds.add(cart.Product__c);
            }
        }

        // Query stock quantities for all related products
        Map<Id, Product__c> productStockMap = new Map<Id, Product__c>([SELECT Id, Stock_Quantity__c FROM Product__c WHERE Id IN :productIds]);

        // Validate stock availability
        for (Cart__c cart : cartRecords) {
            if (cart.Product__c != null && productStockMap.containsKey(cart.Product__c)) {
                Product__c product = productStockMap.get(cart.Product__c);
                
                // If Quatity is Greater than the Available Stock
                if (cart.Quantity__c > product.Stock_Quantity__c) {
                    cart.addError('Insufficient stock for the selected product.');
                }
                
                // If Quantity Less than or Equal to Available Stock then Subtract Quantity
                else if(cart.Quantity__c <= product.Stock_Quantity__c){
                    product.Stock_Quantity__c = product.Stock_Quantity__c - cart.Quantity__c;
                    
                    // If the Stock Quantity becomes equal to 0 => Product becomes Inactive
                    if(product.Stock_Quantity__c==0)
                        product.isActive__c = false;
                    
                    update product;
                }
            }
        }
    }
}