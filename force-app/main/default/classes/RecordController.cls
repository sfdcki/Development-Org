public with sharing class RecordController {
    @AuraEnabled(cacheable=true)
    public static list<contact> getRelatedContacts(Id accountId){
        try {
            return [
            SELECT Name, Title, Email, Phone
            FROM Contact
            WHERE AccountId = :accountId];
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    } 
}