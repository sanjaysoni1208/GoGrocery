public class invoiceTriggerHandler {
    public static void createInvoice(List<Order__c> ordlist) {
        // To store the Ids and the Order records    
        Map<Id, Order__c> ordMap = new Map<Id, Order__c>();
        List<Invoice__c> invoicesToInsert = new List<Invoice__c>();
        
        // Storing data in map
        for (Order__c ord : ordlist) {
            if (ord.Status__c == 'Ready for Order') {
                System.debug('Map Record Insert Working...');
                ordMap.put(ord.Id, ord);
            }
        }
        
        // Creating Invoice records
        if (ordMap.size() > 0) {
            for (Id ordId : ordMap.keySet()) {
                Invoice__c newInvoice = new Invoice__c();
                newInvoice.Order__c = ordMap.get(ordId).Id;
                newInvoice.Discount__c = ordMap.get(ordId).Discount_Applied__c;
                newInvoice.Invoice_Total__c = ordMap.get(ordId).Total_Price__c; 
                invoicesToInsert.add(newInvoice);
            }
        }
        
        // Insert invoices
        if (!invoicesToInsert.isEmpty()) {
            insert invoicesToInsert;
            System.debug('Invoices Created: ' + invoicesToInsert);
            
            // Send Email for each invoice
            for (Invoice__c invoice : invoicesToInsert) {
                sendInvoiceEmail(invoice);
            }
        }
    }

    // Method to send email with invoice details
    private static void sendInvoiceEmail(Invoice__c invoice) {
        // Query the related order and user
        Order__c relatedOrder = [SELECT Id, Name, User__r.Email 
                                 FROM Order__c 
                                 WHERE Id = :invoice.Order__c 
                                 LIMIT 1];
        
        if (relatedOrder.User__r.Email != null) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] { relatedOrder.User__r.Email });
            email.setSubject('Your Invoice is Ready');
            
            // Construct the email body
            String emailBody = 'Hello,\n\n';
            emailBody += 'Your invoice has been generated. Here are the details:\n\n';
            emailBody += 'Order Name: ' + relatedOrder.Name + '\n';
            emailBody += 'Invoice Total: ' + invoice.Invoice_Total__c + '\n';
            emailBody += 'Discount Applied: ' + invoice.Discount__c + '\n\n';
            emailBody += 'Thank you for shopping with us!';
            
            email.setPlainTextBody(emailBody);
            
            // Send email
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
            System.debug('Email Sent to: ' + relatedOrder.User__r.Email);
        } else {
            System.debug('No email found for the user related to Order: ' + relatedOrder.Id);
        }
    }
}