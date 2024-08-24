({
    processEvent : function(component, event, helper) {
        var eventText = event.getParam('value');
        component.set('v.txtFromEvent',eventText);
    }
})