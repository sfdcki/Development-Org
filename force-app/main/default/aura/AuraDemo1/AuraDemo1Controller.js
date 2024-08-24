({
    handleEvent : function(component, event, helper) {

        alert('Hello');
        var filters = '';
        filters = event.getParam('abc');
        component.set('v.message',filters);
    }
})