trigger ApplyVoucherDiscount on Order__c (before insert, before update) {
    // if (Trigger.isBefore) {
        VoucherDiscountHandler.applyVoucherDiscount(Trigger.new);
    // }
}