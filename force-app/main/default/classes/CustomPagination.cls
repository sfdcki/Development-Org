public class CustomPagination {
   
    
    //List to store all the contacts according to requirement
    public List<Candidate__c> AllContacts = new list<Candidate__c>();
    
    //List to show the limited records on the page
    public List<Candidate__c> ContactsToShow{get;set;}
    
    //Navigation variables
    Integer counter = 0;//TO track the number of records parsed
    Integer limitSize = 3;//Number of records to be displayed
    Integer totalSize =0; //To Store the total number of records available
    
    //Constructor
    public CustomPagination(){
        
         ContactsToShow = new list<Candidate__C>();
        
        //Get all the contacts which are from Public realations lead source
        AllContacts = [select id , name, Manager__c from Candidate__c];
        //Store the total size
        totalSize = AllContacts.size();
        
        //Intial adding of contacts to ContactsToShow
        //check the total records are more than limitSize and assign the records
        if((counter+limitSize) <= totalSize){
            for(Integer i=0;i<limitSize;i++){
                ContactsToShow.add(AllContacts.get(i));
            }
        }else{
            for(Integer i=0;i<totalSize;i++){
                ContactsToShow.add(AllContacts.get(i));
            }
        }
        
    }
    
    //Navigation methods
    
    
	public void beginning(){
   
        ContactsToShow.clear();
        counter=0;
        if((counter + limitSize) <= totalSize){
       
            for(Integer i=0;i<limitSize;i++){
                ContactsToShow.add(AllContacts.get(i));
            }   
           
        } else{
       
            for(Integer i=0;i<totalSize;i++){
                ContactsToShow.add(AllContacts.get(i));
            }       
           
        }
       
    }
   
    public void next(){
   
        ContactsToShow.clear();
        counter=counter+limitSize;
       
        if((counter+limitSize) <= totalSize){
            for(Integer i=counter-1;i<(counter+limitSize);i++){
                ContactsToShow.add(AllContacts.get(i));
            }
        } else{
            for(Integer i=counter;i<totalSize;i++){
                ContactsToShow.add(AllContacts.get(i));
            }
        }
    }
   
    public void previous(){
   
        ContactsToShow.clear();

        counter=counter-limitSize;       
       
        for(Integer i=counter;i<(counter+limitSize); i++){
            ContactsToShow.add(AllContacts.get(i));
        }
    }

    public void last (){
   
        ContactsToShow.clear();
       
        if(math.mod(totalSize , limitSize) == 0){
            counter = limitSize * ((totalSize/limitSize)-1);
        } else if (math.mod(totalSize , limitSize) != 0){
            counter = limitSize * ((totalSize/limitSize));
        }
       
        for(Integer i=counter-1;i<totalSize-1;i++){
                ContactsToShow.add(AllContacts.get(i));
        }
       
    }
   
    public Boolean getDisableNext(){
   
        if((counter + limitSize) >= totalSize )
            return true ;
        else
            return false ;
    }
   
    public Boolean getDisablePrevious(){
   
        if(counter == 0)
            return true ;
        else
            return false ;
    } 
}