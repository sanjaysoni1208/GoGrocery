public with sharing class GenerateInvoiceHandler {
    public static void generateInvoiceEmails(List<Order__c> updatedOrders, Map<Id, Order__c> oldOrders) {

        // Collect Order IDs where status is 'Out for Delivery'
        Set<Id> eligibleOrderIds = new Set<Id>();
        Map<Id, Order__c> ordersWithUserInfo = new Map<Id, Order__c>();

        for (Order__c order : updatedOrders) {
            Order__c oldOrder = oldOrders.get(order.Id);
            if (order.Status__c == 'Out for Delivery' && oldOrder.Status__c != 'Out for Delivery') {
                eligibleOrderIds.add(order.Id);
                ordersWithUserInfo.put(order.Id, order);
            }
        }

        if (!eligibleOrderIds.isEmpty()) {
            // Fetch related order items
            Map<Id, List<Order_Item__c>> orderItemsMap = new Map<Id, List<Order_Item__c>>();

            for (Order_Item__c item : [SELECT Order__c, Product__r.Name, Quantity__c, Price__c FROM Order_Item__c WHERE Order__c IN :eligibleOrderIds]) {
                if (!orderItemsMap.containsKey(item.Order__c)) {
                    orderItemsMap.put(item.Order__c, new List<Order_Item__c>());
                }
                orderItemsMap.get(item.Order__c).add(item);
            }

            // Prepare and send emails
            List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
            for (Id orderId : eligibleOrderIds) {
                Order__c order = ordersWithUserInfo.get(orderId);

                // Ensure the user has an email
                if (order.User__r.Email == null) {
                    continue;
                }

                // Prepare item details for the invoice
                String itemDetails = '';
                if (orderItemsMap.containsKey(orderId)) {
                    for (Order_Item__c item : orderItemsMap.get(orderId)) {
                        itemDetails += item.Product__r.Name + ' | Qty: ' + item.Quantity__c + ' | Price: $' + item.Price__c + '\n';
                    }
                }

                // Create the email
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new String[] { order.User__r.Email });
                email.setSubject('Your Invoice for Order #' + order.Name);
                email.setPlainTextBody('Hi ' + order.User__r.Name + ',\n\nThank you for your order!\n\nHere is your invoice:\n\n' + itemDetails + '\n\nTotal: $' + order.Order_Total__c + '\n\nThank you for shopping with us!');
                emails.add(email);
            }

            // Send the emails
            if (!emails.isEmpty()) {
                Messaging.sendEmail(emails);
            }
        }
    }    
}