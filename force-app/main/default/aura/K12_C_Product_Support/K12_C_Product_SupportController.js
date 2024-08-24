({
                    loadscript : function(component, event, helper){
        //callint method from apex controller
        //alert("script loaded");
        helper.Captcha(event);
        var action = component.get("c.getProduct");
        action.setCallback(this, function(response) {
        var state = response.getState();
        if (component.isValid() && state === "SUCCESS") {
            component.set("v.product", response.getReturnValue());
        }
        else {
            console.log("Failed with state: " + state);
        }
    });
         $A.enqueueAction(action);
           
      //Product fetch
      var action1 = component.get("c.getRole");
        action1.setCallback(this, function(response) {
        var state = response.getState();
        if (component.isValid() && state === "SUCCESS") {
            component.set("v.role", response.getReturnValue());
        }
        else {
            console.log("Failed with state: " + state);
        }
    });
         $A.enqueueAction(action1);
               
         //Issue fetch
        var action2 = component.get("c.getIssue");
        action2.setCallback(this,function(response){
            var state = response.getState();
        if (component.isValid() && state === "SUCCESS") {
            component.set("v.issue", response.getReturnValue());
        }
        else {
            console.log("Failed with state: " + state);
        }
        });
        $A.enqueueAction(action2);  
            
        },
   
    supportaction : function(component, event, helper){
        var selectedrole = document.getElementById("roleSelected");
        var  roleoption = selectedrole.options[selectedrole.selectedIndex].value;
        if(roleoption === "System Administrator")
        {
            $("#admin").show();
            $("#student").hide();
            $("#pemp").hide();
        } else
        if(roleoption === "Student")
        {
            $("#admin").hide();
            $("#student").show();
            $("#pemp").hide();
        } else
        if(roleoption === "Pearson Employee")
        {
            $("#admin").hide();
            $("#student").hide();
            $("#pemp").show();
        } else {
            $("#admin").hide();
            $("#student").hide();
            $("#pemp").hide();
        }
    },
    validateProduct : function(component, event, helper){
        var selproduct = document.getElementById("productSelected");
        var prodVal = selproduct.options[selproduct.selectedIndex].value;
        if(prodVal === "Other")
        {
            $("#other").show();
        } else{
            $("#other").hide();
        }
    },
    movesecond : function(component, event, helper){
        $("#cperr").hide();
        var selectedproduct = document.getElementById("productSelected");
        var productindex = selectedproduct.selectedIndex;
        var productVal = selectedproduct.options[productindex].value;
        if(productVal === "Other")
        {
            var oprod = component.find("Oprod");
            var oprodVal = oprod.get("v.value");
            component.set("v.CProduct",oprodVal);    
        } else
        {
            component.set("v.CProduct",productVal);    
        }
      
       
        var selectedrole = document.getElementById("roleSelected");
        var roleindex = selectedrole.selectedIndex;
       var roleVal = selectedrole.options[roleindex].value;
       component.set("v.CRole",roleVal);
      
        if(productindex === 0)
        {
            $("#Perr").show();
            $("#Rerr").hide();
        } else if (roleindex === 0)
        {
            $("#Perr").hide();
            $("#Rerr").show();
        }
        else {
            $("#first").hide();
                $("#second").show();
            $("#third").hide();
            $("#fourth").hide();
            $("#Perr").hide();
            $("#Rerr").hide();
        }
    },
    movefirst : function(component, event, helper){
        $("#first").show();
        $("#second").hide();
        $("#third").hide();
        $("#fourth").hide();
    },
    movethird : function(component, event, helper){
        var FName =  component.find("FName");
        var FNameVal = FName.get("v.value");
        var LName =  component.find("LName");
        var LNameVal = LName.get("v.value");
        var fullName = FNameVal + ' ' + LNameVal;
        component.set("v.CName",fullName);
        var Email =  component.find("cemail");
        var EmailVal = Email.get("v.value");
        component.set("v.CEmail",EmailVal);
        var cnum = component.find("cphone");
        var cnumVal = cnum.get("v.value");
        component.set("v.CPhone",cnumVal);
        var dist = component.find("doname");
        var distVal = dist.get("v.value");
        component.set("v.CDOnm",distVal);
        var zcd = component.find("zcode");
        var zcdVal = zcd.get("v.value");
        component.set("v.Czip",zcdVal);
                FName.set("v.errors", null);
            LName.set("v.errors", null);
            Email.set("v.errors", null);
            cnum.set("v.errors", null);
            dist.set("v.errors", null);
                zcd.set("v.errors", null);
       
        if ($A.util.isEmpty(FNameVal)){
            FName.set("v.errors", [{message:"This field is required. Please enter a value."}]);
        } else if ($A.util.isEmpty(LNameVal)){
            LName.set("v.errors", [{message:"This field is required. Please enter a value."}]);
        } else if ($A.util.isEmpty(EmailVal)){
                                Email.set("v.errors", [{message:"This field is required. Please enter a value."}]);
        } else if($A.util.isUndefinedOrNull(cnumVal) || cnumVal <= 0) {
            cnum.set("v.errors", [{message:"This field is required. Please enter a value."}]);
        } else if ($A.util.isEmpty(distVal)){
            dist.set("v.errors", [{message:"This field is required. Please enter a value."}]);
        } else if ($A.util.isUndefinedOrNull(zcdVal) || zcdVal <= 0){
            zcd.set("v.errors", [{message:"This field is required. Please enter a value."}]);
        } else if (!$A.util.isEmpty(EmailVal)){
            
                var atpos = EmailVal.indexOf("@");
                                var dotpos = EmailVal.lastIndexOf(".");
                if (atpos<1 || dotpos<atpos+2 || dotpos+2>=EmailVal.length){
                    Email.set("v.errors", [{message:"Please enter the valid email."}]);}
                else{
                    FName.set("v.errors", null);
                    LName.set("v.errors", null);
                    Email.set("v.errors", null);
                    cnum.set("v.errors", null);
                    dist.set("v.errors", null);
                    zcd.set("v.errors", null);
                    $("#first").hide();
                    $("#second").hide();
                    $("#third").show();
                    $("#fourth").hide();
                }
        }       
    },
    movefourth : function(component, event, helper){
        var selectedissue = document.getElementById("issueSelected");
        var issueindex = selectedissue.selectedIndex;
        var issueVal = selectedissue.options[issueindex].value;
        component.set("v.CAOI",issueVal);
        var ecnum = component.find("ecase");
        var ecnumVal = ecnum.get("v.value");
        component.set("v.Ccse",ecnumVal);
                var descVal = $("#idesc").val();
        component.set("v.CIsue",descVal);
        var retcode = helper.evalCaptcha(component);
        if(issueindex === 0){
            $("#Ierr").show();
        } else if(descVal === "") {
            $("#derr").show();
        } else if(retcode === 0){
            $("#cperr").show();
        }
        else {
            $("#cperr").hide();
                $("#derr").hide();
            $("#Ierr").hide();
            $("#first").hide();
            $("#second").hide();
            $("#third").hide();
            $("#fourth").show();  
        }
    },
    casesave : function(component, event, helper){
        $("#final").hide();
        var action = component.get("c.dataCase");
         action.setParams({
            email: component.get("v.CEmail"),
            subject: component.get("v.CAOI"),
            description: component.get("v.CIsue")
        });
        action.setCallback(this, function(response) {
                var state = response.getState();
            var parentId = response.getReturnValue();
            //alert(parentId);
            component.set('v.CaseId',parentId);
                if (component.isValid() && state === "SUCCESS") {
                                //var valid = document.getElementById("file").value;                 
                //alert(valid+'hi');   
                    if($("#file").val() !== '')
                      {
                        var MAX_FILE_SIZE =  4500000;
                        var fileInput = component.find("file").getElement();
                        var file = fileInput.files[0];
      
                        if (file.size > MAX_FILE_SIZE) {
                                alert('file size exceeded maximum' + MAX_FILE_SIZE);
                                return;
                            } else {
                                    //alert('calling attachment method');
                                    helper.save(component);
                                    //window.location.reload();
                        }
                      } else {
                          window.location.reload();
                      }              
            //component.set("v.product", response.getReturnValue());
         
            //$("#first").show();
            //$("#second").hide();
            //$("#third").hide();
            //$("#fourth").hide();
            //$A.get('e.force:refreshView').fire();
            
        }
        else {
            console.log("Failed with state: " + state);
            //alert(state);
        }
    });
       $A.enqueueAction(action);  
    },
    refreshCaptcha : function(component, event, helper)
    {
      helper.Captcha(event);  
    },
 
  /* save : function(component, event, helper){
       var MAX_FILE_SIZE =  4500000;
       var fileInput = component.find("file").getElement();
       var file = fileInput.files[0];
  
        if (file.size < MAX_FILE_SIZE) {
            alert(file.size +'able to upload');
                    return;
        } else {
            alert(file.size +'not able to upload');
            return;
        }
       
    }, */
    })