public class contactContro {

    @auraEnabled
    public static list<Contact> getContacts(Id accId)
    {
     	List<Contact> conList = [select id,name,email,phone,leadsource,Valid_Contact__c from Contact where AccountId=:accId];
        return conList;
    }
}