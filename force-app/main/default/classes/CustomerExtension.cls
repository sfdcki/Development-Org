Global class CustomerExtension {

    public string username {set;get;}
    public CustomerExtension() {
            username = UserInfo.getUserName();        
    }

    
    public string custName;
    public string Custrole;
    public static list<Customer__c> custlist;
  
    @RemoteAction
    global static List<Customer__c> getCust(string custName,string Custrole)
    {
        custName = '%'+CustName+'%';
        custlist = [select Name,Comm_Date__c,Customer_Address__c,Customer_Age__c,Customer_Investment__c,number__c,E_Mail__c from customer__c where Name like :custName];
        return custlist;
    }

}