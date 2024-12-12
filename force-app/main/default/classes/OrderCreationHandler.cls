public with sharing class OrderCreationHandler {
    
}






























































// public with sharing class OrderCreationHandler {
//     @AuraEnabled
//     public static void createOrder(List<Id> cartItemIds) {
//         // Validate input
//         if (cartItemIds == null || cartItemIds.isEmpty()) {
//             throw new AuraHandledException('No cart items selected.');
//         }

//         try {
//             // Query the Cart__c records to get the Line_Total__c fields
//             List<Cart__c> cartItems = [SELECT Id, Line_Total__c FROM Cart__c WHERE Id IN :cartItemIds];
            
//             // Calculate the sum of Line_Total__c
//             Decimal totalOrderAmount = 0;
//             for (Cart__c cartItem : cartItems) {
//                 totalOrderAmount += cartItem.Line_Total__c != null ? cartItem.Line_Total__c : 0;
//             }

//             // Create a new Order__c record
//             Order__c newOrder = new Order__c();
//             newOrder.Order_Total__c = totalOrderAmount;
            
//             // Insert the order record
//             insert newOrder;

//         } catch (Exception e) {
//             // Handle any exceptions
//             throw new AuraHandledException('An error occurred while creating the order: ' + e.getMessage());
//         }
//     }
// }






// public class OrderCreationHandler {
//     public static void createOrder(Id cartId, Order__c orderRecord) {
//         // Fetch Cart details
//         Cart__c cart = [SELECT Id, (SELECT Line_Total__c FROM Cart_Items__r) FROM Cart__c WHERE Id = :cartId];
        
//         // Calculate the Order Total
//         Decimal orderTotal = 0;
//         for (Cart_Item__c cartItem : cart.Cart_Items__r) {
//             orderTotal += cartItem.Line_Total__c;
//         }
        
//         // Set the Order_Total__c field
//         orderRecord.Order_Total__c = orderTotal;
        
//         // Insert the Order
//         insert orderRecord;
//     }
// }