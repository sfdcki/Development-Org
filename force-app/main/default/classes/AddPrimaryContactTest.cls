@isTest
public class AddPrimaryContactTest {

    static testMethod void TestList()
    {
        List<Account> Testa = new List<Account>();
        for(Integer i = 0; i < 50; i++)
        {
            Account acc = new Account(Name = 'Test'+i, BillingState = 'NY');
            Testa.add(acc);
        }
        for(Integer j = 0; j < 50; j++)
        {
            Account acc = new Account(Name = 'Test'+j, BillingState = 'CA');
            Testa.add(acc);
        }
        Contact co = new Contact();
        co.FirstName = 'test';
        co.LastName = 'first';
        insert co;
        String state = 'CA';
        AddPrimaryContact apc = new AddPrimaryContact(co,state);
        System.Test.startTest();
        	System.enqueueJob(apc);
        System.Test.stopTest();
    }
}