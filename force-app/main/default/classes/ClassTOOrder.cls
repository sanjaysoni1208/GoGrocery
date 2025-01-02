public class ClassTOOrder {
    public static void createOrder(list<Order__c> orders){
        
        Cart__c c = new Cart__c();
        list<Cart__c> cart = [SELECT Id, Name, Product__c, Quantity__c, Line_Total__c FROM Cart__c];
        Set<Id> ordId = new Set<Id>();
        Decimal Total=0;
        
        // Collect all voucher codes from the orders
        for (Order__c order : orders){
            if (order.Id != NULL){                
                ordId.add(order.Id);
            }
        }
        
        for(Cart__c car : cart){
            Total = Total + car.Line_Total__c;
            System.debug(Total);
        }
        
        System.debug(Total);
        for(Order__c ord : orders){
            ord.Order_Total__c = Total;
        }
    }
}
