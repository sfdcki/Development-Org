public class customParentToChild {
	public static void parentToChild()
    {
        string 	que = 'select eMail_Id__c,Phone_Number__c,Position_Count__c,Test_Picklist__c,(select Name,Closing_Date__c,Location__c,Number_of_Candidates__c,(select Name,Age__c,Country__c,Date__c,Nick_name__c,Candidate_Position__c from Candidates__r) from Positions_del__r) from Hiring_Manager__c';
 		list<Hiring_Manager__c> hiri = Database.query(que);
        if(!hiri.isEmpty())
        {
            for(Hiring_Manager__c tempHiri:hiri)
            {
     			system.debug('Hiring manager record is:'+tempHiri);
                if(!tempHiri.Positions_del__r.isempty())
                {
                    for(Position__c pos:tempHiri.Positions_del__r)
                    {
                        system.debug('hiring manager child position record is:'+pos);
                        if(!pos.Candidates__r.isempty())
                        {
                            for(Candidate__c can:pos.Candidates__r)
                            {
                                system.debug('position child record is:'+can);
                            }
                        }
                        
                    }
                }
                
            }
        }
    }
}