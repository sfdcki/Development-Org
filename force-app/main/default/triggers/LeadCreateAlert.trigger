trigger LeadCreateAlert on Lead (after insert) 
{
    if(Trigger.isinsert && Trigger.isafter)
    {
        for(Lead l:Trigger.new)
        {
        LeadCreateConfirmation.LeadCreateAlert(l.id);
        }        
    }

}