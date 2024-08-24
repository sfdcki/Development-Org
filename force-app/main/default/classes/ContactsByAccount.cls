public class ContactsByAccount 
{
    public Transient list<Account> RetAcc;
    public list<selectoption> Accselect {get;set;}
    public list<contact> Con {get;set;}
    public string AccId {get;set;}
    
    public void Show()
    {
        RetAcc = [select id,name from Account];
        Accselect = new list<selectoption>();
        for(Account Ac:RetAcc)
        {
            Accselect.add(new selectoption(Ac.id,Ac.name));
        }
    }
    
    public void ContactAcc()
    {
        Con = new list<Contact>();
        Con = [select id, name, email,Phone from contact where AccountId =: AccId];
    }
}