trigger ApplyVoucherDiscount on Order__c (before insert, before update, after insert, after update) {

    if (Trigger.isBefore && Trigger.isInsert) {
    // if (Trigger.isBefore){
        VoucherDiscountHandler.applyVoucherDiscount(Trigger.new);
        // ClassTOOrder.createOrder(Trigger.new);
    }
    
    if (Trigger.isAfter) {
        OrderStatusHandler.updateOrderStatus(Trigger.new);
        if(Trigger.isUpdate){
            invoiceTriggerHandler.createInvoice(Trigger.new);
        }
    }
}