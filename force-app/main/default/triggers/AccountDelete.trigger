trigger AccountDelete on Account (before delete) {
    if(Trigger.isdelete && Trigger.isbefore)
    {
        AccountOppDelete.OpportunityMiss(Trigger.oldmap);
    }

}