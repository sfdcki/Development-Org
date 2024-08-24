public class SampleTest
{
   public list<Account> Acct;
   public list<Contact> Cont;
   public list<Lead> Lea;
   public list<CustomWrapperClass> CWrapper{get;set;}
   
   
   public void deleteAll()
   {
       list<Id> idList = new list<Id>();
       for(CustomWrapperClass Co:CWrapper)
       {
           if(Co.IsSelected == true)
           {
               idList.add(Co.RecordId);
           }
       }
       if(!idList.isempty())
       {
           Database.delete(idList);
           getAllRecords();
       }
   }
   public void selectAll()
   {
       if(!CWrapper.isempty())
       {
           for(CustomWrapperClass Cust:CWrapper)
           {
               Cust.IsSelected = true;
           }
       }
   }
   
   public void getAllRecords()
   {
        Acct = [select id,name,phone,fax from Account limit 20];
        Cont = [select id,firstname, lastname,phone,email,fax from contact limit 20];
        Lea = [select id,firstname,lastname,phone,email,fax from Lead limit 20];
        CWrapper = new list<CustomWrapperClass>();
        
        if(!Acct.isempty())
        {
            for(Account A:Acct)
            {
                CWrapper.add(new CustomWrapperClass(A,false));
            }
        }
        
        if(!Cont.isempty())
        {
            for(Contact C:Cont)
            {
                CWrapper.add(new CustomWrapperClass(C,false));
            }
        }
        if(!Lea.isempty())
        {
            for(Lead L:Lea)
            {
                CWrapper.add(new CustomWrapperClass(L,false));
            }
        }
        }
}