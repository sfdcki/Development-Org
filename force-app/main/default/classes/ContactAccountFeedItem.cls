public class ContactAccountFeedItem
{
    public static void AccountFeed(list<FeedItem> FTmp)
    {
 
        FeedItem FeedTmp = new FeedItem();
        map<id,FeedItem> FMap = new map<id,FeedItem>();
        map<id,Contact>  MCon = new map<id,Contact>();
        list<FeedItem> Ftm = new list<FeedItem>();
        for(FeedItem Fi: FTmp)
        {
            FMap.put(Fi.ParentId, Fi);
        }
        
        list<Contact> Con = [select id,AccountId from contact where id in: FMap.keySet()];
            
      if(!Con.isEmpty())
        {
            for(Contact Co:Con)
            {
                MCon.put(Co.AccountId,Co);
            }
            
            list<Account> Acct = [select id,name from Account where id in: MCon.keySet()];
            for(Account Acc:Acct)
            {
                for(Id Tid:MCon.Keyset())
                {
                    if(Acc.id == MCon.get(Acc.id).AccountId)
                    {
						FeedItem Tfitem = FMap.get(MCon.get(Acc.id).Id);
                        if(Tfitem != null)
                        {
                        	FeedTmp.Body = Tfitem.Body;
                        	FeedTmp.ParentId = Acc.id;
                        	FeedTmp.IsRichText = Tfitem.IsRichText;
                        	Ftm.add(FeedTmp);
                        }
                    }
                }
            }      
              if(!Ftm.isEmpty())
        		{
        			insert Ftm;
        		}
    }
}
}