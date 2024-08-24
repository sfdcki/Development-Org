public class CandidateSearchController 
{
    Public string candidateName {get;set;}
    Public List<Candidate__c> lstCands {get;set;}

    public CandidateSearchController(ApexPages.StandardController controller) 
    {

    }
    
    Public void SearchCandidates()
    {
        if(candidateName != null && CandidateName != '')
        {
            candidateName +='%';
            lstCands = new List<Candidate__c>();
            
            lstCands = [select id, name, Candidate_Position__c , Nick_name__c from candidate__C where name like : candidateName];
        }
    }

}