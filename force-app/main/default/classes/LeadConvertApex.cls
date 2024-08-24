public class LeadConvertApex 
{
    public static void ApexLeadConvert(list<lead> le)
    {
        list<Database.LeadConvert> CLead = new list<Database.leadconvert>();
        LeadStatus LStatus = [select id,masterlabel,isconverted from LeadStatus where isconverted =  true LIMIT 1];
        for(Lead L:le)
        {
            if(L.Status == 'Closed - Converted' && L.IsConverted == false)
            {
         	Database.LeadConvert LC = new Database.LeadConvert();
            LC.SetLeadId(L.id);
            LC.setConvertedStatus(LStatus.MasterLabel);
            LC.setsendnotificationEmail(false);
            LC.setDoNotCreateOpportunity(true);
            CLead.add(LC);
            }
        }
        try
        {
        	Database.LeadConvertResult[] CResult = Database.ConvertLead(CLead);    
        }
          Catch(DMLException DEx)
        {
            system.debug('error message is '+ DEx.getMessage());
        }
        Catch(Exception Ex)
        {
            system.debug('error message is'+ Ex.getMessage());
        }       
    }

}