public class listCustomSettings {
    
    public void regionManger()
    {
        list<RegionManager__c> RM = RegionManager__c.getAll().Values();
        string manager = RM[0].ManagerName__c;
        string region = RM[0].Name;
        system.debug(region +'  '+manager);
    
    }

}