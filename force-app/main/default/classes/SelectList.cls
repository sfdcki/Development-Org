public class SelectList
{
    Public List<SelectOption> lstOptions{get;set;}
    
    // Populate the Picklist Elements by using Method upon loading the Page...
    
    Public PageReference GetPicklistElements()
    {
        lstOptions.Add(new SelectOption(' ','---None---'));
        lstOptions.Add(new SelectOption('India','India'));
        lstOptions.Add(new SelectOption('USA','USA'));
        lstOptions.Add(new SelectOption('UK','UK'));
        lstOptions.Add(new SelectOption('Japan','Japan'));
        lstOptions.Add(new SelectOption('China','China'));
        
        return null;
    }
}