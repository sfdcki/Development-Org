public class ContactSearch {
	public static list<Contact> searchForContacts(String lstName, String PosCode)
    {
        list<Contact> conList = new List<Contact>();
        //String lastName = '\'%'+lstName+'%\'';
        conList = [select Id, Name from Contact where LastName =: lstName and MailingPostalCode =: PosCode];
        return conList;
    }
}