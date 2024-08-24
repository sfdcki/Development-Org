global class DailyLeadProcessor implements Schedulable{
    
    global void Execute(SchedulableContext SC) 
    {
        List<Lead> tmpLead = new List<Lead>();
        List<Lead> leadRec = [Select id,leadsource from Lead where leadsource = '' limit 200];
        for(Lead le : leadRec)
        {
            le.leadsource = 'Dreamforce';
            tmpLead.add(le);
        }
        if(tmpLead.size() > 0)
        {
            update tmplead;
        }
    }

}