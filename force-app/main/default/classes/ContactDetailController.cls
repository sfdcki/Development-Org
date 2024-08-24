public class ContactDetailController {

    public string accountid {get;set;}
    public Account accid {get;set;}

    public ContactDetailController(ApexPages.StandardController controller)
    {    
        accountid = controller.getid();
        if(accountid != null)
        {
            accid = [select id from Account where Id=: accountid];
        }
    }

}