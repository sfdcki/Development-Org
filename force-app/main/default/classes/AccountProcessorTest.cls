@IsTest
public class AccountProcessorTest {

    
    public static testmethod void countContactstest()
    {
        Account a = new Account();
        a.Name = 'Test Account';
        Insert a;
        Contact c = new Contact();
        c.FirstName = 'Test';
        c.LastName = 'Contact';
        c.AccountId = a.Id;
        insert c;
        set<ID> accId = new set<ID>();
        accId.add(a.Id);
        system.Test.startTest();
        	AccountProcessor.countContacts(accId);
        system.Test.stopTest();
        Account acc = [select id, Number_of_Contacts__c from Account where id = :a.Id];
        System.assertEquals(Integer.valueOf(acc.Number_of_Contacts__c), 1);
    }
}