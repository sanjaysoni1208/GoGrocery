trigger GenerateInvoice on Order__c (after update) {
    for (Order__c order : Trigger.new) {
        if (order.Status__c == 'Out for Delivery') {
            // Fetch Order Items
            List<Order_Item__c> items = [SELECT Product__r.Name, Quantity__c, Price__c FROM Order_Item__c WHERE Order__c = :order.Id];
            
            String itemDetails = '';
            for (Order_Item__c item : items) {
                itemDetails += item.Product__r.Name + ' | Qty: ' + item.Quantity__c + ' | Price: $' + item.Price__c + '\n';
            }
            
            // Prepare Invoice Email
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] { order.User__r.Email });
            email.setSubject('Your Invoice for Order #' + order.Name);
            email.setPlainTextBody('Hi ' + order.User__r.Name + ',\n\nThank you for your order!\n\nHere is your invoice:\n\n' + itemDetails + '\n\nTotal: $' + order.Order_Total__c + '\n\nThank you for shopping with us!');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
        }
    }
}