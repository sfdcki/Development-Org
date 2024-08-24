public class AccountContactInsert{
 	public void Values()
    {
        Account Acc = new Account();
        Acc.Name = 'K Kamal';
        Acc.Rating = 'Hot';
        Acc.Site = 'www.raj.com';
        Acc.Type = 'Prospect';
        Acc.AnnualRevenue = 123455667;
        Acc.SSN_Number__c = 434343434;
        Acc.PAN_Number__c = 'askpa5339g';
        Acc.STATES_BOX__c = true;
        Acc.Account_Status__c = 'Warning';
        Acc.Phone = '9700827312';
        Acc.Website = 'www.kamalkumari.com';
        Acc.NumberOfEmployees = 9;
        Acc.NumberofLocations__c = 8;
        Acc.BillingCity = 'Hyderabad';
        Acc.BillingCountry = 'India';
        Acc.BillingPostalCode = '522616';
        Acc.BillingState = 'Telangana';
        Insert Acc;     
       
        
        
        Contact Con = new Contact();
        Con.Department = 'Retail';
        Con.Email = 'Kumari1@yahoo.com';
        Con.AssistantPhone = '9700827312';
        Con.AssistantName = 'Kumar Raja';
        Con.FirstName = 'Kamal';
        Con.LastName = 'Kumari';
       	Con.AccountId = Acc.Id;
        Insert Con;
        
        Case Cs = new Case();
        Cs.AccountId = Acc.Id;
        Cs.Description = 'Account dhobbindi ra babu!';
        Cs.Product__c = 'GC 1040';
        Cs.Type = 'Electronic';
        Cs.Reason = 'Performance';
        Cs.Status = 'New';
        Cs.Origin = 'Web';
        Insert Cs;
        
        If(Con != null)
        {            
        
            System.Debug('Case record created successfully' + Cs.Id);
            System.Debug('Contact record created successfully' + Con.Id);
            System.debug('Account record created successfully'+Acc.Id);
        }
    }
}