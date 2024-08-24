public class ProspectExtension {

    public Prospect__C Pro;
    public ProspectExtension(ApexPages.StandardController controller) 
    {
        Pro = (Prospect__c)controller.getRecord();
    }
}