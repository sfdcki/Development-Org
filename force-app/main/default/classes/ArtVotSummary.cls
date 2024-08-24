public class ArtVotSummary {
 public Id posId       {get;set;}
    public String checknumber       {get;set;}
    public list<Article_Votes__c> articleVotes {get;set;}
    private String sortDirection = 'ASC';
    private String sortExp = 'Name';
     public String votId       {get;set;}
 
    public ArtVotSummary() {
				
        this.ViewData();
    }

 
   public PageReference delVote()
   {
       Article_Votes__c toDel=new Article_Votes__c(id=votId);
  
 		delete todel;
       // PageReference RetPage = ApexPages.currentPage();
       // RetPage.setRedirect(false);
       // return RetPage; 
  
 		ViewData();
   
	 return null;
   }
   public void ViewData() {
 
      
       //query the database based on the sort expression
       articleVotes = Database.query('select Id,Name, Feedback__c, KB_Article__c, Vote__c from Article_Votes__c');
//       articleVotes = Database.query('select Name, Feedback__c, KB_Article__c, Vote__c from Article_Votes__c where KB_Article__c=:' + posId);
     //  return null;
   }

}