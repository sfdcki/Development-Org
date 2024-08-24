public class K12_C_Product_Support {
    
    
    @AuraEnabled
    public static list<Product__c> getProduct()
    {
        list<Product__c> Prod = [Select Name, Product_Name__c from Product__c order by Product_Name__c asc];
        return Prod;
    }
    
    @AuraEnabled
    public static list<Role__c> getRole()
    {
        list<Role__c> Role = [Select Name, Role_Name__c from Role__c order by Role_Name__c asc];
        return Role;
    }
	 @AuraEnabled
    public static list<AreaofIssue__c> getIssue()
    {
        list<AreaofIssue__c> AoIssue = [Select Name, Issue__c from AreaofIssue__c order by Issue__c asc];
        return AoIssue;
    }
    
    @AuraEnabled
    public static Id saveTheFile(Id parentId, String fileName, String base64Data, String contentType) { 
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        Attachment a = new Attachment();
        a.parentId = parentId;

        a.Body = EncodingUtil.base64Decode(base64Data);
        a.Name = fileName;
        a.ContentType = contentType;
        
        insert a;
        
        return a.Id;
    }
    
    @AuraEnabled
    public static Id saveTheChunk(Id parentId, String fileName, String base64Data, String contentType, String fileId) { 
        if (fileId == '') {
            fileId = saveTheFile(parentId, fileName, base64Data, contentType);
        } else {
            appendToFile(fileId, base64Data);
        }
        
        return Id.valueOf(fileId);
    }
    
    private static void appendToFile(Id fileId, String base64Data) {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        Attachment a = [
            SELECT Id, Body
            FROM Attachment
            WHERE Id = :fileId
        ];
        
     	String existingBody = EncodingUtil.base64Encode(a.Body);
        a.Body = EncodingUtil.base64Decode(existingBody + base64Data); 
        
        update a;
    }
        
     @AuraEnabled
    public static Id dataCase(string email, String subject, String description) { 
        case tcase = new case();
        tcase.Email__c = email;
        tcase.Status = 'New';
        tcase.Origin = 'Web';
        tcase.Subject = subject;
        tcase.Description = description;
        
        //Fetching the assignment rules on case
        AssignmentRule AR = new AssignmentRule();
        AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];
        
        //Creating the DMLOptions for "Assign using active assignment rules" checkbox
        Database.DMLOptions dmlOpts = new Database.DMLOptions();
        dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
                
        //Setting the DMLOption on Case instance
        tcase.setOptions(dmlOpts);
        insert tcase;
        return tcase.Id;
    }

}