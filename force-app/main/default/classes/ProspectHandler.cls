public class ProspectHandler 
{
    public static void LeadUpdate(map<id,Prospect__c> NewMap)
    {
        map<id,Prospect__c> mapNewProspect = new map<id,Prospect__c>(); 
        for(Prospect__c Pro:NewMap.values())
        {
            mapNewProspect.put(Pro.leadrecordid__c,Pro);
        }
        list<lead> LeadToUpdate = [select id,lastname,email,leadsource from lead where id in:mapNewProspect.keySet()];
        if(!LeadToUpdate.isEmpty())
        {
            for(Lead le:LeadToUpdate)
            {
                prospect__C p = mapNewProspect.get(le.id);
                le.Email = p.Email__c;
                le.LeadSource = p.ProspectSource__c;
            }
            update LeadToUpdate;
        }
    }

}