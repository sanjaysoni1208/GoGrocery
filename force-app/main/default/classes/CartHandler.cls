public with sharing class CartHandler {
    @AuraEnabled(cacheable=true)
    public static List<Cart__c> getCartItems() {
        List<Cart__c> result = [SELECT Id, Name, Quantity__c, Line_Total__c, Product__r.Name FROM Cart__c];

        return result;
    }
}