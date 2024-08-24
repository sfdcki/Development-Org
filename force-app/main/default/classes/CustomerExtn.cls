public class CustomerExtn {

    public CustomerExtn(CustomerExtension controller) {

    }
    public Customer__c tCust;
    public id cust_id {set;get;}
    public PageReference isrtCustomer()
    {
        tCust = new Customer__c();
        tCust.Name = ApexPages.currentPage().getParameters().get('name');
        tCust.Comm_Date__c = Date.valueOf(ApexPages.currentPage().getParameters().get('date'));
        tCust.E_Mail__c =  ApexPages.currentPage().getParameters().get('emal');
        tCust.Customer_Age__c = Integer.valueOf(ApexPages.currentPage().getParameters().get('cage'));
        tCust.Customer_Address__c = ApexPages.currentPage().getParameters().get('adds');
        tCust.Customer_Investment__c = decimal.valueOf(ApexPages.currentPage().getParameters().get('invt'));
        insert tCust;
        cust_id = tCust.Id;
        return null;
    }
}