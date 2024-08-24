trigger HandlerLead on Lead (after insert,after update) 
{
	if(Trigger.isAfter && Trigger.isinsert)
	{
    	LeadHandler.ProspectInsert(Trigger.new);
	}
    if(Trigger.isupdate && Trigger.isAfter)
    {
        if(CheckRecusive.runOnce())
        {
        LeadHandler.ProspectUpdate(Trigger.Oldmap);
        }
    }
}