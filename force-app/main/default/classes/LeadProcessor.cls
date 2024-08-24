global class LeadProcessor implements Database.Batchable<SObject>
{
	global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String que = 'select id from Lead where LeadSource = \'Web\'';
        return Database.getQueryLocator(que);
    }
    global void Execute(Database.BatchableContext BC, List<Sobject> recordsToProcess)
    {
        List<Lead> rec = new List<Lead>();
        if(recordsToProcess.size() > 0){
        for(SObject Le : recordsToProcess)
        {
            Lead lrec = (Lead)Le;
            Lrec.LeadSource = 'Dreamforce';
            rec.add(Lrec);
        }
        update rec;}
    }
    global void Finish(Database.BatchableContext BC)
    {
        
    }
}