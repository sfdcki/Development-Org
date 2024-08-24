trigger AccountAddressTrigger on Account (before insert, before update) {
    if(Trigger.isinsert || Trigger.isupdate)
    {
        if(Trigger.isbefore)
        {
            for(Account acc : Trigger.new)
            {
                if(acc.Match_Billing_Address__c && acc.BillingPostalCode != null)
                {
                    acc.ShippingPostalCode = acc.BillingPostalCode;
                }
            }
        }
    }

}