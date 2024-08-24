trigger ACFeedItem on FeedItem (after insert) 
{
    if(Trigger.isinsert && Trigger.isafter)
    {
        if(CheckRecusive.runOnce())
        {
        	AccountContactFeedItem.FeedUpdate(Trigger.new);
        }
    }

}