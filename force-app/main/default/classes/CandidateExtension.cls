global class CandidateExtension 
{
    public string CandidateName;
    public static list<Candidate__C> SearchCandidateList;
    public CandidateExtension(ApexPages.StandardController controller) {

    }
    @RemoteAction
    global static list<Candidate__C> searchCandidate(string CandidateName)
    {
        CandidateName = '%'+CandidateName+'%';
        SearchCandidateList = [select id,name,Age__c,Country__c,Manager__c,Qualified_Year__c from Candidate__c where name like :CandidateName];
        return SearchCandidateList;
    }
}