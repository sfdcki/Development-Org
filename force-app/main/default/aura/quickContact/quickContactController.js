({
	doInit : function(component, event, helper) {
        var accountId = component.get("v.recordId");
        var action = component.get("c.getAccount");
        action.setParams({
            "accId" : "accountId"
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.Account",	response.getReturnValue());
            }
            else
            {
                console.log("problem getting account"+state);
            }
        });
        $A.enqueueAction(action);
        
	},
    cancelWindow : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
        
	},
    saveContact : function(component, event, helper) {
        var result = helper.validateData(component);
        if(result){
        	var action = component.get("c.saveContactWithAccount");
            action.setParams({
                "cont":component.get("v.newContact"),   
                "accId":component.get("v.recordId")
            });
            action.setCallback(this,function(response){
                var state = response.getState();
                if(state === "SUCCESS"){
                    $A.get("e.force:closeQuickAction").fire();
                    var shwToast = $A.get("e.force:showToast");
    				shwToast.setParams({
            			"title":"Contact Saved",
            			"message":"New Contact has been created."
        				});
        			shwToast.fire();
                }
            });
            $A.enqueueAction(action);
    		
        }}
})