@IsTest
public class LeadProcessorTest {

    	@TestSetup
    static void setup()
    {
        List<Lead> tRec = new List<Lead>();
        for (Integer i=0;i<200;i++) {
            tRec.add(new Lead(LeadSource = 'Web', LastName = 'TLead '+i, 
                Status = 'Work Done', company = 'Test Company'));
        }
        insert tRec;
    }
    
    @IsTest
    static void testCode()
    {
        LeadProcessor lprocess = new LeadProcessor();
        System.Test.startTest();
        	//System.enqueueBatch(lprocess);
        System.Test.stopTest();
        System.assertEquals(200, [select count() from Lead where LeadSource = 'Dreamforce']);
    }
}