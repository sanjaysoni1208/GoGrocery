trigger RestrictCartAddition on Cart__c (before insert, before update) {
    RestrictCartAdditionHandler.validateStockAvailability(Trigger.new);
}