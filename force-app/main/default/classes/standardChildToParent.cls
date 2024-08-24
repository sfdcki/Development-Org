public class standardChildToParent {
	public static void childToParent()
    {
        string query = 'select id,accountid,CleanStatus,Account.id,Account.phone,Account.name from Contact';
        list<contact> con = Database.query(query);
        if(!con.isEmpty())
        {
            for(Contact cont:con)
            {
                system.debug('contact id is:'+cont.id);
                system.debug('contact accountid is:'+cont.accountid);
                system.debug('contact cleanstatus is:'+cont.cleanstatus);
                system.debug('Account id is:'+cont.Account.id);
                system.debug('Account phone is:'+cont.Account.phone);
                system.debug('account name is:'+cont.Account.name);
                system.debug('------------------------------------');
            }
        }
    }
}