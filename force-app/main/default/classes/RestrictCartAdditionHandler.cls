public with sharing class RestrictCartAdditionHandler {
    public static void validateStockAvailability(List<Cart__c> cartRecords) {
        
        // Collect product IDs from cart records
        Set<Id> productIds = new Set<Id>();
        for (Cart__c cart : cartRecords){
            if (cart.Product__c != null)
                productIds.add(cart.Product__c);
        }

        // Query stock quantities for all related products
        Map<Id, Product__c> productStockMap = new Map<Id, Product__c>([SELECT Id, Stock_Quantity__c FROM Product__c WHERE Id IN :productIds]);

        // Validate stock availability
        for (Cart__c cart : cartRecords) {
            if (cart.Product__c != null && productStockMap.containsKey(cart.Product__c)){
                Product__c product = productStockMap.get(cart.Product__c);
                
                if (cart.Quantity__c > product.Stock_Quantity__c)
                    cart.addError('Insufficient stock for the selected product.');
            }
        }
    }
}