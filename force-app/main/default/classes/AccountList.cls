public class AccountList 
{
    public list<SelectOption> LstOption {get;set;}
    public string selectedAccountID {get;set;}
    
    public AccountList()
    {
        list<Account> Acc = [select id,name from Account];
        LstOption = new list<SelectOption>();
        if(!Acc.isempty())
        {
            for(Account Ac:Acc)
            {
                LstOption.Add(New SelectOption(Ac.id,Ac.name));
            }
        }
    }
}