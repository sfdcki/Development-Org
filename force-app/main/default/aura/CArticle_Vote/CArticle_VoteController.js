({
	createVote : function(component, event, helper) {
        var artnum = component.get("v.subject");
        //var artnum = 'ka028000000UpfwAAC';
        var arturl = component.get("v.URL");
        //var arturl = 'dummy article';
        var comm = $("#articleComments").val();
        if(comm.length > 255){
            alert('comment supports 255 characters only');
        }
      
        /*var updn = document.getElementById('voteUp').checked;
        //$("#articleComments").html(component.get("v.subject"));
        //alert(updn);
        if (updn == true)
        {
            var type = 'Up';
        } else
        {
            var type = 'Down';
        } */
        
        
     
    /*	var vte = $('input[name=vote]:checked').val();
  		 if (vte === "Yes")
        {
            var type = 1;
        } else if(vte === "No")
        {
            var type = -1;
        } */
        if($("#like").hasClass('selected'))
        {
            var type = 1;
        } else if($("#dlike").hasClass('dselected'))
        {
            var type = -1;
        }
        else
        {
            alert("select your vote like or dislike");
        }
        var action = component.get("c.createArticle");
         action.setParams({
            type: type,
            artId: artnum,
            name: arturl,
            comment: comm
        });
        
        action.setCallback(this, function(response) {
                var state = response.getState();
				 if (component.isValid() && state === "SUCCESS") {
                     var id = response.getReturnValue();}
                 //window.location.reload();}
            else if(state === "INCOMPLETE"){
                alert("INCOMPLETE");
            } else {
                
                alert(state);
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                        alert('HI'+errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                   // window.location.reload();
                }
           // window.location.reload();

           }
                       $("#dlike").removeClass('dselected');
           $("#like").removeClass('selected');
                $("#articleComments").val('');
        });
        if(type != ''){
        	$A.enqueueAction(action);   
        }
         },  
    setlike : function(component, event, helper) {
        $("#like").addClass('selected');
        $("#dlike").removeClass('dselected');
    },
        setdlike : function(component, event, helper) {
        $("#dlike").addClass('dselected');
        $("#like").removeClass('selected');
    }
    })