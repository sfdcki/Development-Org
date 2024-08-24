public class LeadHandler
{
    public static void ProspectInsert(list<lead> le)
    {
        list<prospect__c> Pro = new list<prospect__c>();
        if(!le.isEmpty())
        {
            for(Lead L:le)
            {
                prospect__c p=new prospect__c();
                p.AnnualRevenue__c = L.AnnualRevenue;
                p.Email__c = L.Email;
                p.LeadRecordId__c = L.Id;
                p.ProspectSource__c = L.LeadSource;
                p.Name = L.lastname;
                Pro.add(p);
            }
            if(!Pro.isEmpty())
            {
            Database.SaveResult[] IsrtRslt = Database.insert(Pro);
            }
           
        }
    }
        public static void ProspectUpdate(map<id,lead> Ulead)
        {
            list<Prospect__C> ProUpdate = new list<Prospect__c>();
            list<Prospect__c> PUpd = [select name,AnnualRevenue__c,Email__c,LeadRecordId__c,
                                      ProspectSource__c from prospect__C where LeadRecordId__c in: Ulead.keySet()];
            if(!PUpd.isEmpty())
            {
             for(Prospect__c p:PUpd)
            {
                lead TmpLead = Ulead.get(p.LeadRecordId__c);
                P.Name = TmpLead.lastname;
                p.Email__c = TmpLead.Email;
                p.ProspectSource__c = TmpLead.LeadSource;
                ProUpdate.add(p);
            }
                
            }
            update PUpd;
        }
}