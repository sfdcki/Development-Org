({
	clickAdd : function(component, event, helper) {
		var number1 = component.find("num1").get("v.value");
        var number2 = component.find("num2").get("v.value");
        
        var total = number1 + number2;
        
        var resulToast = $A.get("e.force:showToast");
        resulToast.setParams({
            "title": "Addition of 2 numbers",
            "message": "Total is" + total + "."
        });
        resulToast.fire();
        
        var closeQuickAction = $A.get("e.force:closeQuickAction");
        closeQuickAction.fire();
	}
})