({
	loadscript : function(component, event, helper) {
		
	 $A.get("e.force:navigateToURL").setParams(
        {"url": "/apex/customcustomer"}).fire();
    },

   
})