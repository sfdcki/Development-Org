({
    // creating the Capcha for contact support form
    Captcha : function(component,event,helper)
    {
        var alpha = new Array('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z');
        var i;
        for (i=0;i<4;i++){
            var a = alpha[Math.floor(Math.random() * alpha.length)];
            var b = alpha[Math.floor(Math.random() * alpha.length)];
            var c = alpha[Math.floor(Math.random() * alpha.length)];
            var d = alpha[Math.floor(Math.random() * alpha.length)];
        }
        var code = a+b+c+d ;
        $("#Captcha").val(code);
    },
    
    /// Helper Class to Replicate the Values for Phone Number as Well
    updateBasicDetailsToSupportForm : function(component,event,helper)
    {
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
    },
    //function for removing space between 2 text values
    removeSpaces :function(string) { 
        return string.split(' ').join('');
    } ,
    
       // helper method for InfoDropDownChange
    helperInfoDropDownChange : function(refundsLabel){
   
        var con=document.getElementById("countrySelected");
        var  countryoption= con.options[con.selectedIndex].text;
        var cat=document.getElementById("categorySelected");
        var  categoryoption= cat.options[cat.selectedIndex].text;
        var role=document.getElementById("roleSelected");
        var  roleoption= role.options[role.selectedIndex].value;
        var CS_Cntry = document.getElementById("txtCountry_CntryCat_Map_PrdRole").value;
        var CS_Cat = document.getElementById("txtCategory_CntryCat_Map_PrdRole").value;
        var CS_Role= document.getElementById("txtRole_CntryCat_Map_PrdRole").value;
        
          //  if(countryoption == CS_Cntry&& categoryoption == CS_Cat) //==Defect 4494 - Role to be disabled for all countries if Categpory = Refunds
        
        //alert(categoryoption)  ;
        //alert(refundsLabel);
        if(categoryoption == refundsLabel)
        {
            $("#roleSelected").val(CS_Role);
            $("#Rol").val(CS_Role);
            $("#roleSelected").prop('disabled', 'disabled');
            $("#Rol").prop('disabled', 'disabled');
            $("#roleSelected").css('background-color','grey');
            $("#Rol").css('background-color','grey');
        }
        else
        {
            $("#roleSelected").val("0");
            $("#Rol").val("0");
            $("#roleSelected").removeAttr('disabled');
           // $("#Rol").removeAttr('disabled');
            $("#roleSelected").css('background-color','white');
           // $("#Rol").css('background-color','white');
        }
    },
    
    // Section accessibility function
    HideShowDivs : function (event) {
        $('#CaseCreationMsg').hide();
        var selectedItem = event.currentTarget;
        var section_id = selectedItem.dataset.record;
        var SlideUpSpeed = 1000 ; 
        var SlideDownSpeed = 1000; 
        if(section_id == 'methodButton') //when click on the click here button on article details page
        {
            $('#methodButton').show();
            $('#clickMethod').hide();
           
        }
        if(section_id == 'kavSearch')  // when click on kavSearch
        {
            $('#kavSearch').slideDown(SlideUpSpeed);
            $('#articleDisplay').slideUp(SlideUpSpeed);
            $('#Section3').slideUp(SlideUpSpeed);
            $('#webToCaseForm').slideUp(SlideUpSpeed);
            $('#displayPhone').slideUp(SlideUpSpeed);    
        }
        if(section_id == 'articleDisplay')  // when click on articleDisplay
        {
            $('#articleDisplay').slideDown(SlideUpSpeed);
            $('#articleDisplayHeading').slideDown(SlideUpSpeed);
            $('#kavSearch').slideUp(SlideUpSpeed);
            $('#Section3').slideUp(SlideUpSpeed);
            $('#webToCaseForm').slideUp(SlideUpSpeed);
            $('#displayPhone').slideUp(SlideUpSpeed);
            $('#clickMethod').hide();
            $('#methodButton').show();
        }
        if(section_id == 'webToCaseForm')  // when click on webToCaseForm
        {
            $('#webToCaseForm').slideDown(SlideUpSpeed);
            $('#webToCaseFormHeading').slideDown(SlideUpSpeed);
            $('#displayPhone').slideUp(SlideUpSpeed);
            $('#displayPhoneHeading').slideUp(SlideUpSpeed); 
            $('#kavSearch').slideUp(SlideUpSpeed);
            $('#Section3').slideUp(SlideUpSpeed);
            $('#articleDisplay').slideUp(SlideUpSpeed);
        }
        if(section_id == 'displayPhone')   // when click on displayPhone
        {	
            //v.caseSourceType = 'FromPhone';
            //component.set("v.caseSourceType", 'FromPhone');
            $('#Mainmessage').hide();
            $('#webToCaseForm').slideDown(SlideUpSpeed);
            $('#webToCaseFormHeading').slideDown(SlideUpSpeed);
            //$('#displayPhone').slideDown(SlideUpSpeed);
            //$('#displayPhoneHeading').slideDown(SlideUpSpeed);
            $('#kavSearch').slideUp(SlideUpSpeed);
            $('#Section3').slideUp(SlideUpSpeed);
            $('#articleDisplay').slideUp(SlideUpSpeed);
            //$('#webToCaseForm').slideUp(SlideUpSpeed);
            //$('#webToCaseFormHeading').slideUp(SlideUpSpeed);
        } 
    },
  
    //========Validation Code Starts =============
    Validation: function(ValidationArray){
        var ValOutputMessage = "Please enter a value for all the mandatory fields.";
        //var ValOutputMessage = "Please enter a value for ";
        var ValOutputErrorMessage = "";
        var valErrorField = "";
        var errorFlag = 0
        $.each( ValidationArray, function( i, val ){
            
            if(val[2] == "TextBox")
            {
                if(typeof val[1] == "undefined")
                {
                    if(valErrorField == "")
                    {
                        valErrorField = val[0];
                    }
                    else
                    {
                        valErrorField = valErrorField +" , " +val[0];
                    }
                    errorFlag = 1;
                }
                else if(val[1] == "")
                {
                    if(valErrorField == "")
                    {
                        valErrorField = val[0];
                    }
                    else
                    {
                        valErrorField = valErrorField +" , " +val[0];
                    }
                    errorFlag = 1;
                }
                else if(val[3] == "Alpha")
                {
                     var name_pattern = new RegExp("^[\u00C0-\u00FF a-z  A-Z _ -]*$");
                     
                     if(name_pattern.test(val[1]) == false)
                        {
                            ValOutputErrorMessage = ValOutputErrorMessage  + val[0] + " can only contain letters , hyphens or accented characters" + " <br />";
                            errorFlag = 1;
                        }
                 
                }
                else if(val[3] == "PhoneVal")
                {   
                    // Only numbers and 10 Digits Validation
                    var phone_REGEXP = /^[(]{0,1}[0-9]{3}[)][\.\- ]{0,1}[0-9]{3}[\.\- ]{0,1}[0-9]{4}$/;
                    
                    //US Phone Format
                    var phone_pattern = new RegExp("^[\+ {} 0-9 -]*$"); 
                    
					/// Number and Scpecial Charachters
					var numberAndSpecialCharREGEX = /^[ 0-9_@./#&+()-]*$/                    
                     //if(phone_REGEXP.test(val[1]) == false && (phone_pattern.test(val[1]) == false || val[1].length != 10))
                     if(!numberAndSpecialCharREGEX.test(val[1]))
                        {
                            //ValOutputErrorMessage = ValOutputErrorMessage  + val[0] + " can only contain numbers,(,) and - characters" + " <br />";
                            ValOutputErrorMessage = ValOutputErrorMessage  + val[0] + " can only contain numbers and scecial charachters" + " <br />";
                            errorFlag = 1;
                        }
                 
                }
                 else if(val[3] == "Numeric")
                    {//alert(parseInt(val[1], 10)
                    
                        //Defect 4661 - Implementation with special characters and 10 digits.
                        var phone_pattern = new RegExp("^[\+ {} 0-9 -]*$"); 
                        var replaceSpecialCharc = val[1].replace(/[\+\s{}-]|ext\.?/gi, "");
                       // alert(phone_pattern.test(val[1]));
                        //alert(replaceSpecialCharc.length);
                        
                        //alert(phone_pattern.test(val[1]) == false)  ; 
                        if(phone_pattern.test(val[1]) == false)
                        {
                            ValOutputErrorMessage = ValOutputErrorMessage + val[0] + " can only have following special characters { } - + and Numeric values" +" <br />";
                            errorFlag = 1;
                        }
                        else if(replaceSpecialCharc.length < 10)
                        {
                            ValOutputErrorMessage = ValOutputErrorMessage + " Please enter at least 10 digits in the " + val[0] + " Number field" +" <br />";
                            errorFlag = 1;
                        }
                       
                    }
            }
            if(val[2] == "DropDown")
            {
                if(val[1] == 0)
                {
                    if(valErrorField == "")
                    {
                        valErrorField = val[0];
                    }
                    else
                    {
                        valErrorField = valErrorField +" , " +val[0];
                    }
                    errorFlag = 1;
                }
            }
              if(val[2] == "Email")
            {
                //alert(val[2]);
                var pattern = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
                if(val[1] == "")
                {
                    if(valErrorField == "")
                    {
                        valErrorField = val[0];
                    }
                    else
                    {
                        valErrorField = valErrorField +" , " +val[0];
                    }
                    errorFlag = 1;
                }
                else if(pattern.test(val[1]) == false)
                {
                    ValOutputErrorMessage = ValOutputErrorMessage + "Invalid " + val[0]  + " <br />";
                    errorFlag = 1;
                }
            }
        });
        var finalErrorMsg = "0";

         if(errorFlag == 1)
        {
             if(valErrorField != "")
                {
                     finalErrorMsg = ValOutputErrorMessage+ " <br />" + ValOutputMessage + "<br />" + "  " + "<br />" ;
                     // finalErrorMsg = ValOutputErrorMessage+ " <br />" + ValOutputMessage + valErrorField + "<br />" + "  " + "<br />" ;
             } else {
                 finalErrorMsg = ValOutputErrorMessage+ " <br />" ;
                }
            
        }
      
        return finalErrorMsg;
    },
    //==========Validation Code Ends =============   
    
    getParameterByName : function(name, url) {
        
    if (!url) url = window.location.href;
    url = url.toLowerCase(); // This is just to avoid case sensitiveness 
        
    name = name.replace(/[\[\]]/g, "\\$&").toLowerCase();// This is just to avoid case sensitiveness for query parameter name
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
},
})