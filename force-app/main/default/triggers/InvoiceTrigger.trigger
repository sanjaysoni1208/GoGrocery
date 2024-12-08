trigger InvoiceTrigger on Invoice__c (before insert, before update) {
    // Collect Order IDs to fetch related data
    Set<Id> orderIds = new Set<Id>();
    for (Invoice__c invoice : Trigger.new) {
        if (invoice.Order__c != null) {
            orderIds.add(invoice.Order__c);
        }
    }

    // Query Order__c records related to these invoices
    Map<Id, Order__c> orderMap = new Map<Id, Order__c>([SELECT Id, Total_Price__c, Discount_Applied__c FROM Order__c WHERE Id IN :orderIds]);

    // Populate Invoice fields with data from related Order__c
    for (Invoice__c invoice : Trigger.new) {
        if (invoice.Order__c != null && orderMap.containsKey(invoice.Order__c)) {
            Order__c relatedOrder = orderMap.get(invoice.Order__c);

            // Set fields in Invoice__c
            invoice.Invoice_Total__c = relatedOrder.Total_Price__c;
            invoice.Discount__c = relatedOrder.Discount_Applied__c;
        }
    }
}
