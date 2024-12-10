public class OrderStatusScheduler implements Schedulable {
    private String serializedParams;
 
    public OrderStatusScheduler(String params) {
        this.serializedParams = params;
    }
 
    public void execute(SchedulableContext context) {
        // Deserialize the parameters
        Map<String, String> params = (Map<String, String>) JSON.deserialize(serializedParams, Map<String, String>.class);
        Id orderId = params.get('orderId');
        String email = params.get('email');
 
        // Fetch and update the order
        Order__c order = [SELECT Id, Status__c FROM Order__c WHERE Id = :orderId LIMIT 1];
        order.Status__c = 'Out for Delivery';
        update order;
 
        // Send the second email
        Messaging.SingleEmailMessage emailMessage = new Messaging.SingleEmailMessage();
        emailMessage.setToAddresses(new String[] {email});
        emailMessage.setSubject('Out for Delivery');
        emailMessage.setPlainTextBody('Your order is out for delivery.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {emailMessage});
    }
 
    public static void scheduleStatusUpdate(Id orderId, String email) {
        // Prepare parameters
        Map<String, String> params = new Map<String, String> { 'orderId' => orderId, 'email' => email };
        String serializedParams = JSON.serialize(params);
 
        // Schedule the job
        String jobName = 'OrderStatusUpdate_' + orderId;
        String cronExpression = System.now().addSeconds(10).format('ss mm HH dd MM ? yyyy');
        System.schedule(jobName, cronExpression, new OrderStatusScheduler(serializedParams));
    }
}