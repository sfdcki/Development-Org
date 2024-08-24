global class CreateContactEmailHandler implements Messaging.InboundEmailHandler
{
global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email,Messaging.InboundEnvelope envelope)
    {
        Messaging.InboundEmailResult emailResult=new Messaging.InboundEmailResult();
        Contact objContact = new Contact();
        try
        {
           objContact = [select id, email,Email_subject__c, Email_Content__c from Contact 
			where email =: email.fromAddress limit 1];
        }
        catch(Exception ex)
        {
           System.debug('Exception Occured while fetching Contact Data...:'+ex.getMessage());
        }
        if(objContact !=null)
        {
            objContact.Email_Subject__c = email.subject;
            objContact.Email_Content__c = email.plainTextBody;
        }
        else
        {
            objContact.lastname = email.fromName;
            objContact.email = email.fromAddress;
            objContact.Email_subject__c = email.subject;
            objContact.Email_Content__c = email.plainTextBody;
        }
        upsert objContact;
        // Add Contact Attachements...
        List<Attachment> lstAttachments = new List<Attachment>();
        if(email.textAttachments !=null)
        {
            for(Messaging.InboundEmail.TextAttachment textAttachment:email.textAttachments )
            {
                Attachment objAttachment=new Attachment();
                objAttachment.Name = textAttachment.fileName;
                objAttachment.Body = Blob.valueof(textAttachment.Body);
                objAttachment.ParentId = objContact.Id;
                lstAttachments.Add(objAttachment);
            }                     
        }
        if(email.binaryAttachments !=null)
        {
            for(Messaging.InboundEmail.BinaryAttachment binaryAttachment:email.binaryAttachments )
            {
                Attachment objAttachment=new Attachment();
                objAttachment.Name = binaryAttachment.fileName;
                objAttachment.Body = binaryAttachment.Body;
                objAttachment.ParentId = objContact.Id;
                lstAttachments.Add(objAttachment);
            }                     
        }
        if(lstAttachments.size() > 0)
            insert lstAttachments;
	       
        emailResult.success = true;
	        return emailResult;
    }
}