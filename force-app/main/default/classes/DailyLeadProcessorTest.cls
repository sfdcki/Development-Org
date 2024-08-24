@isTest
public class DailyLeadProcessorTest {

    @testSetup
    static void testData()
    {	
        List<Lead> teRec = new List<Lead>();
        for(integer i=0;i<200;i++)
        {
                teRec.add(new Lead(LastName = 'TLead '+i, 
                Status = 'Work Done', company = 'Test Company'));
        }
        insert teRec;
    }
    static testMethod void testFun()
    {
        String CRON_EXP = '0 0 0 15 3 ? 2022';
		System.Test.startTest();
        	String jobId = System.schedule('ScheduledApexTest',CRON_EXP,new DailyLeadProcessor());         
      	System.Test.stopTest();

    }
}