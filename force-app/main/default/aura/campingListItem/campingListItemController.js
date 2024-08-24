({
	packItem : function(component, event, helper) {
		var btnClick = event.getSource();
        btnClick.set("v.disabled",true);
        var a = component.get("v.item",true);
        a.Packed__c = true;
        component.set("v.item",a);
	}
})