public class CustomWrapperClass
{
    public string RecordId{get;set;}
    public string Name{get;set;}
    public string Email{get;set;}
    public string phone{get;set;}
    public string faxNumber{get;set;}
    public boolean IsSelected{get;set;}
    
    public CustomWrapperClass(Account Acc, Boolean Selected)
    {
        Name = Acc.Name;
        RecordId = Acc.id;
        Email = ' ';
        phone = Acc.Phone;
        faxNumber = Acc.Fax;
        IsSelected = Selected;
        
    }
    
    public CustomWrapperClass(Contact Conc, Boolean Selected)
    {
        Name = Conc.FirstName+''+Conc.lastname;
        RecordId = Conc.id;
        Email = Conc.Email;
        phone = Conc.Phone;
        faxNumber = Conc.Fax;
        IsSelected = Selected;
    }

    public CustomWrapperClass(Lead L, Boolean Selected)
    {
        Name = L.FirstName+''+L.lastname;
        RecordId = L.id;
        Email = L.Email;
        phone = L.Phone;
        faxNumber = L.Fax;
        IsSelected = Selected;
    }
    
}