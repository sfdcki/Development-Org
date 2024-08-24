public class RelativeAccount {
    public static void ParentToChild()
    {
        list<Account> Acc1 = [select id, name, Accountnumber,
                              (select accountid,CleanStatus, Department, LeadSource, MobilePhone
                                                                           from Contacts),
                         (select Accountid, Amount, LeadSource, Name from opportunities),
                              (select accountid, casenumber,origin,IsEscalated from cases)
                              from Account];
        if(!Acc1.isEmpty())
        {
            for(Account Ac:Acc1)
            {
                system.debug('Account record is:'+Ac);
                if(!Ac.Contacts.isempty())
                {
                    for(contact con:Ac.contacts)
                    {
                        system.debug('Related Contact record is:'+con);
                    }
                }
                if(!Ac.opportunities.isempty())
                {
                    for(opportunity opp:Ac.opportunities)
                    {
                        system.debug('Related opportunity record is:'+opp);
                        
                    }
                }
                if(!Ac.cases.isempty())
                {
                    for(case cs:Ac.cases)
                    {
                        system.debug('related case record is:'+cs);
                    }
                }
            }
        }
    }

}