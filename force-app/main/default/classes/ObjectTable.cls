public class ObjectTable 
{
    public list<Account> AccList {get;set;}
    
    public void Show()
    {
    
        AccList = [select id,name,AnnualRevenue,AccountNumber from Account where rating = 'Hot'];
    }
}