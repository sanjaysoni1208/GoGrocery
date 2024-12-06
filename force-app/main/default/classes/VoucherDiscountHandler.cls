public class VoucherDiscountHandler{
    public static void applyVoucherDiscount(List<Order__c> orders){
        
        for (Order__c order : orders){
            if (String.isNotBlank(order.Voucher_Code__c)){
                
                // Fetch Voucher Details
                Voucher__c voucher = [SELECT Code__c, Discount_Amount__c, IsActive__c From Voucher__c WHERE Code__c = :order.Voucher_Code__c Limit 1];
            
                if (voucher != null && voucher.IsActive__c){
                    order.Discount_Applied__c = voucher.Discount_Amount__c;
                    order.Total_Price__c = order.Order_Total__c - voucher.Discount_Amount__c;
                    run = run+1;
                } 
                else
                    order.addError('Invalid or inactive voucher code.');
            }

            else 
                order.Total_Price__c = order.Order_Total__c;
        }
    }
}
