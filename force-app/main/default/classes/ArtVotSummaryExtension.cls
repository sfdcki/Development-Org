public class ArtVotSummaryExtension {
    
    public Id posId       {get;set;}
    public String checknumber       {get;set;}
    public list<Article_Votes__c> articleVotes {get;set;}
    private String sortDirection = 'ASC';
    private String sortExp = 'Name';
 
    public ArtVotSummaryExtension() {
				
        this.ViewData();
    }

   public String sortExpression
   {
     get
     {
        return sortExp;
     }
     set
     {
       //if the column is clicked on then switch between Ascending and Descending modes
       if (value == sortExp)
         sortDirection = (sortDirection == 'ASC')? 'DESC' : 'ASC';
       else
         sortDirection = 'ASC';
       sortExp = value;
     }
   }

 public String getSortDirection()
 {
    //if not column is selected 
    if (sortExpression == null || sortExpression == '')
      return 'ASC';
    else
     return sortDirection;
 }

 public void setSortDirection(String value)
 {  
   sortDirection = value;
 }
  
   public List<Article_Votes__c> getArticles() {
       return articleVotes;
   }


   public PageReference ViewData() {
       //build the full sort expression
       string sortFullExp = sortExpression  + ' ' + sortDirection;
      
       //query the database based on the sort expression
       articleVotes = Database.query('select Id,Name, Feedback__c, KB_Article__c, Vote__c from Article_Votes__c ORDER BY '+ sortFullExp);
//       articleVotes = Database.query('select Name, Feedback__c, KB_Article__c, Vote__c from Article_Votes__c where KB_Article__c=:' + posId);
       return null;
   }

}