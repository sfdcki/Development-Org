trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
if(Trigger.isinsert || Trigger.isupdate)
{
    if(Trigger.isafter)
    {
        List<Task> lisTask = new List<Task>();
        for(Opportunity opp : Trigger.new)
        {
            if(opp.StageName == 'Closed Won')
            {
                Task t1 = new Task();
                t1.whatId = opp.Id;
                t1.subject = 'Follow Up Test Task';
                lisTask.add(t1);
            }
           
        }
         insert lisTask;
    }
}
}