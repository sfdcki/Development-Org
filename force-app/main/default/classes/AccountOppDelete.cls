public class AccountOppDelete {

    public static void OpportunityMiss(Map<Id,Account> Acc)
    {
        list<Opportunity> OppoAcc = [select id,AccountId from Opportunity where AccountId in: Acc.keySet()];
        for(Opportunity Opp: OppoAcc)
        {
            Opp.AccountId = null;
        }
        Update OppoAcc;
    }
}