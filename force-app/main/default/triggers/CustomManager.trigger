trigger CustomManager on Candidate__c (before insert,before update) 
{
    if(Trigger.isBefore&&(Trigger.isinsert||Trigger.isupdate))
    {
        for(Candidate__c Con:Trigger.New)
        {
            Con.Manager__c = RegionManager__c.getInstance(Con.Region__c).ManagerName__c; 
        }
    }

}