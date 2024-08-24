public class customChildToParent {
    public static void childToParent()
    {
        string que = 'select id,name,Age__c,Country__c,Nick_name__c,Candidate_Position__r.id,Candidate_Position__r.name,Hiring_Position__r.id,Hiring_Position__r.name from Candidate__c';
        list<Candidate__c> can = Database.query(que);
        if(!can.isEmpty())
        {
            for(Candidate__c can1:can)
            {
                system.debug('Candidate object record is:'+can1);
                system.debug('position id is:'+can1.Candidate_Position__r.id);
                system.debug('position name is:'+can1.Candidate_Position__r.name);
                system.debug('hiring manager id is:'+can1.Candidate_Position__r.Hiring_Position__r.id);
                system.debug('hiring manager name is:'+can1.Candidate_Position__r.Hiring_Position__r.name);
            }
        }
    }

}