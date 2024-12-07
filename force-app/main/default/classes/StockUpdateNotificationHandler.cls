// public with sharing class StockUpdateNotificationHandler {
    // public static void notifyUsersOnStockUpdate(List<Product__c> newProducts, Map<Id, Product__c> oldProductMap) {
    //     // Set to collect product IDs whose stock increased
    //     Set<Id> updatedProductIds = new Set<Id>();
        
    //     // Identify products with increased stock
    //     for (Product__c product : newProducts) {
    //         Product__c oldProduct = oldProductMap.get(product.Id);
    //         if (product.Stock_Quantity__c > oldProduct.Stock_Quantity__c) {
    //             updatedProductIds.add(product.Id);
    //         }
    //     }
        
    //     if (!updatedProductIds.isEmpty()) {
    //         // Fetch carts for products with increased stock
    //         Map<Id, List<Cart__c>> productToCartsMap = new Map<Id, List<Cart__c>>();
    //         for (Cart__c cart : [SELECT User__r.Email, User__r.Name, Product__r.Name, Product__c FROM Cart__c WHERE Product__c IN :updatedProductIds]) {
    //             if (!productToCartsMap.containsKey(cart.Product__c)) {
    //                 productToCartsMap.put(cart.Product__c, new List<Cart__c>());
    //             }
    //             productToCartsMap.get(cart.Product__c).add(cart);
    //         }

    //         // Create email notifications
    //         List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

    //         for (Product__c product : newProducts) {
    //             if (productToCartsMap.containsKey(product.Id)) {
    //                 List<Cart__c> carts = productToCartsMap.get(product.Id);
    //                 for (Cart__c cart : carts) {
    //                     if (cart.User__r.Email != null) { 
    //                         // Ensure email exists
    //                         Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
    //                         email.setToAddresses(new String[] { cart.User__r.Email });
    //                         email.setSubject('Product Back in Stock!');
    //                         email.setPlainTextBody('Hi ' + cart.User__r.Name + ',\n\nThe product "' 
    //                                                 + product.Name + '" is back in stock. Hurry up and place your order!\n\nThank you!');
    //                         emails.add(email);
    //                     }
    //                 }
    //             }
    //         }

    //         // Send emails if there are any
    //         if (!emails.isEmpty()) {
    //             Messaging.sendEmail(emails);
    //         }
    //     }
    // }    
// }



public class StockUpdateNotificationHandler {

    public static void notifyUsersOnStockUpdate(List<Product__c> newProducts, Map<Id, Product__c> oldProductMap) {
        // List to collect emails to send
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        // Iterate over updated products
        for (Product__c product : newProducts) {
            Product__c oldProduct = oldProductMap.get(product.Id);

            // Check if stock quantity has increased
            if (product.Stock_Quantity__c > oldProduct.Stock_Quantity__c) {
                // Fetch users with this product in their cart
                List<Cart__c> carts = [SELECT User__r.Email, User__r.Name, Product__r.Name
                                        FROM Cart__c 
                                        WHERE Product__c = :product.Id];

                // Create email notifications for each user
                for (Cart__c cart : carts) {
                    if (cart.User__r.Email != null) { // Ensure email exists
                        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                        email.setToAddresses(new String[] { cart.User__r.Email });
                        email.setSubject('Product Back in Stock!');
                        email.setPlainTextBody('Hi ' + cart.User__r.Name + ',\n\nThe product "' 
                                                + cart.Product__r.Name + '" is back in stock. Hurry up and place your order!\n\nThank you!');
                        emails.add(email);
                    }
                }
            }
        }

        // Send emails if there are any
        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }
    }
}
    
