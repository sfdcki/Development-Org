@isTest
public class TestOpportunityChangeTrigger {
    @isTest static void testCreateAndUpdateOpportunity() {
        Test.enableChangeDataCapture();
        Opportunity oppRec = new Opportunity();
        oppRec.name = 'Sell 100 Widgets';
        oppRec.StageName = 'Prospecting';
        oppRec.CloseDate = Date.today().addMonths(3);
        insert oppRec;
        Test.getEventBus().deliver();
        Opportunity[] oppRecords = [SELECT Id,StageName FROM Opportunity];
        Opportunity opp = oppRecords[0];
        opp.StageName = 'Closed Won';
		update opp;
        Test.getEventBus().deliver();
        Task[] taskList = [SELECT Id,Subject FROM Task];
		System.assertEquals(1, taskList.size(), 'The change event trigger did not create the expected task.');
    }
}