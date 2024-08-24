({
	createVote : function(component, event, helper) {
		//alert($("#articleComments").val());
        //alert(component.get("v.subject"));
        var artnum = component.get("v.subject");
        //var updn = $("#voteUp").val();
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
        
        
     
    	var vte = $('input[name=vote]:checked').val();
  		 if (vte === "Yes")
        {
            var type = 'Up';
        } else if(vte === "No")
        {
            var type = 'Down';
        } 
            
        var action = component.get("c.createArticle");
         action.setParams({
            type: type,
            artId: artnum
        });
        action.setCallback(this, function(response) {
                var state = response.getState();
				 if (component.isValid() && state === "SUCCESS") {
                      var id = response.getReturnValue();
                      $("#articleComments").html(id);}
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
                }
            alert("Your vote already captured!");  }
        });
        $A.enqueueAction(action);  }
    })