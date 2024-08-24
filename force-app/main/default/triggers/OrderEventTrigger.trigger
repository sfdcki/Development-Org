// Trigger for listening to Cloud_News events.
trigger OrderEventTrigger on Order_Event__e (after insert) {    
    // List to hold all cases to be created.
    List<Task> lstTask = new List<Task>();
    
    // Get queue Id for case owner

       
    // Iterate through each notification.
    for (Order_Event__e event : Trigger.New) {
        if (event.Has_Shipped__c == true) {
            // Create Case to dispatch new team.
            Task ts = new Task();

            //task.OwnerId = event.CreatedById;
            ts.Subject = 'Follow up on shipped order ' + event.Order_Number__c;
            ts.Priority= 'Medium';
            ts.status = 'Not Started';
            ts.description = 'Follow up on shipped order ' + event.Order_Number__c;
            lstTask.add(ts);

   }
    }
    // Insert all cases corresponding to events received.
    insert lstTask;
}