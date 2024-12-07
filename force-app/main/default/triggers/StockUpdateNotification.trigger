trigger StockUpdateNotification on Product__c (before insert) {
    if (Trigger.isAfter && Trigger.isUpdate) {
        StockUpdateNotificationHandler.notifyUsersOnStockUpdate(Trigger.new, Trigger.oldMap);
    }
}