public class customLookUpController {
    @AuraEnabled
    public static Map<String,List<String>> fetchPicklistValues(String ObjectName,List<String> fieldNames)
    {
        System.debug('@@@'+ObjectName+fieldNames);
        Map<String,List<String>> picklistMap = new Map<String,List<String>>();
        Schema.SObjectType s = Schema.getGlobalDescribe().get(objectName) ;
        Schema.DescribeSObjectResult r = s.getDescribe() ;
        Map<String,Schema.SObjectField> fields = r.fields.getMap() ;
        for(String str:fieldNames){
            List<String> listValues = new List<String>();
            Schema.DescribeFieldResult fieldResult = fields.get(str).getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            for( Schema.PicklistEntry pickListVal : ple){
                listValues.add(pickListVal.getValue());
                //System.debug(pickListVal.getLabel() +' '+pickListVal.getValue());
            }
            picklistMap.put(str,listValues);
        }
        System.debug('@@@picklistMap'+picklistMap);
        return picklistMap;
    }
    @AuraEnabled
    public static List < sObject > fetchLookUpValues(String searchKeyWord, String ObjectName) {
        system.debug('ObjectName-->' + ObjectName);
        String searchKey = searchKeyWord + '%';
        
        List < sObject > returnList = new List < sObject > ();
      
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5   
        String sQuery =  'select id, Name from ' +ObjectName + ' where Name LIKE: searchKey order by createdDate DESC limit 5';
        List < sObject > lstOfRecords = Database.query(sQuery);
        
        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        return returnList;
    }
    @AuraEnabled
    public static void insertData(Position__c posit){
        System.debug('@@@'+posit);
        insert posit;
    }
        @AuraEnabled
    public static void insertRecords(List<Position__c> posit){
        System.debug('@@@'+posit);
        insert posit;
    }
}