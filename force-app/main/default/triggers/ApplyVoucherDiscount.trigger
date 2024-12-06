// trigger ApplyVoucherDiscount on Order__c (before insert) {
//     if (Trigger.isAfter && Trigger.isInsert) {
//         VoucherDiscountHandler.applyVoucherDiscount(Trigger.new);
//     }
// }




trigger ApplyVoucherDiscount on Order__c (before insert, before update, after insert, after update) {
    if (Trigger.isBefore) {
        VoucherDiscountHandler.applyVoucherDiscount(Trigger.new);
    }
}




// trigger ApplyVoucherDiscount on Order__c (before insert) {
//     for (Order__c order : Trigger.new) {
//         if (String.isNotBlank(order.Voucher_Code__c)) {
//             // Fetch voucher details
//             Voucher__c voucher = [SELECT Discount_Amount__c, IsActive__c 
//                                   FROM Voucher__c 
//                                   WHERE Code__c = :order.Voucher_Code__c LIMIT 1];
            
//             if (voucher != null && voucher.IsActive__c) {
//                 order.Discount_Applied__c = voucher.Discount_Amount__c;
//                 order.Order_Total__c -= voucher.Discount_Amount__c;
//             } else {
//                 order.addError('Invalid or inactive voucher code.');
//             }
//         }
//     }
// }
