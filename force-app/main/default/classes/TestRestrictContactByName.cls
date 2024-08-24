@isTest
public class TestRestrictContactByName {

    @isTest static void checkContactTrigger()
    {
        Contact con = new Contact(LastName = 'test');
        insert con;
    }
    @isTest static void checkContactTriggerNegative()
    {
        Contact con = new Contact(LastName = 'INVALIDNAME');
        insert con;
    }
}