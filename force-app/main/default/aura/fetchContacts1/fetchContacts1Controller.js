({
	updateSelectedText : function(component, event, helper) {
		var rowCount = event.getParam("selectedRows");
        component.set("v.selectedRowsCount",rowCount.length);
	},
    init : function(component, event, helper) {
    component.set("v.columns",[{label:'Name',fieldName:'Name',type:'text'},
 								{label:'Phone',fieldName:'Phone',type:'Phone'},
 								{label:'Email',fieldName:'Email',type:'Email'},
                               {label:'Lead Source',fieldName:'LeadSource',type:'text'},
                               {label:'Imp Contact',fieldName:'Valid_Contact__c',cellAttribute:{'class':{"fieldName": "showClass"},'iconName':{"fieldName": "displayIconName"}}}
 ]);
        var action = component.get("c.getContacts");
        action.setParams({
            accId : component.get("v.recordId")
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var records = response.getReturnValue();
                records.forEach(function(record){
                    if(record.Valid_Contact__c)
                    {
                        record.showClass = (record.Valid_Contact__c === true) ? 'redcolor' : 'blackcolor';
                        record.displayIconName = 'utility:check';
                    }
                    else
                    {
                        record.showClass = (record.Valid_Contact__c === false) ? 'blackcolor' : 'redcolor';
                        record.displayIconName = 'utility:close';
                    }
                    
                });
                component.set("v.data",response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
	}
})