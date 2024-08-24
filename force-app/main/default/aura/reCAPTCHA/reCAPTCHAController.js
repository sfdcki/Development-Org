({
    doInit : function(component) {
        //var vfOrigin = "https://mylightninguday-dev-ed.my.salesforce.com";
        var vfOrigin = "https://mylightninguday-dev-ed--c.ap6.visual.force.com";
        window.addEventListener("message", function(event) {
            if (event.origin !== vfOrigin) {
                // Not the expected origin: Reject the message!
                return;
            }
            
            if(event.data.action == 'alohaCallingCAPTCHA' && event.data.alohaResponseCAPTCHA == 'NOK'){
            //if(event.data.action == 'alohaCallingCAPTCHA'){
                alert('Please do the captcha before submit!'+event.data.alohaResponseCAPTCHA);
            }
            else if(event.data.action == 'alohaCallingCAPTCHA' && event.data.alohaResponseCAPTCHA == 'OK'){
           // else if(event.data.action == 'alohaCallingCAPTCHA'){
               $('#captchid').hide();
                $('#subid').hide();
               // alert('validation passed'+event.data.alohaResponseCAPTCHA);
            }
        }, false);
    },

	submitSomething : function(component, event, helper) {
        var message = 'alohaCallingCAPTCHA';
       // var vfOrigin = "https://mylightninguday-dev-ed.my.salesforce.com";
       var vfOrigin = "https://mylightninguday-dev-ed--c.ap6.visual.force.com";
        var vfWindow = component.find("vfFrame").getElement().contentWindow;
        //alert(location.protocol + "//" + location.host);
		vfWindow.postMessage({ action: "alohaCallingCAPTCHA" },vfOrigin);
	},
    onBlur: function(component, event, helper) {
        var eventRequired = event.getSource().get('v.required');
        helper.checkValues(component, event);
    }
})