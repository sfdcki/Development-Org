trigger OpportunityChangeTrigger on OpportunityChangeEvent (after insert) {
List<Task> tasks = new List<Task>();
  // Iterate through each event message.
  for (OpportunityChangeEvent event : Trigger.New) {
    // Get some event header fields
    EventBus.ChangeEventHeader header = event.ChangeEventHeader;
    System.debug('Received change event for ' +
      header.entityName +
      ' for the ' + header.changeType + ' operation.');
    // For update operations, we can get a list of changed fields
    if (header.changetype == 'UPDATE') {
        System.debug('List of all changed fields:');
        for (String field : header.changedFields) {
            if(field == 'StageName' && event.iswon == true){
                    Task tk = new Task();
                    tk.Subject = 'Follow up on employee record(s): ' +
                        header.recordIds;
                    tk.OwnerId = header.CommitUser;
                    tasks.add(tk);
            }
                   }
    }
    // Get record fields and display only if not null.
    // Create a followup task
    
  }
  // Insert all tasks in bulk.
  if (tasks.size() > 0) {
    insert tasks;
  }
}