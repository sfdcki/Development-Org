({
	validateData : function(component) {
        var dataValid = component.find('contactField').reduce(function(validFields,inpComp){
            inpComp.showHelpMessageIfInvalid();
            return validFields && inpComp.get('v.validity').valid;
        },true);
        if(dataValid){
            return(true);
        }
	}
})