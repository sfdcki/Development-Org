public class QuickContactController {
	@auraEnabled
    public static Account getAccount(id accId)
    {
     	Account acc = [select id, name from Account where id=:accId];
        return acc;
    }
    
    @auraEnabled
    public static Contact saveContactWithAccount(Contact cont,Id accId)
    {
        cont.AccountId = accId;
        insert cont;
        return cont;
    }
}