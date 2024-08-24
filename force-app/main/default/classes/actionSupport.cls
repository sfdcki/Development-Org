public class actionSupport 
{
    public list<account> lstAccounts {get;set;}
    public void supportAccounts()
    {
         lstAccounts = new list<Account>();
         lstAccounts = [select id,name,industry from Account];
    }                
}