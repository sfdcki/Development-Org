public class insertController {
    public String fname {set;get;}
    public Blob contentFile {set;get;}
    public String contentString {set;get;}
    public Pagereference ReadFile()
    {
		
        Pagereference ref = new Pagereference('/apex/UploadedDataPage');
        ref.setRedirect(true);
        return ref;
    }
    public void blobstring()
    {
        contentString = contentFile.toString();
    }
    public void addErrror(Candidate__c[] can1)
    {
        
        
       	can1[0].addError('Error Record');
    }
    public void updRec(Candidate__c[] can)
    {
        
        can[0].Age__c = 35;
    }
}