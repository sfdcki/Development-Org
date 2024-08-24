public class faction {

      public id cust_id {set;get;}
   public string name ;
    public string address;
     // public string iname {set;get;}
    public PageReference nameas()
    {
        name = ApexPages.currentPage().getParameters().get('name');
        address = ApexPages.currentPage().getParameters().get('add');
        Customer__c cust=  new Customer__c();
        cust.Name = name;
        cust.Customer_Address__c = address;
        insert cust;
        cust_id = cust.Id;
        return null;
    }
}