public class AccountsController 
{          
    public ApexPages.StandardSetController setCon 
    {
        get {
            if(setCon == null) {
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                      [select id, name,Rating, type, industry, annualrevenue, active__c from account]));
            }
            return setCon;
        }
        set;
    }

    // Initialize setCon and return a list of records
   
    public List<Account> getAccountRecords() {
         setCon.setpagesize(10);
         return (List<Account>) setCon.getRecords();
    }
   

}