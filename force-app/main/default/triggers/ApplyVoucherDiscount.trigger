trigger ApplyVoucherDiscount on Order__c (before insert, before update, after update) {
    if (Trigger.isBefore) {
        VoucherDiscountHandler.applyVoucherDiscount(Trigger.new);
    }

    if(Trigger.isAfter) {
        VoucherDiscountHandler.sendVoucherNotification(Trigger.new);
    }
}