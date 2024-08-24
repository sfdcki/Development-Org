public class LeadCreateConfirmation {
    public static void LeadCreateAlert(Id LeadId)
    {
        messaging.SingleEmailMessage SMail = New messaging.SingleEmailMessage();
        lead ld = [select id,email,firstname from lead where id=:LeadId];
        if(ld != null)
        {
        string[] ToAdd = new string[]{'rakeshpidathala@gmail.com',ld.Email};
        string[] CCAdd = new string[]{'atmakuri.vvsudaykiran@gmail.com','uday_kiran_87@yahoo.com'};
        string PlainEContent = 'Thanks for your interest!. Your lead record is created, One of our sales team member will contact you shortly. Your lead id is'+LeadId;
        SMail.setReplyTo('uday_kiran_87@yahoo.com');
        SMail.settoaddresses(ToAdd);
        SMail.setccAddresses(CCAdd);
        SMail.setSenderDisplayName('AW Computing Company');
        SMail.setSubject('Hello Lead!'+ld.FirstName+'Lead Record Create - Alert');
        SMail.setplaintextbody(PlainEContent);
            
            messaging.sendEmail(new messaging.SingleEmailMessage[]{SMail});    
        }
    }

}