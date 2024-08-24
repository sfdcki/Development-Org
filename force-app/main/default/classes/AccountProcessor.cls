public class AccountProcessor {
	@future
    public static void countContacts(Set<ID> aID)
    {
        list<Account> acc = [select id,Number_of_Contacts__c,(select id,name from contacts) from Account where Id IN :aID];
        for(Account ac : acc)
        {
            list<Contact> con = ac.contacts;
            ac.Number_of_Contacts__c = con.size();
        }
        update acc;
    }
}