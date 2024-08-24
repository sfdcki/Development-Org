public class TargetPageController 
{
    public string myCustomerId {get;set;}
    Public string myCustomerName {get;set;}
    
    Public TargetPageController()
    {
        /*
            Map<string,string> paramMap = ApexPages.CurrentPage().GetParameters();
            myCustomerId = paramMap.get('custId);
        */
        
        myCustomerId  = ApexPages.CurrentPage().GetParameters().get('custId');
        myCustomerName = ApexPages.CurrentPage().GetParameters().get('custName');
    } 
    
    Public PageReference GotoSourcePage()
    {
        PageReference pgRef = Page.SourcePage;
        return pgRef.SetRedirect(true);
        
    }
}