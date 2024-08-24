public class AccountContactFeedItem
{
    public static void FeedUpdate(list<FeedItem> FTmp)
    {
        
        map<id,FeedItem> FMap = new map<id,FeedItem>();
        map<id,Account>  MAct = new map<id,Account>();
        map<id,Contact>  MCon = new map<id,Contact>();
        list<FeedItem> Ftm = new list<FeedItem>();
        for(FeedItem Fi: FTmp)
        {
            FMap.put(Fi.ParentId, Fi);
        }
        
        list<Account> Fct = [select id, name from Account where id in: FMap.keySet()]; 
        list<Contact> Con = [select id,AccountId from contact where id in: FMap.keySet()];
            
        if(!Fct.isEmpty())
        {
            for(Account Ac:Fct)
            {
                MAct.put(Ac.id,Ac);
            }
            
            Con = [select id,AccountId from contact where Accountid in: MAct.keySet()];
            for(Id Tid:MAct.keySet())
            {
                for(Contact C:Con)
                {
                    if(Tid == C.AccountId)
                    {
                        FeedItem Tfitem = FMap.get(Tid);
                        if(Tfitem != null)
                        {
                        	FeedItem FeedTmp = new FeedItem();
                            FeedTmp.Body = Tfitem.Body;
                        	FeedTmp.ParentId = C.id;
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
       else if(!Con.isEmpty())
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
                        	FeedItem FeedTmp = new FeedItem();
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