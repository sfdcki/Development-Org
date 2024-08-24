({
	init : function(component, event, helper) {
        component.set("v.columns",[{label:'Name',type:'text',fieldName:'Name'},
                                   {label:'Email',type:'Email',fieldName:'Email'},
                                   {label:'Phone',type:'Phone',fieldName:'Phone'},
                                   {label:'Lead Source',type:'text',fieldName:'LeadSource'}
                                  ]);
        var action = component.get("c.getContacts");
        action.setParams({
            accId : component.get("v.recordId")
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.data",response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
	}
})