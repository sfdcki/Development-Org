global class AccountRemoter {

 
    public String accountName { get; set; }
    public static Account account { get; set; }
    public AccountRemoter() { } // empty constructor
     
    @RemoteAction
    global static Account getAccount(String accountName) {
        accountName += '%';
        account = [SELECT Id, Name, Phone, Type, NumberOfEmployees
                   FROM Account WHERE Name like :accountName];
        return account;
    }
}