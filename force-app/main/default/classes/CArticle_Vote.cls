public class CArticle_Vote {
    
      @AuraEnabled
    public static void createArticle(Integer type, String artId, String name, String comment) { 
        Id ProId =  Id.valueOf(artId);
 		Id Prod = [Select KnowledgeArticleId FROM KnowledgeArticleVersion WHERE PublishStatus = 'Online' AND Language = 'en_US' AND Id =: ProId].KnowledgeArticleId;
        String prodStr = String.valueOf(Prod);
        list<Article_Vote_Summary__c> artSummary = [Select Id,KB_Article_ID__c FROM Article_Vote_Summary__c WHERE KB_Article_ID__c =: prodStr];
		if(artSummary.isEmpty())
        {
            Article_Vote_Summary__c artSum = new Article_Vote_Summary__c();
            artSum.Name = name;
            artSum.KB_Article_ID__c = String.valueOf(Prod);
            try{
            		insert artSum;    
            } catch(Exception e)
            {
                System.debug('Error while master data creation');
            }
			
			Id artlId = artSum.Id;  
            //string Prostrid =  String.valueOf(artlId).substring(0, 15);
            //Id arId = Id.valueOf(Prostrid);
            //return(arId);
            createChild(artlId,type,comment,artId);
        } else{
            
            //string Prostrid =  String.valueOf(artSummary.get(0).Id).substring(0, 15);
            //Id arId = Id.valueOf(Prostrid);
            //return(arId);
            createChild(artSummary.get(0).Id,type,comment,artId);
        }
    }
     private static void createChild(Id kId,integer vot,String comment,String versionId) {
        Article_Votes__c artVote = new Article_Votes__c();
        artVote.Name = versionId;
        artVote.Feedback__c = comment;
        artVote.Vote__c	= Integer.valueOf(vot);
        //artVote.Vote__c = -1;
        artVote.KB_Article__c = kId;
         try{
            	insert artVote;   
            } catch(Exception e)
            {
                System.debug('Error while child data creation');
            }
        
    }

}