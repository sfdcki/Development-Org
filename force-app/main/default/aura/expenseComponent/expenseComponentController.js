({
	// Load expenses from Salesforce
    validateAge: function(component,event){
        var ageval = $("#age").val();
        alert(ageval);
        component.set("v.sum1",ageval);
    },
doInit: function(component, event, helper) {

    // Create the action
    var action = component.get("c.getExpenses");

    // Add callback behavior for when response is received
    action.setCallback(this, function(response) {
        var state = response.getState();
        if (component.isValid() && state === "SUCCESS") {
            component.set("v.expenses", response.getReturnValue());
        }
        else {
            console.log("Failed with state: " + state);
        }
    });

    // Send action off to be executed
    $A.enqueueAction(action);
},
    loadscript: function(component, event) {
        
		alert("script loaded");
    
},
    clickCreateExpense : function(component, event, helper) {
		// Simplistic error checking
        var validExpense = true;

        // Name must not be blank
        var nameField = component.find("expname");
        var expname = nameField.get("v.value");
        if ($A.util.isEmpty(expname)){
            validExpense = false;
            nameField.set("v.errors", [{message:"Expense name can't be blank."}]);
        }
        else {
            nameField.set("v.errors", null);
        }
      var amountField = component.find("amount");
        var amount = amountField.get("v.value");
        if ($A.util.isUndefinedOrNull(amount) || amount <= 0){
            validExpense = false;
            amountField.set("v.errors", [{message:"Expense amount can't be blank/zero."}]);
        }
        else {
            amountField.set("v.errors", null);
            var newExpense = component.get("v.newExpense");
        	console.log("create expense: " + JSON.stringify(newExpense));
        	helper.createExpense(component, newExpense);
        	component.set("v.newExpense", { 'sobjectType': 'Expense__c',
                                               'Name': '',
                                          'Amount__c': 0,
                                          'Client__c': '',
                                            'Date__c': '',
                                      'Reimbursed__c': false});
        }
    },
     handleUpdateExpense: function(component, event, helper) {
    var updatedExp = event.getParam("expense");
    helper.updateExpense(component, updatedExp);
}
})