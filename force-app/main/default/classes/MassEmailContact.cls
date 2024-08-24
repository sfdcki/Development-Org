public class MassEmailContact
{
    public static void MEmail()
    {
        messaging.MassEmailMessage MEmail = new messaging.MassEmailMessage();
        list<id> Cid = new list<id>();
        map<id,contact> MContacts = new map<id,contact>([select id, name,email from contact where 
                                                       accountid = null and email!=null]);
        for(id n:MContacts.keySet())
        {
         	 Cid.add(n);
        }
        
    	EmailTemplate ETemp = [select id, name from EmailTemplate where name= 'Contact Create Notification Alert'];
        MEmail.settemplateid(ETemp.id);
       	MEmail.settargetobjectids(Cid);
        messaging.sendEmail(new messaging.MassEmailMessage[]{MEmail});
        
    }

}