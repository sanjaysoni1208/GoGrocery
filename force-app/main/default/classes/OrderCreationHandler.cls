public class OrderCreationHandler {
    public static void createOrder(Id cartId, Order__c orderRecord) {
        // Fetch Cart details
        Cart__c cart = [SELECT Id, (SELECT Line_Total__c FROM Cart_Items__r) FROM Cart__c WHERE Id = :cartId];
        
        // Calculate the Order Total
        Decimal orderTotal = 0;
        for (Cart_Item__c cartItem : cart.Cart_Items__r) {
            orderTotal += cartItem.Line_Total__c;
        }
        
        // Set the Order_Total__c field
        orderRecord.Order_Total__c = orderTotal;
        
        // Insert the Order
        insert orderRecord;
    }
}