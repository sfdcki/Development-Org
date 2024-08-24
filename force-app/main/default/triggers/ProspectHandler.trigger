trigger ProspectHandler on Prospect__c (after update)
{
    if(Trigger.isafter && Trigger.isupdate)
    {
        if(CheckRecusive.runOnce())
        {
        ProspectHandler.LeadUpdate(Trigger.newmap);
        }
            
    }

}