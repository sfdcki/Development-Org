public class ContactAndLeadSearch {
	public static List<List< SObject>> searchContactsAndLeads(String data)
    {
         String searchQuery = 'FIND \'' + data + '\' IN ALL FIELDS RETURNING  Lead (LastName),Contact(name,email)';
         List<List<sObject>> searchList = search.query(searchQuery);
		 return searchList;
    }
}