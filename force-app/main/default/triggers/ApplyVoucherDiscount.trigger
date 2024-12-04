trigger ApplyVoucherDiscount on Order__c (before insert) {
    if (Trigger.isAfter && Trigger.isInsert) {
        VoucherDiscountHandler.applyVoucherDiscount(Trigger.new);
    }
}