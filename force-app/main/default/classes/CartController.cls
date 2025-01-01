// public with sharing class CartController {
    
//     @AuraEnabled(cacheable=true)
//     public static List<Product__c> getProducts() {
//         // Check field accessibility
//         if (!Schema.sObjectType.Product__c.isAccessible()) {
//             throw new SecurityException('Access to Product__c is denied');
//         }
//         return [SELECT Id, Name, Unit_Price__c, Product_Image__c, Unit__c, Category__c, IsActive__c
//                 FROM Product__c
//                 WHERE IsActive__c = true];
//     }
 
//     @AuraEnabled
//     public static void addToCart(String productId, Decimal quantity) {
//         system.debug('productId'+productId +'quantity'+quantity);
//         List<Cart__c> cartlist = [Select Id,Product__c,Quantity__c from Cart__c WHERE Product__c=:productId];
//         if(cartlist.size()>0){
//           for(Cart__c car:cartlist){
//               car.Quantity__c =  car.Quantity__c+1;
//           }
//         }else {
//             Cart__c   cartItem = new Cart__c(
//                 Product__c = productId,
//                 Quantity__c = quantity
//                 );
//                 insert cartItem;
//         }
//         if(cartlist.size()>0){
//             update cartlist;
//         }
 
       
//             // Add a new cart item
//     }
 
//     @AuraEnabled
//     public static void removeFromCart(String productId, Decimal quantity) {
//         Cart__c cartItem = [SELECT Id, Quantity__c FROM Cart__c WHERE Product__c = :productId AND CreatedById = :UserInfo.getUserId() LIMIT 1];
 
//         if (cartItem != null) {
//             cartItem.Quantity__c -= quantity;
//             if (cartItem.Quantity__c <= 0) {
//                 delete cartItem;
//             } else {
//                 update cartItem;
//             }
//         }
//     }
// }





public with sharing class CartController {
 
    @AuraEnabled(cacheable=true)
    public static List<Product__c> getProducts() {
        // Check field accessibility
        if (!Schema.sObjectType.Product__c.isAccessible()) {
            throw new SecurityException('Access to Product__c is denied');
        }
        return [SELECT Id, Name, Unit_Price__c,Product_Image__c, Unit__c,Category__c, IsActive__c
                FROM Product__c
                WHERE IsActive__c = true
                ORDER BY Name
                ];
    }
       
    @AuraEnabled
    public static void addToCart(String productId, Integer quantity) {
        system.debug('productId'+productId +'quantity'+quantity);
        List<Cart__c> cartlist = [Select Id,Product__c,Quantity__c from Cart__c WHERE Product__c=:productId];
        if(cartlist.size()>0){
            for(Cart__c car:cartlist){
                car.Quantity__c =  car.Quantity__c+1;
            }
        }else {
            Cart__c cartItem = new Cart__c(
                Product__c = productId,
                Quantity__c = quantity
                );
                insert cartItem;
        }
        if(cartlist.size()>0){
            update cartlist;
        }
            // Add a new cart item
    }
 
    @AuraEnabled
    public static void removeFromCart(String productId, Integer quantity) {
        Cart__c cartItem = [SELECT Id, Quantity__c FROM Cart__c WHERE Product__c = :productId  LIMIT 1];
        // Cart__c cartItem = [SELECT Id, Quantity__c FROM Cart__c WHERE Product__c = :productId AND CreatedById = :UserInfo.getUserId() LIMIT 1];
 
        if (cartItem != null) {
            cartItem.Quantity__c = cartItem.Quantity__c - 1;
            if (cartItem.Quantity__c <= 0) {
                delete cartItem;
            } else {
                update cartItem;
            }
        }
    }
}