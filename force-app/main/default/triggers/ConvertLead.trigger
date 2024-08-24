trigger ConvertLead on Lead (after update) 
{
    if(Trigger.isupdate && Trigger.isAfter)
    {
        LeadConvertApex.ApexLeadConvert(Trigger.new);
    }

}