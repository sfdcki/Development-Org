({
    //Defining Global Variables
   
  
    
   
    doInit : function(component, event, helper) {
        // Get the User Type as Registered or Unregistered and Control Display 
        var userTypeFuc = component.get("c.checkIfRegisteredUser");
        userTypeFuc.setCallback(this, function(a) {
            component.set("v.userIsAuthUser", a.getReturnValue());
            console.log('User Type==='+component.get("v.userIsAuthUser"));
        });
        $A.enqueueAction(userTypeFuc);
        var actionCurrentUserDetails = component.get("c.getCurrentUser");  // Getting user details from sever site controller
        // Set the response data on the component attribute
        actionCurrentUserDetails.setCallback(this, function(a) {
            component.set("v.runningUser", a.getReturnValue()); 
            //console.log("UserType-->"+a.getReturnValue().UserType);
            //Setting Running User Details - for Pre Chat Auto Populate. // 5/11
            /*if(a.getReturnValue() != null)
            {
           /* localStorage.setItem('runningUserId',a.getReturnValue().Id);
            localStorage.setItem('runningUserName',a.getReturnValue().Name);
            localStorage.setItem('runningFirstName',a.getReturnValue().FirstName);
            localStorage.setItem('runningLastName',a.getReturnValue().LastName);
            localStorage.setItem('runningEmail',a.getReturnValue().Email);
            localStorage.setItem('runningPhone',a.getReturnValue().MobilePhone);
            localStorage.setItem('runningUserType',a.getReturnValue().UserType);
            }
            else{               
           /* localStorage.setItem('runningUserId','');
            localStorage.setItem('runningUserName','');
            localStorage.setItem('runningFirstName','');
            localStorage.setItem('runningLastName','');
            localStorage.setItem('runningEmail','');
            localStorage.setItem('runningPhone','');
            localStorage.setItem('runningUserType',''); 
            }*/
        });
        
        //Get Refund Value d-4494
            var actionRefundValue = component.get("c.getRefundsLabel");
         	actionRefundValue.setCallback(this, function(a) {
            component.set("v.refundValue", a.getReturnValue()); 
           
        });
     
       $A.enqueueAction(actionRefundValue);
       
        //Get Product Value d-4490
            var learningSudioProduct = component.get("c.getLearningStudioLabel");
         	learningSudioProduct.setCallback(this, function(a) {
            component.set("v.learningSudioProductValue", a.getReturnValue()); 
        });
       $A.enqueueAction(learningSudioProduct);
        
         //Get Product Value d-4997
            var EquellaProduct = component.get("c.getEquellaLabel");
         	EquellaProduct.setCallback(this, function(a) {
            component.set("v.EquellaProductValue", a.getReturnValue()); 
        });
       $A.enqueueAction(EquellaProduct);
       
        // getting the global header data
      var getGlobalSearchclass = document.getElementsByClassName('search-field-group')[0];  
       var inputElement = getGlobalSearchclass.getElementsByTagName("input")[0]; 
       var globalSearchTitle = inputElement.value;
       var getSearchTitle = component.find("searchTitle");
       getSearchTitle.set("v.value",globalSearchTitle);
       
       // Add the server-side action to the queue of actions to be executed
        $A.enqueueAction(actionCurrentUserDetails);
        var actionCountryValue =component.get("c.getValueCtry"); //Get the country list from DB
        // Set the response data on the component attribute
        actionCountryValue.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('response country:'+response.getReturnValue());
                component.set("v.country", response.getReturnValue());
               
                
            } else {
                $A.error('Unable to load Country'); 
            } 
        });
        $A.enqueueAction(actionCountryValue);
        
          //======CountryLanguage Dependency Code starts here ====
        var actionLanguage=component.get("c.getAllData");
        actionLanguage.setCallback(this, function(response){
                component.set("v.listAllData", response.getReturnValue()); 
                 });
              $A.enqueueAction(actionLanguage);
         //======CountryLanguage Dependency Code ends here ====
         
        var actionCaseCategoryValues =component.get("c.getpickvalCaseCat"); //Get the catagory list from DB
        console.log('values are' +actionCaseCategoryValues );
        // Set the response data on the component attribute
        actionCaseCategoryValues.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('response category:'+response.getReturnValue());
                component.set("v.category", response.getReturnValue());
                
            } else {
                $A.error('Unable to load Category'); 
            } 
        });
        $A.enqueueAction(actionCaseCategoryValues);
        /*start added on 28/12/2015 */
        var actionReason =component.get("c.getRefundReasonValues"); //Get the catagory list from DB
        console.log('values are' +actionReason );
        // Set the response data on the component attribute
        actionReason.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('response Refund Reason:'+response.getReturnValue());
                component.set("v.RefundReason", response.getReturnValue());
            } else {
                $A.error('Unable to load Refund Reason'); 
            } 
        });
        $A.enqueueAction(actionReason);
        /*End added on 28/12/2015 */
        /*start added on 7/1/2016 */
        var actionLanguage =component.get("c.getValueLanguage"); //Get the catagory list from DB
        console.log('values are' +actionReason );
        // Set the response data on the component attribute
        actionLanguage.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('response Language:'+response.getReturnValue());
                component.set("v.Language", response.getReturnValue());
            } else {
                $A.error('Unable to load Language'); 
            } 
        });
        $A.enqueueAction(actionLanguage);
        /*End added on 7/1/2016 */
        var actionPrd =component.get("c.getValuePrd"); //Get the product list from DB
        // Set the response data on the component attribute
        actionPrd.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('response product:'+response.getReturnValue());
                component.set("v.product", response.getReturnValue());
            } else {
                $A.error('Unable to load Data Product'); 
            }
        });
        $A.enqueueAction(actionPrd);
        var actionRole =component.get("c.getValueRole"); //Get the Role list from DB
        // Set the response data on the component attribute
        actionRole.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('response role:'+response.getReturnValue());
                component.set("v.role", response.getReturnValue());
            } else {
                $A.error('Unable to load Role'); 
            } 
        });
        $A.enqueueAction(actionRole);
        var actionCntryCat_PrdRole =component.get("c.getCountryCategryRole"); //Get the Role list from DB
        // Set the response data on the component attribute
        actionCntryCat_PrdRole.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('response role:'+response.getReturnValue());
                component.set("v.CountryCategryMap_PrdRole__c", response.getReturnValue());
            } else {
            } 
        });
        $A.enqueueAction(actionCntryCat_PrdRole);
        var actionPhoneRole =component.get("c.getRoleCollEduAndStudent"); //Get the Role list from DB
        // Set the response data on the component attribute
        actionPhoneRole.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('response role:'+response.getReturnValue());
                component.set("v.collegeEducatorAndStudentLabel", response.getReturnValue());
            } 
        });
        $A.enqueueAction(actionPhoneRole);
        
        
        
        
        
        //===PearsonSupport - Fetching URL Param and setting starts
      /*  
      var paramcntry = helper.getParameterByName('cntry'); 
       // alert(paramcntry);
    if(paramcntry!=null)
    {
          var cntryparam = component.find("country1");
        alert(cntryparam.value);
       cntryparam.set("v.value","Albania");
           
    }*/
        //===PearsonSupport - Fetching URL Param and setting ends
    },  
    
  
    OpenArticle: function(component,event){
        var selectedItem = event.currentTarget;
        var Name = selectedItem.dataset.record;
        var url = Name.split("__kav");
        window.open("/getsupport/s/article" + url [1], '_blank');
    },
    
    getNextPage: function(component,event,helper){
        var textField = component.find("searchTitle");
        var searchTitle = textField.get("v.value");
        var country = document.getElementById("countrySelected").value;
        var category = document.getElementById("categorySelected").value;
        var product = document.getElementById("productSelected").value;
        var role = document.getElementById("roleSelected").value;  
        var selectedLanguage = document.getElementById("languageSelected").value;
        var cntry_id = document.getElementById("countrySelected");    
        var countryText= cntry_id.options[cntry_id.selectedIndex].text; 
        var ctgry_id = document.getElementById("categorySelected");    
        var categoryText= ctgry_id.options[ctgry_id.selectedIndex].text;   
        var prod_id = document.getElementById("productSelected");    
        var productText= prod_id.options[prod_id.selectedIndex].text;  
        var role_id = document.getElementById("roleSelected");    
        var roleText= role_id.options[role_id.selectedIndex].text;  
        var language_id = document.getElementById("languageSelected");    
        var languageText= language_id.options[language_id.selectedIndex].text;
        //var language = document.getElementById("languageSelected").value;  
        //========Validation Code Starts =============
        var ValidationArray = [];
        ValidationArray[0] = ["Search Title",$.trim(searchTitle), "TextBox", "AlphaNumeric" ];
        ValidationArray[1] = ["Country", country , "DropDown" ,"DropDown"];
        ValidationArray[5] = ["Category", category , "DropDown","DropDown" ];
        ValidationArray[3] = ["Product", product , "DropDown","DropDown" ];
        ValidationArray[4] = ["Role", role , "DropDown","DropDown" ];
        ValidationArray[2] = ["Language", selectedLanguage , "DropDown" ,"DropDown"];
        var ValidationMsg = helper.Validation(ValidationArray);
        if(ValidationMsg != "0")
        {
            $('#ValidationMessage').show();
            $('#ValidationMessage').html (ValidationMsg);
            return false;
        }
        else
        {
           
            $('#ValidationMessage').hide();
            
        }
        //==========Validation Code Ends =============
        //====Hide Show Phone Email Chat --As per Google Doc shared by Gabriel ====         
        var cntry = document.getElementById("countrySelected");    
        var countrySelected= cntry.options[cntry.selectedIndex].text; 
        var ctgry = document.getElementById("categorySelected");    
        var categorySelected= ctgry.options[ctgry.selectedIndex].text;   
        var refundsLabel = component.get("v.refundValue");
        
    //  d-4514
        if(categorySelected == refundsLabel)
        {
            //$('#RefundsMessage').show();
        }
        else
        {
            categorySelected = 'All else'; //As per the input Role should be student if it is not college educator.
            $('#RefundsMessage').hide();
        } 
        
        
         var learningSudioProductLabel = component.get("v.learningSudioProductValue");
         var EquellaProductLabel = component.get("v.EquellaProductValue");
        var actionContactSupport  = component.get("c.getCountry_ContactUs_Mapping");
        actionContactSupport.setParams({
            "Country": countrySelected,
            "Category" : categorySelected,
        }); 
        // Set the response data on the component attribute
        
        actionContactSupport.setCallback(this, function(ChtContactResp) {
            component.set("v.contactsupport", ChtContactResp.getReturnValue());
          
       
            var i=3; // variable declare for button visibility
            //Defect 4501 and 4424 - If Cat = refunds - Only "Send us a Message" will be available
            $('#btnEmail').hide();
            $('#btnChat').hide();
            $('#btnPhone').hide();
            $('#RefundsMessage').hide();
           // alert(productText);
            //alert(EquellaProductLabel);
            if( productText == EquellaProductLabel)
            {
                $('#btnEmail').show();
                $('#btnPhone').show();
                i=0;
            }
            else if(ctgry.options[ctgry.selectedIndex].text == refundsLabel)
                { 
                    $('#btnEmail').show();
                    i=1;
                }
                else
                {
                    if( ChtContactResp.getReturnValue()[0].Web__c == 1)
                    {
                        // d-4490 comparing learning studio product from label
                        if( productText == learningSudioProductLabel)
                        {
                            
                            $('#btnEmail').hide();
                            i=i-1; 
                        }
                       else
                       {
                            $('#btnEmail').show();
                       }
                    }
                    else
                    {
                        $('#btnEmail').hide();
                        i=i-1; // value of i will be decreased if button is not visible
                    }
                    if( ChtContactResp.getReturnValue()[0].Chat__c == 1)
                    {
                        $('#btnChat').show();
                    }
                    else
                    {
                        $('#btnChat').hide();
                        i=i-1; // value of i will be decreased if button is not visible
                    }
                    if( ChtContactResp.getReturnValue()[0].Phone__c == 1)
                    {
                        $('#btnPhone').show();
                    }
                    else
                    {
                        $('#btnPhone').hide();
                        i=i-1; // value of i will be decreased if button is not visible
                    }
                }
            
           if(i==1) // only one button visible
           {
                $('#onlyonechannelfound').show();
                $('#manychannelfound').hide();
           }
            else
            {
                 $('#onlyonechannelfound').hide();
                 $('#manychannelfound').show();
            }
			$('#methodButton').show();
            $('#clickMethod').hide();
   
        });
        // Add the server-side action to the queue of actions to be executed
        $A.enqueueAction(actionContactSupport);
        var actionGetOrganizationDetails=component.get("c.getOrganization");
            actionGetOrganizationDetails.setCallback(this, function(a) {
            var state = a.getState();
              if (state === "SUCCESS") { 
              var orgid=component.set("v.OrganizationID", a.getReturnValue());
               }           
        });   
   
        $A.enqueueAction(actionGetOrganizationDetails);
           
        var actionGetAgentDetails=component.get("c.getAgentMessages");
            actionGetAgentDetails.setCallback(this, function(a) {
            var state = a.getState();
              if (state === "SUCCESS") { 
              		component.set("v.agentMessages", a.getReturnValue());
               } 
        });        
        $A.enqueueAction(actionGetAgentDetails);
        
    
        //====Get Articles=========
        var actionGetMappedValues = component.get("c.getValues");
        //setting all the parameters
        actionGetMappedValues.setParams({
            "country": country,
            "category" : category,
            "product" : product,
            "role" : role,
            "searchTitle" : searchTitle
        }); 
        // Set the response data on the component attribute 
        actionGetMappedValues.setCallback(this, function(response) {
            var state = response.getState();
              if (state === "SUCCESS") {
              component.set("v.queriedArticles", response.getReturnValue());
               } 
            if( response.getReturnValue() == null ||  response.getReturnValue() == "")
           {
                $('#article').hide();
                $('#noArticleMessage').show();
                $('#otherOptions').show();
                $('#manychannelfound').hide();
           }
            else
            {
                $('#article').show();
                $('#otherOptions').show();
                $('#noArticleMessage').hide();
            }
       }); 
        // Add the server-side action to the queue of actions to be executed
        $A.enqueueAction(actionGetMappedValues);
        //====Get Articles========= 
        
        //====Get Button Id====
        var listAllData = component.get("v.listAllData"); //Since Country Drop Down is already fetching data during page load - Grouping is also fetched to avoid additional query
        var listProdData = component.get("v.product"); // Since Product Drop Down is already fetching data - Grouping is also fetched to avoid additional query
        var listCatData = component.get("v.category");
        var strpreChatCountryGroup;
        var strpreChatProductGroup;
        var strpreChatCategoryGroup;
        
  
           $.each(listAllData, function(i, value)
         { 
             
                 if(countryText == listAllData[i].Country__c)
                 {
                    	strpreChatCountryGroup = listAllData[i].Country_Group__c;
                 }
             
         });
        
           $.each(listProdData, function(i, value)
         { 
             
                 if(productText == listProdData[i].Name)
                 {		
                    	strpreChatProductGroup = listProdData[i].Product_Group__c ;
                 }
             
         });
 
         $.each(listCatData, function(i, value)
         { 
             
                 if(categoryText == listCatData[i].Name)
                 {
                    	strpreChatCategoryGroup = listCatData[i].Grouping__c ;
                 }
             
         });
       
        var actionGetButtonId = component.get("c.getButtonId");
      //setting all the parameters
        actionGetButtonId.setParams({
            "CountryGroup": strpreChatCountryGroup,
            "Category" : strpreChatCategoryGroup,
            "ProductGroup" : strpreChatProductGroup,
            "Role" : roleText,
            "Language" : languageText
        }); 
        // Set the response data on the component attribute 
        actionGetButtonId.setCallback(this, function(response) {
           var state = response.getState();
            if (state === "SUCCESS" ) {
                console.log('response:'+response.getReturnValue());
               component.set("v.sChatDetails", response.getReturnValue()); 
               // alert("Continue - " + response.getReturnValue().Button_id__c);
            } 
            
            //======Code for Getting Phone Number Starts======
          var CountryGroup = strpreChatCountryGroup; //Reusing the code for Phone
          var ProductGroup = strpreChatProductGroup;//Reusing the code for Phone
      
            //d-4997 - sending countryhub as blank for Equella Product.
            if(ProductGroup == EquellaProductLabel )
          {
              CountryGroup = "";
          }

        var actionPhone  = component.get("c.getPhoneNumber");
        console.log('ProductGroup=='+ProductGroup);
        actionPhone.setParams({
            "Country": countryText,
            "CountryHub" : CountryGroup,
            "Role" : roleText,
            "ProductGroup" : ProductGroup,
            "Language" : languageText
        }); 
        // Set the response data on the component attribute
        actionPhone.setCallback(this, function(a) {
            component.set("v.phoneDetails", a.getReturnValue());
          //  alert(a.getReturnValue());
        });
        // Add the server-side action to the queue of actions to be executed
        $A.enqueueAction(actionPhone);
             //======Code for Getting Phone Number Ends======
            
            
            
        }); 
        // Add the server-side action to the queue of actions to be executed
        $A.enqueueAction(actionGetButtonId);
        
        $('#ChannelMsg').hide(); //Defect 4514
        helper.HideShowDivs(event);
        
        
    },
    
    createCase : function(component, event,helper) {
        try {
        helper.HideShowDivs(event);
        var webFormType = document.getElementById("txtWebFormType").value;
        var subject = document.getElementById("subject").value;
        var firstName = document.getElementById("firstname").value;
        var lastName= document.getElementById("lastname").value;
        var contactEmail = document.getElementById("email").value;
        var username=document.getElementById("Username").value;
        var message=document.getElementById("Message").value;
        var rol =document.getElementById("Rol");
        var role= rol.options[rol.selectedIndex].text; 
        var roleval = document.getElementById("Rol").value
        var existingCase = ''; //document.getElementById("Existingcase").value; //Commented as per the mail from Eric on 12/18
        var phone= document.getElementById("phone").value;
        var pearsonAccessNextUsername=document.getElementById("pearsonaccess").value;
        var program= document.getElementById("program").value;
        var district= document.getElementById("District").value;
        var school= document.getElementById("School").value;
        var category= document.getElementById("Cat").value;
        var language= document.getElementById("Language").value;
        
        var cntry= document.getElementById("Country");
        var country= cntry.options[cntry.selectedIndex].text; 
        var countryval = document.getElementById("Country").value;
        var city= document.getElementById("City").value;
        var state= document.getElementById("State").value;
        // Passing record Type as Technical support for cases created by Service
        
        
        //Defect - 4494 - Setting Record Type for Refunds.
        var refundsLabel = component.get("v.refundValue");
         if(category == refundsLabel)
                {
                    webFormType = "CS";
                }
        
        if(webFormType == "CS")
        {
            var recordType_Case='Customer_Service';
        }
        else
        {
            var recordType_Case='Technical_Support';
        }
        var recordType_Contact='Global_Contact';
        /* New Changes for refunds*/
        var organization = document.getElementById("organization").value;
        var topic = document.getElementById("Cat").value;
        var orderId = document.getElementById("orderId").value;
        var product = document.getElementById("Product").value;
        var currencyOfPurchase = '';
        var reason = '';
        if(document.getElementById("CurrencyofPurchase").value){		
            currencyOfPurchase = document.getElementById("CurrencyofPurchase").value; 
        }
        else 
            currencyOfPurchase = '';
        if(document.getElementById("Reason").value){		
            reason = document.getElementById("Reason").value; 
        }
        else 
            reason = '';
        var userEstimatedContacts = 0;
        var userFirstName = '';
        var userLastName = '';
        var email = ''; //As part of support to support form user email need to be sent.
        var termAffectedCourse = '';
        var affectedCourseName = '';
        var courseId = document.getElementById("CourseID").value;
        var timeOfContact = '';
        var detailedDescription = '';
        var errorMessage = '';
        var replicatePath = '';
        var operatingSystem = '';
        var configuration = '';
        var troubleshooting = '';
        var anyInfo = '';
        /*Attachment parameters*/
        var fileName = '';
        var base64Data = '';
        var contentType = '';
        var caseOriginVal = 'None';
        if (component.get("v.caseSourceType") == "FromPhone") {
            caseOriginVal = 'FromPhone';                        
        }
        var SupportPhoneNumber = component.get("v.phoneDetails"); 
        /*Attachment parameters end*/
        var details = [firstName,lastName,contactEmail,userEstimatedContacts,userFirstName,userLastName,email,username,termAffectedCourse,affectedCourseName,courseId,timeOfContact,detailedDescription,errorMessage,replicatePath,operatingSystem,configuration,troubleshooting,anyInfo,existingCase,phone,pearsonAccessNextUsername,program,district,school,category,language,country,city,state,organization,topic,orderId,currencyOfPurchase,reason,message,role,recordType_Case,recordType_Contact,subject,fileName,base64Data,contentType,product,caseOriginVal,SupportPhoneNumber];
        console.log("detailsList=="+details.length);
            //========Validation Code Starts =============
        var ValidationArray = [];
        ValidationArray[0] = ["First Name",$.trim(firstName), "TextBox", "Alpha" ];
        ValidationArray[1] = ["Last Name",$.trim(lastName), "TextBox", "Alpha" ];       
        ValidationArray[2] = ["Email",$.trim(contactEmail), "Email" , "AlphaNumeric"];       
        ValidationArray[3] = ["Phone",$.trim(phone), "TextBox","PhoneVal" ];       
        ValidationArray[5] = ["Role",$.trim(roleval), "DropDown" ,"DropDown"]; 
        ValidationArray[7] = ["Category",$.trim(category), "DropDown","DropDown" ];   
        ValidationArray[8] = ["Language",$.trim(language), "DropDown","DropDown" ]; 
        ValidationArray[9] = ["Country",$.trim(countryval), "DropDown","DropDown" ];  
        ValidationArray[11] = ["Product",$.trim(product), "DropDown","DropDown" ];
        ValidationArray[15] = ["Message",$.trim(message), "TextBox", "AlphaNumeric" ];       
        if(webFormType == "TS") 
        {
            //ValidationArray[4] = ["Organization",$.trim(organization), "TextBox" , "AlphaNumeric"];
            
            ValidationArray[4] = ["Topic",$.trim(subject), "TextBox" , "AlphaNumeric"];
            ValidationArray[6] = ["",'', "" ,""];
            //ValidationArray[8] = ["",'', "", "" ];
            ValidationArray[10] = ["Organization",$.trim(organization), "TextBox" , "AlphaNumeric"]; //Defect 5208
            ValidationArray[12] = ["",'', "" , ""];
            ValidationArray[13] = ["",'', "" , ""];//Defect 4510 //ValidationArray[12] = ["CourseId",$.trim(courseId), "TextBox" , "AlphaNumeric"];
            ValidationArray[14] = ["",'', "" ,""]; //Defect 4510
        }
        if(webFormType == "CS") 
        {
            ValidationArray[4] = ["",'', "" ,""];
            ValidationArray[6] = ["School",$.trim(school), "TextBox", "AlphaNumeric"];
           //ValidationArray[8] = ["",'', "", "" ];//Defect 4503//ValidationArray[8] = ["Order Id",$.trim(orderId), "TextBox", "AlphaNumeric" ];
           ValidationArray[10] = ["",'', "" ,""]; //Defect 5208
            ValidationArray[12] = ["Currency Of Purchase",$.trim(currencyOfPurchase), "DropDown" ,"DropDown"];
            ValidationArray[13] = ["",'', "" ,""];
			ValidationArray[14] = ["Refund Reason",$.trim(reason), "TextBox", "AlphaNumeric" ]; //Defect 4510
        
        }
        var ValidationMsg = helper.Validation(ValidationArray);
        if(ValidationMsg != "0")
        {
            $('#CaseValidationMessage').show();
            $('#CaseValidationMessage').html (ValidationMsg);
            return false;
        }
        else
        {
             if(document.getElementById("Terms").checked == false)
            {
             	$('#CaseValidationMessage').show();
                $('#CaseValidationMessage').html ("Please select the checkbox for Terms and Conditions");
                return false;
            }
            else
            {
            $('#CaseValidationMessage').hide();
            }
        }
        // captcha function for compare inputs
        var stringCaptcha = helper.removeSpaces(document.getElementById('Captcha').value);
         var stringInput = document.getElementById('txtInput').value;
         if (stringCaptcha == stringInput){
              $('#CaseValidationMessage').hide();
            }
        else
        {
             helper.Captcha(event);
             $('#CaseValidationMessage').show();
             $('#CaseValidationMessage').html("Please Enter a Valid Captcha");
             $('#txtInput').val('');
             return false;
        }
        //==========Validation Code Ends =============
        var actionGetCaseDetails=component.get("c.getCase");
        actionGetCaseDetails.setParams({
            "details": JSON.stringify(details)
        }); 
        actionGetCaseDetails.setCallback(this, function(a) {
            component.set("v.casenumber", a.getReturnValue());
            if (component.get("v.caseSourceType") == "FromPhone") {
        		$('#displayPhone').show();
        		$('#displayPhoneHeading').show();
                $('#SuccessLabel').hide();
        	}
        });        
        $A.enqueueAction(actionGetCaseDetails);
        component.set("v.showSpinner", true);
        $('#SuccessLabel').hide();
        $('#WaitingMsg').show();
        $('#progressBar').show();
        $('#innerprogressBar').show();
        $('#CaseCreationMsg').show();
        
        var percent = 0;
        var progressBarWidth = 0; 
        
        for(var i= 0 ; i<5 ; i++)
        {
            setTimeout(function(){
                percent = percent+ 20;
                //progressBarWidth = percent * $('#progressBar').width() / 100;
                //$('#innerprogressBar').animate({ width: progressBarWidth }, 500).html(percent + "% "); 
                if(percent == 100)
                {	
                    if (component.get("v.caseSourceType") != "FromPhone") {
						$('#SuccessLabel').show();                        
                    }
                    $('#WaitingMsg').hide();
                    component.set("v.showSpinner", false);
                    /*$('#progressBar').hide();
                    $('#innerprogressBar').hide();*/
                }
            },(i)*1500);
        } 
        $('#webToCaseFormHeading').hide();
        $('#webToCaseForm').hide(); 
        $('#txtInput').val('');
        } catch(e){alert(e);}
    },

    // Get phone,country and role mapping details on the component page 
    getPhone : function(component,event,helper) {
        try {
        component.set("v.caseSourceType", "FromPhone");
        component.set("v.tabCustomMessage", "Give Us A Call");
        var precallMess = component.find('preCallMessage');
        $A.util.removeClass(precallMess, 'hideElementClass');
        if (component.get("v.userIsAuthUser")) {
            component.set("v.preCallFormReadOnly", "v.userIsAuthUser");
            $('.readOnlyItem').css('background-color', 'grey');
        }
        helper.HideShowDivs(event);
        helper.Captcha(event);
        helper.updateBasicDetailsToSupportForm(event);
        var textField = component.find("searchTitle");
        var searchTitle = textField.get("v.value");
        document.getElementById("subject").value = searchTitle;
        $('#Row_CG_19').hide();
        $('#Row_CS_15').hide();
        $('#Row_CS_16').hide();
        $('#Row_CS_8').hide();
        $('#Row_CS_17').hide();
        /*$('#Row_CS-CG_7').hide();
        $('#Row_CS-CG_9').hide();
        $('#Row_CS-CG_10').hide();
        $('#Row_CS-CG_18').hide();
        $('#Row_CS-CG_11').hide();*/
        } catch (e) {console.log('getPhone Error='+e)}
    },
    // For creating case  
    createCaseForm : function(component,event, helper){
        var precallMess = component.find('preCallMessage');
        $A.util.addClass(precallMess, 'hideElementClass');
        component.set("v.caseSourceType", "FromSendUsAMessage");
        component.set("v.tabCustomMessage", "Send Us A Message");
        component.set("v.preCallFormReadOnly", false);
        $('.readOnlyItem').css('background-color', 'white');
        //document.getElementById("terms").disabled = true; 
        document.getElementById("Terms").checked = false;
        helper.Captcha(event);
        var webFormType = document.getElementById("txtWebFormType").value;
        var ctgry_id = document.getElementById("categorySelected");    
        var categoryText= ctgry_id.options[ctgry_id.selectedIndex].text;
        var refundsLabel = component.get("v.refundValue");
        
        
         if(categoryText == refundsLabel)
                {
                    webFormType = "CS";
                }
        $( "div" ).each(function(i) {
            if(webFormType == "TS")
            {
                $('#Row_CG_'+i).show();
                $('#Row_CS_'+i).hide();
            }
            if(webFormType == "CS")
            {
                $('#Row_CG_'+i).hide();
                $('#Row_CS_'+i).show();
                
            }
        });
        helper.HideShowDivs(event);
        var selectedCategory=document.getElementById("categorySelected");
        var  categoryoption= selectedCategory.options[selectedCategory.selectedIndex].text;
        $("#Cat").val(categoryoption);
      
        var selectedLanguage=document.getElementById("languageSelected");
        var  languageoption= selectedLanguage.options[selectedLanguage.selectedIndex].text;
        $("#Language").val(languageoption);
        
        var selectedRole=document.getElementById("roleSelected");
        var  roleoption= selectedRole.options[selectedRole.selectedIndex].value;
        $("#Rol").val(roleoption);
        
        var selectedCountry=document.getElementById("countrySelected");
        var  countryoption= selectedCountry.options[selectedCountry.selectedIndex].value;
        $("#Country").val(countryoption);
        
        var selectedProduct=document.getElementById("productSelected");
        var  productoption= selectedProduct.options[selectedProduct.selectedIndex].value;
        $("#Product").val(productoption);
        
        var textField = component.find("searchTitle");
        var searchTitle = textField.get("v.value");
        document.getElementById("subject").value = searchTitle;
    },
    refreshCaptcha : function(component, event, helper)
    {
      helper.Captcha(event);   
    },
    preChat: function(component,event,helper){  
        console.log('inside prechat');  
        var role = document.getElementById("roleSelected").value; 
       
        var country = document.getElementById("countrySelected").value; 
        var category = document.getElementById("categorySelected").value;
        var lang = document.getElementById("languageSelected").value
        var textField = component.find("searchTitle");
        var searchTitle = textField.get("v.value");
        var parenturl=window.parent.location;
        var role=document.getElementById("roleSelected");
        var  roleoption= role.options[role.selectedIndex].text;
        var country=document.getElementById("countrySelected");
        var  countryoption= country.options[country.selectedIndex].text;
        var product=document.getElementById("productSelected").value;
        //var product = prd1.options[prd1.selectedIndex].text;        
        console.log(' product**'+product);
        console.log(' role**'+roleoption);
        console.log(' country**'+country);
        console.log(' Category**'+category);
        console.log(' Subject**'+searchTitle);
        console.log(' parenturl**'+parenturl);
        console.log(' Language**'+lang);      
        //console.log('liveagent call is success');
        //console.log('liveagent After Sucess');
        //var tmp=component.get("v.preChatButtonId.Button_id__c")
        //console.log('parsing attribute'+tmp);
        var buttonid=component.get("v.sChatDetails[0]");
        //console.log('Calling OrgId');
        var orgid=component.get("v.OrganizationID");
        console.log('OrgId**'+orgid);
        var deploymentid=component.get("v.sChatDetails[1]");
        var recordtypeid=component.get("v.sChatDetails[2]");
        //console.log(component.get("v.sChatDetails[0]"));
        console.log('Button id    **:'+buttonid);
        console.log('Deployment id**:'+deploymentid);
        console.log('Recordtype id**:'+recordtypeid);
        var online=component.get("v.agentMessages[0]");
        var offline=component.get("v.agentMessages[1]");
        var fn='';        
        var ln='';
        var el='';
        var ph='';
		var sURL='/getsupport/resource/PreChatLiveAgentNew_1523?pbtnId='+buttonid+'&pRTId='+recordtypeid+'&pdpId='+deploymentid+
                     '&pCtry='+countryoption+'&prole='+roleoption+'&pcat='+category+'&psub='+searchTitle+
                     '&pprod='+product+'&plang='+lang+'&porgId='+orgid+'&pOnline='+online+'&pOffline='+offline;        
        if(component.get("v.runningUser.FirstName")!=null)
            sURL=sURL+'&pfn='+component.get("v.runningUser.FirstName");        
        if(component.get("v.runningUser.LastName")!=null)
            sURL=sURL+'&pln='+component.get("v.runningUser.LastName");
        if(component.get("v.runningUser.Email")!=null)
            sURL=sURL+'&pel='+component.get("v.runningUser.Email");
        if(component.get("v.runningUser.Phone")!=null)
            sURL=sURL+'&pph='+component.get("v.runningUser.Phone");
        //console.log('Loggedinuser FirstName:'+el);
        window.open(sURL);
        /*window.open('/getsupport/resource/PreChatLiveAgentNew_1523?pbtnId='+buttonid+'&pRTId='+recordtypeid+'&pdpId='+deploymentid+
                     '&pCtry='+countryoption+'&prole='+roleoption+'&pcat='+category+'&psub='+searchTitle+
                     '&pprod='+product+'&plang='+lang+'&porgId='+orgid+'&pOnline='+online+'&pOffline='+offline+
                   	 '&pfn='+fn+'&pln='+ln+'&pel='+el+'&pph='+ph);*/
    },
    // For getting the notification after submit click for case creation
    showHide : function () {
        alert("A new case has been created, Pearson support would get back to you as soon as possible.")
        document.getElementById('SuccessLabel').style.display = "block";
    },
    //calling the helper method
    HideShowDivs_Controller : function(component,event,helper)  {
        //Defect 4514 - Starts
        //$('#clickMethod').hide();
        var ctgry = document.getElementById("categorySelected");    
        var categorySelected= ctgry.options[ctgry.selectedIndex].text;   
        var refundsLabel = component.get("v.refundValue");
          if(categorySelected == refundsLabel)
        {
            $('#RefundsMessage').show();
        }
        else
        {
            $('#RefundsMessage').hide();
        }
        $('#ChannelMsg').show();  //Defect 4514 - Ends
        
        helper.HideShowDivs(event);
        
       
    },
    activateButton : function(component,event,helper) {
        if($('#Terms').attr('checked') == false)
           {
                    $('#terms').attr("disabled","disabled");   
           } 
        else 
           {
                     $('#terms').removeAttr('disabled');
           }
   },
    InfoDropDownChange : function(component,event,helper)  {
        var con=document.getElementById("countrySelected");
        var  countryoption= con.options[con.selectedIndex].text;

        //=== language dependency code starts here ===//
        //set the langauge depend on country
        var countryList = component.get("v.listAllData");
        var flag = 0;
        var strLanguage;
        var arrLanguage = [];
        $.each(countryList, function(i, value)
         { 
             if(flag == 0)
             {
                 if(countryoption == countryList [i].Country__c)
                 {
                    	flag==1;
                     	strLanguage = countryList [i].Language__c ;
                 }
             }
         });
        arrLanguage = strLanguage.split(",");
            $("#languageSelected").empty();
            $("#Language").empty();
            var newOption = "<option value=0>Select a Language</option>"; 
			$("#languageSelected").append(newOption);
            $("#Language").append(newOption);
            $.each(arrLanguage, function(i, value)
         { 
            var newOption = "<option value='"+ arrLanguage[i] +"'> " + arrLanguage[i] +"</option>"; 
			$("#languageSelected").append(newOption);
            $("#Language").append(newOption);
         });
        //=== language dependency code ends here ===//
        
   },
    // calling this function on category drop down change
     categoryDropDownChange : function(component,event,helper){
        var refundsLabel = component.get("v.refundValue");
        helper.helperInfoDropDownChange(refundsLabel);
   },
    
    openTerms : function (component,event,helper) {
    	window.open('terms-of-use');  
    },
    
    openPrivacyPolicy : function (component,event,helper) {
    	window.open('privacy');  
    },
    })