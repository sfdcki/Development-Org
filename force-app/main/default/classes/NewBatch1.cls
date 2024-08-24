Global class NewBatch1 implements Database.Batchable<SObject>
{
    Global Database.QueryLocator start(Database.BatchableContext BC)
    {
        string Que = 'select id,phone,fax from contact';
        return Database.getQueryLocator(Que);
    }
    Global void Execute(Database.BatchableContext BC,list<SObject> RecordToProcess)
    {
        list<Contact> CList = new list<Contact>();
        for(SObject So:RecordToProcess)
        {
            Contact Con = (Contact) So;
            Con.Phone = '111112222';
            Con.Fax = '9988776655';
            CList.add(Con);
        }
        if(!CList.isEmpty())
        {
        	update CList;
        }
    }
    Global void Finish(Database.BatchableContext BC)
    {
                string BStatus = 'Batch Status '+BC.GetJobId();
        AsyncApexJob JobDetails = [select id, status, totaljobitems, 
                                   	numberoferrors, jobitemsprocessed, createdby.email from
                                  	asyncapexjob where id =: BC.GetJobId()];
        string Econtent = 'Contacts batch job status' + JobDetails.Id + 'Number of Job Items'+JobDetails.TotalJobItems
            +'number of job items processed'+JobDetails.JobItemsProcessed;
    }

}