public with sharing class findProductClass {
    @AuraEnabled(cacheable = true)
    public static List<Product__c> getProduct(String searchText){
        try {
            searchText = '%' + searchText + '%';
            return [SELECT Name, Category__c, IsActive__c, Unit__c, Stock_Quantity__c, Unit_Price__c 
                    FROM Product__c 
                    WHERE Name LIKE :searchText 
                    LIMIT 5];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }   
}