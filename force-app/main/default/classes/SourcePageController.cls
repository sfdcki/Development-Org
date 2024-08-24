public class SourcePageController 
{
    Public string customerId {get;set;}
    Public string customerName {get;set;}
    Account account;
    Public PageReference GotoTargetPage()
    {
        //Pagereference pgRef = new PageReference('/apex/TargetPage?custId='+customerId +'&custName='+customerName);
        
        PageReference pgRef = Page.TargetPage;
        pgRef.getParameters().Put('custID',customerId);
        pgRef.getParameters().Put('custName',CustomerNAme);
        pgRef.SetRedirect(false);
        return pgRef;
    }
      Public void TargetPageController()
    {
        /*
            Map<string,string> paramMap = ApexPages.CurrentPage().GetParameters();
            myCustomerId = paramMap.get('custId);
        */
        
        customerId  = ApexPages.CurrentPage().GetParameters().get('custId');
        customerName = ApexPages.CurrentPage().GetParameters().get('custName');
    } 
    
    Public PageReference GotoSourcePage()
    {
         //PageReference pgRef= new ApexPages.StandardController(account).view();
       PageReference pgRef = Page.SourcePage;
        pgRef.SetRedirect(false);
        return pgRef;
        
    }
}