public class inlineEditController {


    
    public List<Position__c> posList {get;set;}
    public String message{get;set;}
 
   public PageReference getPositions()
    {
        
        posList = [select Name,Closing_Date__c,Description__c,Hiring_Position__c,Location__c,Manager_Printed_Name__c,Number_of_Candidates__c from Position__c];
       return null;
    }
   /**
    *@purpose : Method for Saving the Customer Object Record 
    *@param : None 
    *@return : PageReference to Standard Salesforce Record Detail Page 
    **/
   public PageReference savingCustomerRecord(){
      try{
         upsert posList;
         //PageReference nextpage= new PageReference('/'+customerObj.id);
           return null;
      }
      catch(Exception e){
            message='Data Base error during saving...';
            ApexPages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR, message));
            return null;
        }
   }
}