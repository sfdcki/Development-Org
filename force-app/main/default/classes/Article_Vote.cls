public class Article_Vote {
    
      @AuraEnabled
    public static Id createArticle(String type, String artId) { 
        Id ProId =  Id.valueOf(artId);
        Id Prod = [Select KnowledgeArticleId from KnowledgeArticleVersion WHERE PublishStatus = 'Online' AND Language = 'en_US' AND Id =: ProId].KnowledgeArticleId;
       	//string Prostrid =  Prod.substring(0, 15);
        //Id kartId = Id.valueOf(Prostrid);
         Vote a = new Vote();
        a.parentId = Prod;

        a.Type = type;
        
        insert a;
        return a.Id; 
        //return Prostrid;  
    }

}