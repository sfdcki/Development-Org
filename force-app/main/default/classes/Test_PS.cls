public class Test_PS {
     /*public without sharing class PS_CSS_ContactSupport {  
    
    //Variable declaration for RD# 1472 starts
    public String selectedState { get; set; }
    public String selectedCountry{get;set;}
    public String selectedCategory{get;set;}
    public static String Subject{get;set;}
    public String selectedProduct{get;set;}
    public String selectedRole{get;set;}
    public String selectedLanguage{get;set;}
    public String selectedSchool { get; set; }
    public String selectedDistrict { get; set; }
    public String selectedProgram { get; set; }
    public String Fname{get;set;}
    public String Lname{get;set;}
    public String uemail{get;set;}
    public String uphone{get;set;}
    public string sOrganization{get;set;}
    public String sRecType{get;set;}   
    public String sRecTypeId{get;set;}  
    public String sAccountName{get;set;} 
    public User userEmail = getCurrentUser();
    public Contact conT = new Contact();
    public Boolean isAuthUser;
    //Variable declaration for RD# 1472 ends    
    
    //Method to Identify Autheticated User
    public boolean getisAuthUser(){
        if(UserInfo.getUserType() !='Guest')
        {
            return true; 
        }
        else{return false;}
    }
     
     @AuraEnabled
     public static boolean checkIfRegisteredUser(){
        if(UserInfo.getUserType() !='Guest')
        {
            return true; 
        }
        else{
            return false;
        }
    }

  
    //Method to search for Knowledge articles and topics based on the inputs from the end user - Contact Support Page in community
    @AuraEnabled
    public static List<KnowledgeArticleVersion> getValues(String searchTitle, string country, string role, string product, string category) 
    {        
        String searchInputText = '%'+ searchTitle + '%';
    
        String online = System.label.PS_KAV_Online; 
        String strLanguage =  System.label.PS_KAV_Language;
        try{
            
            //====Changes as per Dennis Mail=== Start===
           
            String query = 'Find \'*'+ searchTitle + '*\' IN ALL FIELDS RETURNING KnowledgeArticleVersion ( id,title, urlName , Summary , ArticleType where publishStatus=: online and language=: strLanguage) WITH DATA CATEGORY Geography__c ABOVE_OR_BELOW '+country+' AND Role__c ABOVE_OR_BELOW '+role+' ';
                        List<List<SObject>> searchList = search.query(query);
                       
                        List<KnowledgeArticleVersion> lst = searchList[0];
             //====Changes as per Dennis Mail=== End===
            Map<Id,KnowledgeArticleVersion> lstMap = new Map<Id,KnowledgeArticleVersion>(); 
            Set<Id> articleIds = new Set<Id>();
            for(TopicAssignment topicAs: [Select EntityId,TopicId,Topic.Name from TopicAssignment where topic.Name LIKE :searchInputText])
            {
                articleIds.add(topicAs.EntityId);
            }
           
            List<KnowledgeArticleVersion> newLst = [SELECT Id,Title, UrlName, Summary , ArticleType FROM KnowledgeArticleVersion WHERE PublishStatus ='Online' AND Language ='en_US' AND Id IN: articleIds];
           
            List<KnowledgeArticleVersion> result = new List<KnowledgeArticleVersion>();
            result.addAll(lst);
            result.addAll(newLst);
            Set<KnowledgeArticleVersion> myset = new Set<KnowledgeArticleVersion>();
            List<KnowledgeArticleVersion> resultID = new List<KnowledgeArticleVersion>();
            myset.addAll(lst);
            myset.addAll(newLst);       
            resultID.addAll(myset);
            //return resultID;
               List<KnowledgeArticleVersion> limitedarticle=new List<KnowledgeArticleVersion>();
            Integer i;
            
            for(i=0; i<resultID.size();i++)
            {
                if(resultID!=null)
                {
                    if(i<5)
                    {
                        limitedarticle.add(resultID[i]);
                    }
                }
            }
          
            //return resultID;
            return limitedarticle;
        }
        catch(System.Exception e)
        {
            String Message=e.getMessage();
            return null;
        }
    }
    
    //Method to fetch all the country list from the Custom setting - CS_country__c
    @AuraEnabled
    public static List<CS_country__c> getValueCtry() 
    {        
        List<CS_country__c> countryList = [Select Label__c,name from CS_country__c Order By Priority__c asc nulls last ,Label__c];
        return countryList;
    }
    //Method to fetch all the Category list from the Case Object Category field
    @AuraEnabled
    public static List<PS_CategoryGrouping__c> getpickvalCaseCat() 
    {
         List<PS_CategoryGrouping__c> categoryGrouping = [Select id , name , grouping__c from PS_CategoryGrouping__c Order By name asc ];
        return categoryGrouping;
         
    } 
    //Method to fetch all the product list from Product__c
    @AuraEnabled
    public static List<product__c> getValuePrd() {  
        return [select name,Active_in_Self_Service__c,id,Product_Group__c  from product__c where Active_in_Self_Service__c=true and type__c = 'Product' order by name];
    }
    //Method to fetch all the Role list from the Custom setting - CS_role__c
    @AuraEnabled
    public static List<CS_role__c> getValueRole() 
    {        
        List<CS_role__c> roleList = CS_role__c.getall().values();
        roleList.sort();
        return roleList;
    }
    //Method to fetch Phone from custom setting based on role and country
    @AuraEnabled
    public static String getPhoneNumber(string Country,string CountryHub ,  string Role , string ProductGroup , string Language) {
        String returnmsg = null; 
        String rolegroup = '';
        String query;
        String CountryHubLabel=System.Label.Ps_SelfService_NorthAmerica;
        List<PS_ContactRole__c> roleGroupList = new List<PS_ContactRole__c>();
        roleGroupList = [SELECT Role_Grouping__c from PS_ContactRole__c where Name =: Role LIMIT 1];
        if(!roleGroupList.IsEmpty()){
        rolegroup= roleGroupList[0].Role_Grouping__c;  
        }
        //d-4997 - adding outer if condition for Equella Product.
        if(CountryHub == '')
        {
            query = 'SELECT  Number__c , Country__c from PS_Country_PhoneMapping__c WHERE  Product_Grouping__c = ' + '\'' + ProductGroup +  '\'' ;
       
        }
        else if(CountryHub == CountryHubLabel)
        {    
             query = 'SELECT  Number__c , Country__c from PS_Country_PhoneMapping__c WHERE Country_Hub__c=' + '\'' + CountryHub + '\'' + ' and Role__c = ' + '\'' + rolegroup +  '\'' + ' and Language__c = ' + '\'' + Language +  '\'' + ' and Product_Grouping__c = ' + '\'' + ProductGroup +  '\'' ;
       
        }
        else{
              query = 'SELECT  Number__c , Country__c from PS_Country_PhoneMapping__c WHERE Country__c=' + '\'' + Country + '\'' + ' and Role__c = ' + '\'' + rolegroup +  '\'' ;
       
        }
        
        PS_Country_PhoneMapping__c[] lst = Database.query(query);
        if(lst.size() > 0 )
        {
            returnmsg =  '' + lst[0].Number__c;
        }
        return returnmsg;
    } 
    //Method to fetch current user's details
    @AuraEnabled
    public static User getCurrentUser() 
    {
        String message;
        User toReturn;
        String Profile = System.Label.Pearson_Support_Profile;
        try{
            //Defect 4942 - Making this change to avoid List has no rows exception for chat to case.
            //toReturn = [SELECT Id, Name, FirstName, MobilePhone, LastName, Email, City, Country, State , UserName FROM User WHERE Id = :UserInfo.getUserId() and Profile.Name !=: Profile LIMIT 1];
           toReturn = [SELECT Id, Name, FirstName, MobilePhone, LastName, Email, City, Country, State , UserName , Profile.Name ,Phone  FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1];
           System.debug('profile = ' + toReturn.Profile.Name );
           System.debug('support profile = ' + Profile);
            
          if( toReturn.Profile.Name != Profile)
           {     
           System.debug('profiles do not match, returning info');
            return toReturn;  
           }
            else{
            System.debug('profiles match');
             return null;
             }
        }
        Catch(System.Exception e)
        {
            message=e.getMessage();
            return null;
        }
    }
    //Method to change password of the user
    @AuraEnabled
    public static String getChangePassword(String newpassword,String oldpassword,String verifyNewPassword)
    {
        String error;
        try{
            PageReference pf= Site.changePassword(newPassword, verifyNewPassword, oldpassword);    
        }
        Catch(System.Exception e)
        {
            error=e.getMessage();
        }
        return error;
    }
    // Method to insert Contact and Case via web to case
    @AuraEnabled
    public static String getCase(String details){
        String errorMsg; 
        String Success_Message;
        try {
        List<String> detailsList = (List<String>)JSON.deserialize(details,List<String>.class);
           system.debug('inside getCase'+detailsList);

        
        Integer accFlag = 0;
        List<Id> accIdList = new List<Id>();        
        String accountName;
        if(detailsList[24] != ''){
            accountName = detailsList[24];
        }
        else 
            accountName = detailsList[30];
        String firstname=detailsList[0];
        String lastname=detailsList[1];
        String email= detailsList[2];
        String Username=detailsList[7];
        String Existingcase=detailsList[19];
        
        String Description;
        if(detailsList[35] != ''){
            Description = detailsList[35];
        }
        else
            Description = detailsList[4] + detailsList[5] + detailsList[6] + detailsList[7] + detailsList[11] + detailsList[12] + detailsList[14] + detailsList[16] + detailsList[17] +  detailsList[18] ;
        String recordType_contact = detailsList[38];
        String recordType_case = detailsList[37];
        Case Obj=new Case();
        List<Case> lst=new List<Case>();
        Contact con=new Contact(); //Need to make this contact globally avaiable so that it can be passed in the contructor
        List<Account> accountList = [Select id,Name from Account where name =: accountName];
        for(Account acc:accountList){
            accFlag++;          
            accIdList.add(acc.id);
        }
        LIST<AggregateResult> SelfServiceLicense = [select profile.UserLicense.name,User.contactID from user where Id = :UserInfo.getUserId() AND Email=:UserInfo.getUserEmail() AND Username=:UserInfo.getUserName() group by profile.UserLicense.name,User.contactID ];
        LIST<String> licenselist=new LIST<String>();
        for(AggregateResult lList : SelfServiceLicense)
        {
            licenselist.add(String.ValueOf(lList.get('Name')));
            licenselist.add(String.ValueOf(lList.get('ContactId')));
        }
        String licensenew = String.valueof(licenselist.get(0));     
        String uniquecontact = String.valueof(licenselist.get(1));
        String customLabelValue = System.Label.Community_User_License;      
        List<RecordType> RecordTypeID_contact = [Select Id FROM RecordType WHERE SobjectType = 'Contact' and DeveloperName =: recordType_contact LIMIT 1] ;
        List<RecordType> RecordTypeID_case = [Select Id FROM RecordType WHERE SobjectType = 'Case' and DeveloperName =: recordType_case LIMIT 1] ;
        String query = 'SELECT Id FROM Contact WHERE Email =' + '\'' + email + '\'' + '';
        LIST <Contact> conn = Database.query(query);
        
        //try{
                if(conn.isEmpty())
                {
                system.debug('No duplicate contact with matching email address found, bypassing API duplicate checker');
                    con.FirstName=firstname;
                    con.LastName=lastname;
                    con.Role__c=detailsList[36];
                    con.Email=email;
                    con.Phone = detailsList[20];
                    con.SelfServiceCreated__c= true;
                    con.Country_of_Origin__c = detailsList[27];
                    con.Language__c = detailsList[26];
                    RecordType RecordTypeID_contactobj=RecordTypeID_contact.get(0);
                    con.RecordTypeId=RecordTypeID_contactobj.Id;

                    //Changes as per Defect 4757- to bypass Duplicate Checker

                    Database.DMLOptions dml = new Database.DMLOptions(); 
                    dml.DuplicateRuleHeader.AllowSave = true;
                    Database.insert(con, dml);
                    //insert con;
                    
                    Obj.ContactId=con.Id;
                }
                else{
                    Contact existingcontactobj=conn.get(0);
                    Obj.ContactId=existingcontactobj.Id;
                }
                Obj.Account_Primary_Contact_Email__c = email;
                RecordType RecordTypeID_caseobj=RecordTypeID_case.get(0);
                Obj.RecordTypeId = RecordTypeID_caseobj.Id;
            	if (detailsList[44] == 'FromPhone') {
                	Obj.Origin = System.label.PS_Web_Phone;
                } else {
                    Obj.Origin = System.label.PS_Web;
                }
                Obj.Status=System.label.PS_New;
                Obj.Subject= detailsList[39];
                Obj.Description = Description;
                Obj.Customer_Username__c= Username;
                Obj.Contact_Type__c= detailsList[36];
                /*New Changes*/
      /*          Obj.Category__c  = detailsList[31];
                Obj.Existing_Case_Number__c = detailsList[19];
                Obj.PO_Number__c = detailsList[32]; //Obj.iStore_Order__c = detailsList[32]; //Changes as per Defect#4799
                Obj.Currency__c = detailsList[33];
                Obj.Refund_Reason__c = detailsList[34];
                Obj.of_Users__c = Integer.valueOf(detailsList[3]);
                Obj.Semester_Term__c =  detailsList[8];
                Obj.Course_Name__c = detailsList[9];
                Obj.ErrorMessage_CodeTest__c= detailsList[13];
                Obj.Internet_Browser__c = detailsList[15];
                Obj.Course_ID__c = detailsList[10];         
                /* End Changes*/
                        //==Start==As per Gabriel Mail on 2/11/16
   /*             Obj.Global_Country__c = detailsList[27];
                Obj.Global_Language__c = detailsList[26];
				obj.Pearson_Support__c = detailsList[45];
                //==End==As per Gabriel Mail on 2/11/16
                if(accFlag == 1){
                    Obj.Accountid = accIdList[0];
                }
                else {
                    Obj.Contact_Organization_School__c = accountName;             
                }
                if(detailsList[43] != '' && detailsList[43] != null){
                    Obj.Products__c= detailsList[43];
                }
                          
                if(licensenew == customLabelValue) {   
                    LIST<User> caseowner = [select ID from user where FederationIdentifier =:System.Label.Community_User_Case_Owner LIMIT 1];
                    if (caseowner.size() > 0) {
                    	Obj.OwnerId = caseowner[0].Id;    
                    }
                }
                
                insert Obj;
                
                Case Casenum = [select CaseNumber from Case where id =:Obj.Id Limit 1];
                
                //lst.add(Obj);
                String CaseNumber = Casenum.CaseNumber;
                String parentid = Obj.Id;
                if(detailsList[40] != '')
                {
                    String base64Data = EncodingUtil.urlDecode(detailsList[41], 'UTF-8');
                    Attachment a = new Attachment();
                    a.parentId = parentid;
                    a.Name = detailsList[40];
                    a.Body = EncodingUtil.base64Decode(base64Data);
                    a.ContentType = detailsList[42];
                    insert a;
                }
                Success_Message = CaseNumber;
            	//Success_Message=System.Label.PS_SelfService_SuccessMessage+' '+CaseNumber+'.';
                
        }
        catch(dmlexception e) {
            errorMsg = e.getMessage();
            if(errorMsg != null || errorMsg != ''){
                Success_Message = System.Label.PS_SelfService_ErrorMessage;
            }
        }
        return Success_Message;
    }
   
   
    // Method to put role,country,category,subject,product,language values to VF Page from Community
    @AuraEnabled
    public static void setInit(String role,String country,String category,String sub,String pro,String lang) {
        Cache.Session.put(UserInfo.getUserId()+'role',role);
        Cache.Session.put(UserInfo.getUserId()+'country',country);
        Cache.Session.put(UserInfo.getUserId()+'category',category);
        Cache.Session.put(UserInfo.getUserId()+'searchTitle',sub);
        Cache.Session.put(UserInfo.getUserId()+'product',pro);
        Cache.Session.put(UserInfo.getUserId()+'lang',lang);
    }
    //RD#1472 code ends
    // Method to get values from the custom setting based on country and category
    @AuraEnabled
    public static List<CS_Country_ContactUs_Mapping__c>  getCountry_ContactUs_Mapping(string Country,String Category) {
        String returnmsg = null;        
        String CountryRefunds = System.Label.PS_Country_Refund;
        Set<string> listOfCountryRefunds = new Set<string>();
        listOfCountryRefunds.addAll(CountryRefunds.split(';'));
        List<CS_Country_ContactUs_Mapping__c> lst = new List<CS_Country_ContactUs_Mapping__c>();        
        List<CS_Country_ContactUs_Mapping__c> refundLst = new List<CS_Country_ContactUs_Mapping__c>();      
        if(listOfCountryRefunds.Contains(Country)){
            String query = 'SELECT Category__c,Chat__c , Country__c,Chat_Form__c,Message__c,Phone__c,Record_Type__c,Web__c,Web_Form__c from CS_Country_ContactUs_Mapping__c WHERE Country__c=' + '\'' + Country + '\'' + ' and Category__c = ' + '\'' + Category +  '\'' ;
            refundLst = Database.query(query);
        }
        else{
            String query = 'SELECT Category__c,Chat__c , Country__c,Chat_Form__c,Message__c,Phone__c,Record_Type__c,Web__c,Web_Form__c from CS_Country_ContactUs_Mapping__c WHERE Country__c=' + '\'' + Country + '\'' ;
            lst= Database.query(query);
        }       
        if(lst.size() > 0){
            return lst;
        }
        else if(refundLst.size() > 0){
            return refundLst;
        }   
        return null;
    }
     //Method for controlling language based on country selection
     @AuraEnabled
     public static List<CS_Country_ContactUs_Mapping__c>  getAllData()
     {
         List<CS_Country_ContactUs_Mapping__c> lst = CS_Country_ContactUs_Mapping__c.getall().values();
        lst.sort();
        return lst;
     }
    // Method to get Refund values from picklist field on Case
    @AuraEnabled
    public static List<String> getRefundReasonValues(){     
        List<String> options = new List<String>();    
        Schema.DescribeFieldResult fieldResultCat = Case.Refund_Reason__c.getDescribe(); 
        List<Schema.PicklistEntry> pleCat = fieldResultCat.getPicklistValues();   
        for (Schema.PicklistEntry f: pleCat) {
            options.add(f.getLabel());
        }       
        return options;
    }
    // Method to check if user has supportToSupport permission
    @AuraEnabled
    public static String getSupportToSupportPermission() 
    {
        String returnMsg = null;
        String PermissionSets = System.Label.PS_SupporttoSpport_PermissionSet;
        String[] listofpermsets = PermissionSets.split(',');
        String query = 'select assignee.id from PermissionSetAssignment where PermissionSet.Name IN : listofpermsets' ;  
        PermissionSetAssignment[] lst = Database.query(query);
        for(PermissionSetAssignment ChkUser : lst)
        { 
         if(ChkUser.Assignee.id == UserInfo.getUserId())
         {
             returnMsg = 'Success';
         }
        }
        return returnMsg;
    }

    // Method to get Contact Support Languages
    @AuraEnabled
    public static List<ContactSupportLanguages__c> getValueLanguage() 
    {        
        List<ContactSupportLanguages__c> languageList = ContactSupportLanguages__c.getall().values();
        languageList.sort();
        return languageList;
    }
    // Method to get Country,Category and Role from custom setting
    @AuraEnabled
    public static List<PS_CountryCategryMap_PrdRole__c> getCountryCategryRole() 
    {        
        List<PS_CountryCategryMap_PrdRole__c> cntryCatgryRole = new List<PS_CountryCategryMap_PrdRole__c>();
        String query = 'SELECT Category__c,Country__c,Role__c from PS_CountryCategryMap_PrdRole__c' ;
        cntryCatgryRole = Database.query(query);
        return cntryCatgryRole;
    }
    // Method to fetch values from EducatorAndStudent label
    @AuraEnabled
    public static List<String> getRoleCollEduAndStudent()
    {        
        List<String> collegeEducatorAndStudent=new List<String>();   
        String collegeEducatorAndStudentLabel = System.label.EducatorAndStudent;
        collegeEducatorAndStudent.addAll(collegeEducatorAndStudentLabel.split(';'));            
        return collegeEducatorAndStudent;   
    }
    // Method to fetch values button id for a unique set of parameters
    @AuraEnabled
    public static List<String> getButtonId(String CountryGroup,String Category,String ProductGroup,
                                                        String Role,String Language) 
    {        
               
        List<String> sChatBtnlst=new List<String>();
        try{
            String rolegroup = '';
            List<PS_ContactRole__c> roleGroupList = new List<PS_ContactRole__c>();
            roleGroupList=[SELECT Role_Grouping__c from PS_ContactRole__c where Name =: Role LIMIT 1] ;
          
            if(!roleGroupList.IsEmpty()){
            rolegroup= roleGroupList[0].Role_Grouping__c;  
            }
                   
            List<PS_FetchChatButton__mdt> lstChatButton = new List<PS_FetchChatButton__mdt>();
            String query = 'SELECT Button_id__c,Deployment_Id__c,Recordtype__c from PS_FetchChatButton__mdt  WHERE Country_Group__c=' + '\'' + CountryGroup + '\'' + ' and Category__c = ' + '\'' + Category + '\'' + ' and Product_Group__c = ' + '\'' + ProductGroup + '\'' +' and Role__c = ' + '\'' + rolegroup + '\'' +' and Language__c = ' + '\'' + Language +  '\' LIMIT 1' ;
           
            lstChatButton= Database.query(query);
            if (lstChatButton.size()>0)
                sChatBtnlst=getChatButtonId(lstChatButton[0].Button_id__c,lstChatButton[0].Deployment_Id__c,lstChatButton[0].Recordtype__c);
            //buttonId = retrievingButtonId[0].Button_id__c;
            //return retrievingButtonId[0];
            return sChatBtnlst;
        }
        catch(System.Exception e)
        {
            //Message=e.getMessage();
            return null;
        }
    }
    @AuraEnabled
    public static List<String> getChatButtonId(String sButtonName,String sDepName,String sRTName){
       
        List<String> lstChatButDets=new List<String>();
        List<LiveChatButton> listlcb = [select id,developername,masterlabel from LiveChatButton where developername=:sButtonName limit 1];
        if (listlcb.size()>0){
            lstChatButDets.add(listlcb[0].id);
        }
        else
            lstChatButDets.add(' ');
        List<LiveChatDeployment> listlcd = [select id,developername,masterlabel from LiveChatDeployment where developername=:sDepName limit 1];
        if (listlcd.size()>0){
            lstChatButDets.add(listlcd[0].id);
        }
        else
            lstChatButDets.add(' ');   
        List<RecordType> lstRecType = [select id,developername,name from RecordType where developername=:sRTName limit 1];
        if (lstRecType.size()>0){
            lstChatButDets.add(lstRecType[0].id);
        }
        else
            lstChatButDets.add(' ');               
        return lstChatButDets;
    }    
    // Method to get Organization value Dynamically
    @AuraEnabled
    public static String getOrganization()
    {  
       return UserInfo.getOrganizationId();    
    } 
    // Method to get Agent messages Dynamically
    @AuraEnabled
    public static List<String> getAgentMessages()
    {  
       List<String> agentMessages=new List<String>();
       String online = System.label.PS_AgentOnline; 
       String offline=  System.label.PS_AgentOffline;
       agentMessages.add(online);
       agentMessages.add(offline);
       return agentMessages;    
    }
       //method to get footer values from label
    @AuraEnabled
    public static List<String> getFooterValues()
    {
        List<String> footerValues=new List<String>();
       String TermsOfUse = System.label.PS_CSS_SelfServiceFooter_TermsOfUse; 
       String PrivacyPolicy=  System.label.PS_CSS_SelfServiceFooter_PrivacyPolicy;
       String Follow = System.label.PS_CSS_SelfServiceFooter_Follow;
       String TermsOfUseSwitch=System.label.PS_CSS_SelfServiceFooter_TermsOfUse_Switch;
       String PrivacyPolicySwitch=  System.label.PS_CSS_SelfServiceFooter_PrivacyPolicy_Switch; 
        String FollowSwitch = System.label.PS_CSS_SelfServiceFooter_Follow_Switch;
       footerValues.add(TermsOfUse);
       footerValues.add(PrivacyPolicy);
       footerValues.add(Follow);
       footerValues.add(TermsOfUseSwitch);
       footerValues.add(PrivacyPolicySwitch);
       footerValues.add(FollowSwitch);
       return footerValues;   
    }
     //method to get refunds valuse from custom label
      @AuraEnabled
    public static String getRefundsLabel()
    {
        String refundValue;
       refundValue = System.label.PS_SelfServiceRefunds; 
       return refundValue;   
    }
       //method to get Product valuse from custom label - d-4490
      @AuraEnabled
    public static String getLearningStudioLabel()
    {
        String learningSudioProductValue;
       learningSudioProductValue = System.label.PS_SelfServiceLearningStudio; 
       return learningSudioProductValue;   
    }

   //method to get Product valuse from custom label - d-4997
      @AuraEnabled
    public static String getEquellaLabel()
    {
        String EquellaProductValue;
       EquellaProductValue = System.label.PS_SelfServiceEquella; 
       return EquellaProductValue;   
    }
        
 
    //RD#1472 code starts  - Prechat methods
    //Method to get Country values from custom setting
    public List<selectOption> getCountryValues(){   
        List<selectOption> countryOptions = new List<selectOption>();
        countryOptions.add(new SelectOption('','--None--'));
        for (CS_country__c c : CS_country__c.getAll().values())
            countryOptions .add(new SelectOption(c.Label__c,c.Label__c));
        countryOptions .sort();
        return countryOptions ;
    }
    //Method to get Category values from Case Category Field
    public List<selectOption> getCategoryValues(){     
        List<SelectOption> options =  new List<SelectOption>();    
        options.add(new selectOption('None','--None--'));    
        Schema.DescribeFieldResult fieldResult = Case.Category__c.getDescribe();    
        List<Schema.picklistEntry> ple = fieldResult.getPicklistValues();    
        for(Schema.picklistEntry f:ple)    
        {    
            options.add(new selectOption(f.getLabel(),f.getValue()));                    
        }    
        return Options;   
    }
    //Method to get Product values from product__c Custom Object
    public List<selectOption> getProductValues(){
        List<selectOption> productOptions = new List<selectOption>();
        productOptions.add(new SelectOption('','--None--'));
        for (product__c prod :[select id,name    from product__c where Active_in_Self_Service__c=true and type__c = 'Product' order by name])
        {
            productOptions.add(new selectOption(prod.id, prod.name));
        }
       
        return productOptions;    
    }
    //Method to get Role values from Custom settings
    public List<selectOption> getRoleValues(){
        List<selectOption> roleOptions = new List<selectOption>();
        roleOptions .add(new SelectOption('','--None--'));
        for (CS_role__c c: CS_role__c.getAll().values())
            roleOptions .add(new SelectOption(c.Label__c,c.Label__c));
        roleOptions .sort();
        return roleOptions ;
    }
    //Method to get Language values from Custom settings
    public List<selectOption> getLanguageValues(){
        List<selectOption> LanguageOptions = new List<selectOption>();
        LanguageOptions .add(new SelectOption('','--None--'));
        for (PS_ContactLanguage_CS__c c: PS_ContactLanguage_CS__c.getAll().values())
            LanguageOptions .add(new SelectOption(c.name,c.name));
        LanguageOptions .sort();
        return LanguageOptions ;
    }
    //Method to get School values 
    public String getSchoolValues() {
        return null;
    } 
    //Method to get State values from Custom settings  
    public List<selectOption> getStateValues() {
        List<selectOption> stateOptions = new List<selectOption>();
        stateOptions .add(new SelectOption('','--None--'));
        for (PS_ContactState_CS__c c: PS_ContactState_CS__c.getAll().values())
            stateOptions .add(new SelectOption(c.name,c.name));
        stateOptions .sort();
        return stateOptions ;
    }
    //Method to get Program values from Custom settings 
    public List<selectOption> getProgramValues() {
        List<selectOption> programOptions = new List<selectOption>();
        programOptions .add(new SelectOption('','--None--'));
        for (product__c c: [select id,name  from product__c where Active_in_Self_Service__c=true and type__c = 'program' order by name])
            programOptions .add(new SelectOption(c.id,c.name));
        return programOptions ;
    }
    //Constructer Method 
    public PS_CSS_ContactSupport () {
        
    }      
} */

/*
 * <!-- <aura:component controller="PS_CSS_ContactSupport" implements="forceCommunity:availableForAllPageTypes" >
 <ltng:require scripts="https://code.jquery.com/jquery-1.11.1.js"/> 
    <ltng:require scripts="/resource/JQuery"/> 
    <ltng:require scripts="https://code.jquery.com/jquery-1.12.0.min.js"/> 
    <aura:handler name="init" value="{!this}" action="{!c.doInit}" />    
    <ltng:require scripts="https://c.la1-c2cs-lon.salesforceliveagent.com/content/g/js/35.0/deployment.js"/> 
    
    <aura:attribute type="String" name="country"></aura:attribute>
    <aura:attribute type="String" name="Language"></aura:attribute>
    <aura:attribute type="String" name="category"></aura:attribute>
    <aura:attribute type="String" name="product"></aura:attribute>
    <aura:attribute type="String" name="role"></aura:attribute>



    <aura:attribute name="queriedArticles" type="KnowledgeArticleVersion" description="Used to display knowledge articles based on customer search"/>
    <aura:attribute name="phoneDetails" type="PS_Country_PhoneMapping__c"/> 
    <aura:attribute name="email" type="CS_Country_EmailMapping__c"/> 
    <aura:attribute name="chat" type="CS_Country_ChatMapping__c"/> 
    <aura:attribute name="contactsupport" type="CS_Country_ContactUs_Mapping__c[]"/> 
    <aura:attribute name="runningUser" type="User"/>
    <aura:attribute name="casenumber" type="Case"/>
    <aura:attribute name="CountryCategryMap_PrdRole__c" type="PS_CountryCategryMap_PrdRole__c[]" /> 
    <aura:attribute name="collegeEducatorAndStudentLabel" type="String[]" />  
    <aura:attribute name="preChatButtonId" type="PS_FetchChatButton__mdt" />
    <aura:attribute name="sChatDetails" type="String[]" description="to capture button id"/>
    <aura:attribute name="agentMessages" type="String[]" description="to capture agent messages"/>
    <aura:attribute name="OrganizationID" type="String" description="to capture Organization id"/>
    <aura:attribute name="listAllData" type="CS_Country_ContactUs_Mapping__c[]"/>
    <aura:attribute name="caseSourceType" type="String" description="to capture the Source type (Phone,Mess,Chat.etc...)"/>
    <aura:attribute name="showSpinner" type="Boolean" default="false" description="Used to Show and hide Spinners"/>
    <aura:attribute name="preCallFormReadOnly" type="Boolean" default="false" description="Used to check if the logged in user is a registered User"/>
    <aura:attribute name="userIsAuthUser" type="Boolean" default="false" description="Make the fields readonly only for the Pre-Call form"/>
    <aura:attribute name="tabCustomMessage" type="String" description="Used to Hold the Custom Message to display in the Tab like Give us a Call,Send us a message etc.."/>
    <div id="Mainmessage">
        <h4 style="color: #9e007e;">Please provide us with some information about yourself and your issue so that we may better assist you. Or, sign in with your Pearson Support </h4>
        <center><h4 style="color: #9e007e;">account to pre-populate select fields and to view your cases.</h4></center>
    </div>
    <div id="searchKAV"  style = "padding-left: 0.5cm" class="form-style-2">
        <div id="Heading1" class="search" style = "cursor:pointer"  data-record="kavSearch" onclick="{!c.HideShowDivs_Controller}" >
            <h3 id="hover"> Please Provide More Information</h3>
        </div>   
       
        <div  id = "kavSearch" >
            <br/>
          
            <p>
                <span><ui:inputText aura:id="searchTitle" maxlength="255" required="true" class="slds-input,width" labelClass="rn_inputText" updateOn="input" placeholder="What are you looking for?" /><span class="required">*</span></span>
            </p>
            <br/>
           
            <p>
                <span>
                    <select  id="countrySelected" onchange="{!c.InfoDropDownChange}" class="topdropdown">
                        <option selected="selected" required="true" class="hideoption" value = "0">Select a Country</option>
                        <aura:iteration items="{!v.country}" var="country">               
                            <option value="{!country.Name}" text="{!country.Label__c}"></option>
                        </aura:iteration>
                    </select>
                    <span class="required">*</span></span>
            </p>
            <p>
                <span>
                    <select id = "languageSelected" required="true" class="topdropdown">
                        <option selected="selected"  class="hideoption" value = "0" >Select a Language</option>
                        <aura:iteration items="{!v.Language}" var="Language">    
                            <option  value="{!Language.Name}" text = "{!Language.Language__c}"></option>                            
                        </aura:iteration>
                    </select>
                    <span class="required">*</span></span>
            </p>
            <p>
                <span>
                    <select  id = "categorySelected" required="true" onchange="{!c.categoryDropDownChange}" class="topdropdown">
                        <option selected="selected" class="hideoption" value = "0">Select a Category</option>
                        <aura:iteration items="{!v.category}" var="category">               
                            <option  value="{!category.Name}" text = "{!category.Name}"></option>
                        </aura:iteration>
                    </select>
                    <span class="required">*</span></span>
            </p>
            <p>
                <span>
                    <select id = "productSelected" required="true" class="topdropdown">
                        <option selected="selected"  class="hideoption" id="selectedProduct" value = "0">Select a Product</option>
                        <aura:iteration items="{!v.product}" var="product">               
                            <option  value="{!product.Id}" text ="{!product.Name}" ></option>
                        </aura:iteration>
                    </select>
                    <span class="required">*</span></span>
            </p>
            <p>
                <span>
                    <select id = "roleSelected" required="true" class="topdropdown">
                        <option selected="selected"  class="hideoption" value = "0" >Select a Role</option>
                        <aura:iteration items="{!v.role}" var="role">    
                            <option  value="{!role.Name}" text = "{!role.Label__c}"></option>
                        </aura:iteration>
                    </select>
                    <span class="required">*</span></span>
            </p>
            <br />
            <!-- ==========Validation Code Starts ============= -->
          <!--  <div  id = "ValidationMessage" style="display:none; color:red" data-record="ValidationMessage"  >
                <br />
            </div>
          
            <!-- ==========Validation Code Ends ============= -->
         <!--   <p>
                <input type="button" id="continue" name='button' data-record="articleDisplay" value="Continue" onclick="{!c.getNextPage}"/>
            </p>
        </div>
        <!--...................................................Section 2-->
      <!--  <div  id = "articleDisplayHeading" style="display:none; cursor:pointer" data-record="articleDisplay" onclick="{!c.HideShowDivs_Controller}"  class="form-style-2">
            <h3 id="hover">Need Answers Fast?</h3> 
        </div>
        <div id = "articleDisplay" style="display:none" class="form-style-2">
            <br/>
            <div id="article" style="display:none">
                <h4>Check out these articles...</h4><br/>
                <aura:iteration items="{!v.queriedArticles}" var="art">
                    <p>
                        <p>
                            <p>
                                <h4>
                                    <h5>  <a  onclick="{!c.OpenArticle}" data-record="{! '/'+ art.ArticleType+'/'+art.UrlName }" >{!art.Title}</a><br/></h5>
                                    {!art.Summary}
                                    <br />	
                                </h4>
                            </p>
                        </p>
                    </p>
                </aura:iteration>
                <br />
            </div>
            <div id="noArticleMessage" style="display:none">
                <h4>No articles are found on this topic...</h4>
            </div>
            <br/>
            <br/>
            <div id = "otherOptions" style="display:none">
                <h4>
                    Didn't find what you are looking for?
                </h4>
                </div>
          
               <br />
         
            <div id ="clickMethod">
                <input type="button" data-record="methodButton" onclick="{!c.HideShowDivs_Controller}" class="button1" id="clickforOptions" name='button'  value="Click Here"/>
            </div>
            
              <div id="ChannelMsg" style="display:none">
                <div id="manychannelfound" style="display:none" >
                    <h5>
                        Click on your preferred method to contact
                    </h5>
                </div>
                 <div id="onlyonechannelfound" style="display:none">
                    <h5>
                        Please contact us utilizing the method below
                    </h5>
                </div>
        	</div>
           
            <div  id = "RefundsMessage" style="display:none"  >
                 <br />
                If you were billed in US dollars (USD): Click on the Send Us a Message Button Below<br />
                If you were billed in Canadian dollars (CAD) email <a href="mailto:cdn.smsordr@pearsoned.com"> cdn.smsordr@pearsoned.com</a><br />
                If you were billed in UK pounds sterling (GBP) email <a href="mailto:heenquiriesuk@pearson.com">heenquiriesuk@pearson.com </a><br />
                If you were billed in Australian dollars (AUD) email <a href="mailto:customer.service@pearson.com.au">customer.service@pearson.com.au</a><br />
                <br />
            </div>
            <br/>
            <div id= "methodButton" style="display:none" >
                
            <input class="btncss" type="button" id="btnChat" onclick="{!c.preChat}" />
            <input class="btncss" type="button" id="btnEmail" data-record="webToCaseForm" onclick="{!c.createCaseForm}"/>
            <input class="btncss" type="button" id="btnPhone" data-record="displayPhone" onclick="{!c.getPhone}" />  
            <br/>
            </div>
            <br/>
            
        </div>
        <!--end of section 2-->
        <!--section 3 begins - Web to Case-->
    <!--    <div style="display:none ; cursor:pointer" id = "webToCaseFormHeading" data-record="webToCaseForm" onclick="{!c.HideShowDivs_Controller}" class="form-style-2">
            <!-- <h3 id="hover">Send Us a Message</h3>-->
	<!--		<h3 id="hover">{!v.tabCustomMessage}</h3>
        </div>
        
        <div style="display:none" id = "webToCaseForm">
                <br/>
            	<div aura:id="preCallMessage"> 
                    <label style="float: none;">Please complete the fields below, or sign in to your Pearson Support account and the fields will auto-populate. </label>
                    <br/>
                    <label style="float: none;">Once the fields have been completed, we’ll give you our Support phone number, and a case number to reference when you call us.</label>
                    <br/><br/>
                    <!--<label style="float: none;">We can get you to the right agent and serve you</label>
                    <br/>
                    <label style="float: none;">faster when you fill out the fields below</label>
                    <br/><br/>
                    <label style="float: none;">Also know that if you login to the support site your</label>
                    <br/>
                    <label style="float: none;">account details will auto-populate</label>-->
   <!--             </div>
      <!--          <br/>
                <br/>
                <div id = "Row_CS-CG_1" >
                      <label for="firstname" >First Name:</label>
                   <p id="paragraph">    <span>
                        <input id="firstname" maxlength="100" name="firstname" value="{!v.runningUser.FirstName}" class="textfield readOnlyItem" disabled = "{!v.preCallFormReadOnly}"/> 
                       <span  class="req">*</span></span>
                   </p>                 
                </div>
            
                <div id = "Row_CS-CG_2" >
                    
                        <label for="lastname" >Last Name:</label>
            	<p id="paragraph">  <span>
                            <input id="lastname" aura:id="lastname" maxlength="100" name="lastname" value="{!v.runningUser.LastName}" class="textfield readOnlyItem"  disabled = "{!v.preCallFormReadOnly}"/> 
                       
                       <span  class="req">*</span></span>
            </p>
                </div>

                <div id = "Row_CS-CG_3" >
                            <label for="email">Email:</label>
                    <p id="paragraph">  <span>
                            <input  id="email" aura:id="email" maxlength="100" value="{!v.runningUser.Email}" name="email" class="textfield readOnlyItem" disabled = "{!v.preCallFormReadOnly}"/>
                      
                      <span  class="req">*</span></span>
                    </p>
                </div>
                <div id = "Row_CS-CG_4">
                   
                            <label for="phone">Phone:</label>
                       
                 <p id="paragraph">    <span>       <input  id="phone" value="{!v.runningUser.MobilePhone}" maxlength="40" name="phone" class="textfield"/>
                      
                     <span  class="req">*</span></span></p>
                
                </div>
            
                <div id = "Row_5" STYLE="display:none">
                   
                       
                            <label for="Pearson Access Next Username:" >Pearson Access Next Username:</label>
                       
                     <p id="paragraph">       <input  id="pearsonaccess" maxlength="255" name="pearsonaccess" size="20" type="text1"  class="focus"/>
                    </p>
                </div> 
                <div id = "Row_CS-CG_PearsonUsername" style= "display:none">
                            <label for=" Username:"> Username:</label>
                       
                            <input  id="Username" value="{!v.runningUser.Username}" maxlength="255" name="Username" size="20" type="text1" class="focus"/>
                </div>
                <div id = "Row_CG_6">
                   
                            <label for="subject">Issue:</label>
                       
                   <p id="paragraph">      <span>   <input  id="subject" maxlength="255" name="subject" class="textfield" />
                       
                       <span  class="req">*</span></span></p>
                   
                </div>
                <div id = "Row_CS-CG_7">
                    
                            <label for=" Role:">Role:</label>
                      
                   <p id="paragraph">  <span>       <select class="textfield" style=" background-color:grey" id="Rol" name="00N1100000UNM9" title="Role" disabled = "true">
                                <option  class="hideoption" id="CaseselectedRole" value = "0">Select a Role</option>
                                <aura:iteration items="{!v.role}" var="role">  
                                    <option value="{!role.Name}" text ="{!role.Label__c}"></option>
                                </aura:iteration>
                            </select>                 
                       
                        <span  class="req">*</span></span></p>
                  
                </div>
           		
                <div style="display:none" id = "Row_CS-CG_Program">
                    
                        <label for=" Program:"> Program:</label>
                   
                        <select class="focus3" style="width: 300px; position: relative; left:150px" id="program" name="program" title="Program" ><option value="">--None--</option>
                            <option value="Choose a program">Choose a program</option>
                        </select>
                   
                </div>
                <div style="display:none">
                   
                        <label for=" District:">District:</label>
                 
                        <select class="focus3" style="width: 300px; position: relative; left:150px;" id="District" name="District" title="District">
                            <option value="">--None--</option>
                            <option value="N/A">N/A</option>
                        </select>
                    
                </div>
                <div  id = "Row_CS_8">
                  
                            <label for="School:">School:</label>
                       
                       <p id="paragraph"> <span>   <input  id="School" maxlength="100" name="School" class="textfield"/>
                       
                           <span class="req">*</span></span></p>
                  
                </div>
                <div id = "Row_CS-CG_9">
                   
                            <label for="Topic">Issue Category:</label>
                       
                     <p id="paragraph">  <span>     <select class="textfield" style="background-color:grey" id="Cat" name="00N1100000UNM9" title="Category" disabled = "true">
                                <option  class="hideoption" id="CaseselectedTopic" value = "0">Select a Topic</option>
                                <aura:iteration items="{!v.category}" var="category">               
                                    <option  value="{!category.Name}" text ="{!category.Name}"></option>
                                </aura:iteration>
                            </select>
                       
                         <span class="req">*</span></span></p>
                   
                </div>
                <div  id = "Row_CS-CG_10">
                    
                            <label for="Language:">Language:</label>
                 <p id="paragraph"><span><select class="textfield" style="background-color:grey" id="Language" name="Language" title="Language" disabled = "true">
                                <option selected="selected" class="hideoption" value = "0">Select a Language</option>
                            </select>
                     <span  class="req">*</span></span></p>
                   
                </div>
                <div id = "Row_CS-CG_11">
                   
                            <label for="Country:">Country:</label>
                      <p id="paragraph">  <span>    <select class="textfield" style="background-color:grey" id="Country" name="00N11000001UNN2" title="Country" value="{!v.runningUser.Country}" disabled="true">
                                <option  class="hideoption" id="CaseselectedCountry" value = "0">Select a Country</option>
                                <aura:iteration items="{!v.country}" var="country">               
                                    <option value="{!country.Name}" text ="{!country.Label__c}"></option>
                                </aura:iteration>
                            </select>
                       
                          <span  class="req">*</span></span></p>
                   
                </div>
                <div id = "Row_CG_12">
                    <label for="Organization:">School/College:</label>
                      <p id="paragraph"> <span>     <input  id="organization" maxlength="255" name="Organization" class="textfield"/>
                          <span class="req">*</span></span></p>
                </div>
                <div id = "Row_CS-CG_18">
                   
                            <label for="Product">Product:</label>
                      
                     <p id="paragraph"><span>       <select class="textfield" style="background-color:grey" id="Product" title="Product" disabled="true">
                                <option  class="hideoption" id="CaseselectedProduct" value = "0">Select a Product</option>
                                <aura:iteration items="{!v.product}" var="product">               
                                    <option  value="{!product.Id}" text ="{!product.Name}"></option>
                                </aura:iteration>
                            </select>
                      
                         <span class="req">*</span></span></p>
                   
                </div>
                <div id = "Row_CG_19">
                    
                            <label for="CourseID">Course ID:</label>
                          <p id="notreq"><span>  <input  id="CourseID" maxlength="255" name="CourseID" class="textfield"/>
                      
                        <!--  Removed Asterix as per Defect 4510 -->
       <!--                       <span class="req" ></span></span></p>
                </div>
                <div id = "Row_13" style ="display:none">
                   
                            <label for="Topic:">Topic:</label>
                        
                           <p id="paragraph"><span> <input  id="Topic" maxlength="80" name="Topic" class="textfield"/>
                     
                               <span class="req">*</span></span></p>
                    
                </div>
                <div id = "Row_CS_15">
                   
                            <label for="Order ID:">Order ID:</label>
                      
                           <p id="notreq"><span> <input  id="orderId" maxlength="100" name="Order ID"  class="textfield"/>
                               <span class="req" ></span></span> </p>
                </div>
                <div id = "Row_CS_16">
                   
                            <label for="Currency of Purchase">Currency of Purchase:</label>
                     
                          <p id="paragraph"><span>  <select class="textfield" id="CurrencyofPurchase" name="Currency of Purchase" title="Currency of Purchase">
                                <option value="">--None--</option><option value="USD">USD</option>
                            </select>
                       
                              <span class="req">*</span></span></p>
                 
                </div>
                <div id = "Row_CS_17">
                    
                            <label for="Refund Reason">Refund Reason:</label>
                                          
                          <p id="paragraph"><span>  <select class="textfield" id="Reason" name="00N1100000UNM9" title="RefundReason">
                                <option selected="selected" class="hideoption" value = "">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Select a Refund Reason</option>
                                <aura:iteration items="{!v.RefundReason}" var="RefundReason">               
                                    <option  value="{!RefundReason}" text="{!RefundReason}"></option>
                                </aura:iteration>
                            </select>
                       
                              <span  class="req">*</span></span></p>
                   
               
                </div>
                <div style="display:none">
                   
                        <label for=" City:"> City:</label>
                        <select class="textfield" id="City" name="City" title="City">
                            <option value="">--None--</option>
                        </select>
                </div>
                <div style = "display:none">
                   
                        <label for="State:"> State:</label>
                  
                        <select class="textfield" id="State" name="State" title="State">
                            <option value="">--None--</option>
                        </select>
                   
                </div>
                <div id = "Row_CS-CG_18">
                    
                       <label for="Message" style="width:37%;">Description of Issue (Please provide specific access code, error message, etc.):</label>
                   <p id="paragraph"> <span> <textarea id="Message" maxlength="32000" name="Message" class="messagetextfield" wrap="soft"/>
                       
                       <span class="req">*</span></span></p>
                    
                    
                    <br/>
                </div>
                <div id="WebFormType" style="display:none; position: relative; align:center;"> 
                    <input  id="txtWebFormType" maxlength="80" name="Order ID" size="20" type="text1" value= "{!v.contactsupport[0].Record_Type__c }" class="focus"/>
                </div>  
                
                <!-- ==========Validation Code Starts ============= -->
       <!--         <div  id = "CaseValidationMessage" style="display:none; color:red" data-record="ValidationMessage"  >
                    <br />
                    <br />
                </div>
                <!-- ==========Validation Code Ends ============= -->
                <!-- =====captcha code=====  -->
     <!--           <br/>
                <label id="Term"> 
                    <input type="checkbox" name="Terms" value="Terms" id="Terms" onchange="{!c.activateButton}"/>
                    I accept and agree to Pearson's
                </label>
            	<label id="Term"> 
                    <a id="Terms" onclick="{!c.openTerms}">Terms of Use</a>
                    and
                    <a onclick="{!c.openPrivacyPolicy}">Privacy Policy</a>
                </label>
                    <br/>
            		<br/>
                <div id="captchasection" >
                    <br/>
                           
                               <input type="textforcaptcha" id="Captcha" readonly="true"></input>
                                <a id="refreshLink" onclick="{!c.refreshCaptcha}">Refresh</a><br />
                                <input type="textforcaptcha" placeholder="Enter the Captcha as above" id="txtInput"/>    
                   
                </div>
                <br/>
                <!-- =====captcha code End=====  -->
    <!--            <input type="Submit"   id="terms" onclick="{!c.createCase}" />
                
            
        </div>
        <div id= "CaseCreationMsg" style="display:none;">
            <div id="WaitingMsg" > 
                <label id= "waitmsg" for="" style="text-align:center">Please wait while we generate your case number.</label> 
            </div>
            <br/>
            <br/>
			
            <c:Spinner type="spears" width="45" height="45" color="blue" show="{!v.showSpinner}" />
            <!-- <ui:spinner aura:id="spinner" /> -->
            <!--
			<ui:spinner aura:id="spinner"/>
			<div style="position: relative; align:center;">
                <div id="progressBar" >
                    <div id = "innerprogressBar" >
                    </div>
                </div>
            </div> -->

   <!--         <div id="SuccessLabel" style="display:none; position: relative; align:center;"> 
                <label >Your case has been created successfully. Your Case Number is</label>
                <label id= "num" for="{!v.casenumber}" > {!v.casenumber}</label>
            </div>
        </div>
        <!--end of section 3-->
        <!--...................................................Section 4 Phone contact mapping-->
   <!--     <div style="display:none ; cursor:pointer" id = "displayPhoneHeading" data-record="displayPhone" onclick="{!c.HideShowDivs_Controller}" class="form-style-2">
            <h3 id="hover">Phone Number</h3> 
        </div>
        <br />
       <div style="display:none" id = "displayPhone" class="form-style-2" >
            <div id="SuccessLabelPhone" style="align:center;">
                <!--<label style="width: 760px;">
                	Thank you for creating case number
                </label><br/>-->
   <!--             <label id= "num" style="width: 760px;" for="{!v.casenumber}" >
                    Thank you. Your case # is {!v.casenumber}
                </label> 
            </div>
            <br/><br/><br/><br/>
            <div>
           		<label style="width: 760px;">
                    <b>Please note: <br/>
                        &bull; Our Support team will not begin working on your issue until you contact us. If we don’t hear from you within 24 hours, this case will automatically be closed.<br/>&bull; To view this case number in the future, sign in to your Pearson Support account and click on the "My Cases" tab</b>
                </label>
            </div>
           <br/><br/><br/><br/>
            <!-- <tr><td style="width: 110px;">  <label id="phone"  for="Phone" >Call Pearson Support:</label> </td> -->
            <!-- <tr><td style="width: 450px;padding-left: 225px;">  <label> Call Pearson Support:</label> </td>
            <td style="width:180px"><label id= "number" for="{!v.phoneDetails}">{!v.phoneDetails}</label> </td></tr> -->
    <!--        <label style="width: 760px;"> Pearson Support:</label><br/>
            <label style="width: 760px;text-decoration: underline;" id= "number" for="{!v.phoneDetails}">{!v.phoneDetails}</label>
         
        </div>
        <!--end of section 4-->
 <!--   </div>
    <div id="Country_CntryCat_Map_PrdRole" style="display:none; position: relative; align:center;"> 
        <input  id="txtCountry_CntryCat_Map_PrdRole" maxlength="80" name="Order ID" size="20" type="text1" value= "{!v.CountryCategryMap_PrdRole__c[0].Country__c}" class="focus"/>
    </div>  
    <div id="Category_CntryCat_Map_PrdRole" style="display:none; position: relative; align:center;"> 
        <input  id="txtCategory_CntryCat_Map_PrdRole" maxlength="80" name="Order ID" size="20" type="text1" value= "{!v.CountryCategryMap_PrdRole__c[0].Category__c}" class="focus"/>
    </div> 
    <div id="Role_CntryCat_Map_PrdRole" style="display:none; position: relative; align:center;"> 
        <input  id="txtRole_CntryCat_Map_PrdRole" maxlength="80" name="Order ID" size="20" type="text1" value= "{!v.CountryCategryMap_PrdRole__c[0].Role__c }" class="focus"/>
    </div>  
    <div id="collegeEducatorAndStudentLabel1" style="display:none; position: relative; align:center;"> 
        <input  id="txtcollegeEducatorAndStudentFirstValue" maxlength="80" name="Order ID" size="20" type="text1" value= "{!v.collegeEducatorAndStudentLabel[0] }" class="focus"/>
    </div> 
    <div id="collegeEducatorAndStudentLabel2" style="display:none; position: relative; align:center;"> 
        <input  id="txtcollegeEducatorAndStudentNextValue" maxlength="80" name="Order ID" size="20" type="text1" value= "{!v.collegeEducatorAndStudentLabel[1] }" class="focus"/>
    </div> 
  <!--  <div id="preChatButtonIdDiv" style="display:none; position: relative; align:center;"> 
        <input  id="txtpreChatButtonId" maxlength="80" name="ButtonID" size="20" type="text1" value= "{!v.preChatButtonId.Button_id__c }" class="focus"/>
        <input  id="txtpreChatRecordTypeId" maxlength="80" name="RecordTypeID" size="20" type="text1" value= "{!v.preChatButtonId.RecordType__c }" class="focus"/>
        <input  id="txtpreChatDeploymentId" maxlength="80" name="DeploymentID" size="20" type="text1" value= "{!v.preChatButtonId.Deployment_Id__c}" class="focus"/>
    </div> -->

	
<!--</aura:component>   </aura:component> */

}