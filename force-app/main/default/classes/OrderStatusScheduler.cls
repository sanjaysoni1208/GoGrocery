// A class to handle scheduling and updating the status of an order
// Implements the Schedulable interface to allow scheduling in Salesforce

public class OrderStatusScheduler implements Schedulable {
    // A variable to store serialized parameters
    private String serializedParams;

    // Constructor to initialize the serialized parameters
    public OrderStatusScheduler(String params) {
        this.serializedParams = params;
    }

    // This method is executed when the scheduled job runs
    public void execute(SchedulableContext context) {

        // Step 1: Deserialize the parameters to extract orderId and email
        Map<String, String> params = (Map<String, String>) JSON.deserialize(serializedParams, Map<String, String>.class);
        Id orderId = params.get('orderId'); // Get the order ID from the parameters
        String email = params.get('email'); // Get the email address from the parameters

        // Step 2: Retrieve the order record from the database
        Order__c order = [SELECT Id, Status__c FROM Order__c WHERE Id = :orderId LIMIT 1];

        // Step 3: Update the order status to 'Out for Delivery'
        order.Status__c = 'Out for Delivery';
        update order; // Save the changes to the database

        // Step 4: Send an email notification to the user
        Messaging.SingleEmailMessage emailMessage = new Messaging.SingleEmailMessage();
        emailMessage.setToAddresses(new String[] { email }); // Set the recipient email
        emailMessage.setSubject('Out for Delivery'); // Set the email subject
        emailMessage.setPlainTextBody('Your order is out for delivery.'); // Set the email content
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { emailMessage }); // Send the email
    }

    // A static method to schedule the job for updating the order status
    public static void scheduleStatusUpdate(Id orderId, String email) {

        // Step 1: Prepare a map of parameters (orderId and email) to send to the scheduler
        Map<String, String> params = new Map<String, String> { 'orderId' => orderId, 'email' => email };
        String serializedParams = JSON.serialize(params); // Convert the map to a JSON string

        // Step 2: Define a unique job name using the orderId
        String jobName = 'OrderStatusUpdate_' + orderId;

        // Step 3: Create a cron expression to run the job 10 seconds from now
        String cronExpression = System.now().addSeconds(10).format('ss mm HH dd MM ? yyyy');

        // Step 4: Schedule the job using the job name, cron expression, and this scheduler class
        System.schedule(jobName, cronExpression, new OrderStatusScheduler(serializedParams));
    }
}
