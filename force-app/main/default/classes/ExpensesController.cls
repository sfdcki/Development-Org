public with sharing class ExpensesController {

    @AuraEnabled
    public static List<Expense__c> getExpenses() {
        // Perform isAccessible() checking first, then
        return [SELECT Id, Name, Amount__c, Client__c, Expense_Date__c, 
                       Reimbursed__c, CreatedDate 
                FROM Expense__c];
    }
    
    @AuraEnabled
public static List<Expense__c> getExpenses1() {
    
    // Check to make sure all fields are accessible to this user
    String[] fieldsToCheck = new String[] {
        'Id', 'Name', 'Amount__c', 'Client__c', 'Date__c', 'Expense_Date__c', 
        'Reimbursed__c', 'CreatedDate'
    };
    
    Map<String,Schema.SObjectField> fieldDescribeTokens = 
        Schema.SObjectType.Expense__c.fields.getMap();
    
    for(String field : fieldsToCheck) {
        if( ! fieldDescribeTokens.get(field).getDescribe().isAccessible()) {
            throw new System.NoAccessException();
            return null;
        }
    }
    
    // OK, they're cool, let 'em through
    return [SELECT Id, Name, Amount__c, Client__c, 
                   Reimbursed__c, CreatedDate 
            FROM Expense__c];
}
    
    @AuraEnabled
    public static Expense__c saveExpense(Expense__c expense) {
        // Perform isUpdatable() checking first, then
        upsert expense;
        return expense;
    }
}