public with sharing class CampingListController {

    @AuraEnabled
    public static list<Camping_Item__c> getItems()
    {
        return [select Name, Packed__c, Price__c, Quantity__c from Camping_Item__c];
    }
    @AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c cItem)
    {
        upsert cItem;
        return cItem;
    }
}