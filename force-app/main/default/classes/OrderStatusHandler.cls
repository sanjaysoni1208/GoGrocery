public class OrderStatusHandler {
    public static void updateOrderStatus(List<Order__c> orders) {
        List<Order__c> ordersToUpdate = new List<Order__c>();
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for (Order__c order : orders) {
            // Check if the order has a contact and is new
            if (order.Status__c == 'Pending' && order.User__c != null) {
                // Create a clone to modify and add to the update list
                Order__c updatedOrder = new Order__c(Id = order.Id);
                updatedOrder.Status__c = 'Ready for Order';
                ordersToUpdate.add(updatedOrder);

                // Fetch contact details for email
                Contact contact = [SELECT Id, Email FROM Contact WHERE Id = :order.User__c];
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new String[] {contact.Email});
                email.setSubject('Ready for Order');
                email.setPlainTextBody('Your order is now ready.');
                emails.add(email);

                // Schedule the status update to 'Out for Delivery' and second email
                OrderStatusScheduler.scheduleStatusUpdate(order.Id, contact.Email);
            }
        }

        // Perform the DML update
        if (!ordersToUpdate.isEmpty()) {
            update ordersToUpdate;
        }

        // Send immediate emails
        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }
    }
}