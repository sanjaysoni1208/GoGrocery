public class VoucherDiscountHandler {
    
    public static void applyVoucherDiscount(List<Order__c> orders) {
        // Collect voucher codes from the orders
        Set<String> voucherCodes = new Set<String>();
        for (Order__c order : orders) {
            if (String.isNotBlank(order.Voucher_Code__c)) {
                voucherCodes.add(order.Voucher_Code__c);
            }
        }

        // Fetch all voucher details for the provided codes
        Map<String, Voucher__c> voucherMap = new Map<String, Voucher__c>(
            [SELECT Code__c, Discount_Amount__c, IsActive__c 
             FROM Voucher__c 
             WHERE Code__c IN :voucherCodes]
        );

        // Apply discount or log errors on the order
        for (Order__c order : orders) {
            if (String.isNotBlank(order.Voucher_Code__c)) {
                Voucher__c voucher = voucherMap.get(order.Voucher_Code__c);

                if (voucher != null && voucher.IsActive__c) {
                    order.Discount_Applied__c = voucher.Discount_Amount__c;
                    order.Order_Total__c -= voucher.Discount_Amount__c;
                    // order.Voucher_Error_Message__c = null; // Clear any previous error
                } else {
                    order.addError('Invalid or inactive voucher code: ' + order.Voucher_Code__c);
                }
            }
        }
    }
}




// public with sharing class VoucherDiscountHandler {
    // public VoucherDiscountHandler() {

    // }


    // public static void applyVoucherDiscount(List<Order__c> orders) {
    //     // Collect voucher codes from the orders
    //     Set<String> voucherCodes = new Set<String>();
    //     for (Order__c order : orders) {
    //         if (String.isNotBlank(order.Voucher_Code__c)) {
    //             voucherCodes.add(order.Voucher_Code__c);
    //         }
    //     }

    //     // Fetch all voucher details for the provided codes
    //     Map<String, Voucher__c> voucherMap = new Map<String, Voucher__c>(
    //         [SELECT Code__c, Discount_Amount__c, IsActive__c 
    //          FROM Voucher__c 
    //          WHERE Code__c IN :voucherCodes]
    //     );

    //     // Apply discount or set an error on the order
    //     for (Order__c order : orders) {
    //         if (String.isNotBlank(order.Voucher_Code__c)) {
    //             Voucher__c voucher = voucherMap.get(order.Voucher_Code__c);

    //             if (voucher != null && voucher.IsActive__c) {
    //                 order.Discount_Applied__c = voucher.Discount_Amount__c;
    //                 order.Order_Total__c -= voucher.Discount_Amount__c;
    //             } else {
    //                 order.addError('Invalid or inactive voucher code: ' + order.Voucher_Code__c);
    //             }
    //         }
    //     }
    // }


    // public static void applyVoucherDiscount(List<Order__c> orders) {
    //     Set<String> voucherCodes = new Set<String>();
    //     for (Order__c order : orders) {
    //         if (String.isNotBlank(order.Voucher_Code__c)) {
    //             voucherCodes.add(order.Voucher_Code__c);
    //         }
    //     }
    
    //     Map<String, Voucher__c> voucherMap = new Map<String, Voucher__c>(
    //         [SELECT Code__c, Discount_Amount__c, IsActive__c 
    //          FROM Voucher__c 
    //          WHERE Code__c IN :voucherCodes]
    //     );
    
    //     for (Order__c order : orders) {
    //         if (String.isNotBlank(order.Voucher_Code__c)) {
    //             Voucher__c voucher = voucherMap.get(order.Voucher_Code__c);
    
    //             if (voucher != null && voucher.IsActive__c) {
    //                 if (order.Order_Total__c >= voucher.Discount_Amount__c) {
    //                     order.Discount_Applied__c = voucher.Discount_Amount__c;
    //                     order.Order_Total__c -= voucher.Discount_Amount__c;
    //                 } else {
    //                     order.addError('Discount exceeds order total.');
    //                 }
    //             } else {
    //                 order.addError('Invalid or inactive voucher code: ' + order.Voucher_Code__c);
    //             }
    //         }
    //     }
    // }
// }