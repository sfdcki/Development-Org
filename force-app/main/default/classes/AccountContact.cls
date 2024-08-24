public class AccountContact {
    public static void UpdateContact(string tname)
    {
        String Quer = 'select id,phone from '+tname+' where phone != null';
        list<Account> Acc = Database.query(Quer);
        list<Contact> Con = [select id,accountid, Phone from Contact];
     	if(!Acc.isEmpty())
        {
            for(Account Ac1:Acc)
        	{	
                for(Contact Co1:Con)
                {
                System.debug('Account Rec is '+Ac1);
                system.debug('test debug');
                system.debug('test debug1');
                system.debug('test debug2');
        	   		if(Ac1.id == Co1.accountid & Co1.Phone != Ac1.Phone)
                    {
                    Co1.Phone = Ac1.Phone;
                        System.debug('Phone is:'+Ac1.Phone);
                }
                }}
            Database.update(Con);
        
    }

    }
    }