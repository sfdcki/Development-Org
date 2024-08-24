public with sharing class AccountContactController {
    public AccountContactController() {

    }
    @AuraEnabled
    public static List<Account> getAccounts(){
        try {
            return [select name,annualrevenue,industry from Account ORDER BY Name];
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}