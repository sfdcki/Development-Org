({
	searchHelper : function(component,event,getInputkeyWord) {
	  // call the apex class method 
     var action = component.get("c.fetchLookUpValues");
      // set param to method  
        action.setParams({
            'searchKeyWord': getInputkeyWord,
            'ObjectName' : component.get("v.objectAPIName")
          });
      // set a callBack    
        action.setCallback(this, function(response) {
          $A.util.removeClass(component.find("mySpinner"), "slds-show");
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
              // if storeResponse size is equal 0 ,display No Result Found... message on screen.                }
                if (storeResponse.length == 0) {
                    component.set("v.Message", 'No Result Found...');
                } else {
                    component.set("v.Message", '');
                }
                // set searchResult list with return value from server.
                component.set("v.listOfSearchRecords", storeResponse);
            }
 
        });
      // enqueue the Action  
        $A.enqueueAction(action);
    
	},
    commitData : function(component,event,helper) {
        component.set("v.position.Name",component.get("v.positionname"));
        /* var mandatoryFieldsList = component.find("testform");
        
        if(mandatoryFieldsList.length!=undefined && mandatoryFieldsList.length > 0){
            var allValid =mandatoryFieldsList.reduce(function (validSoFar, inputCmp) {
                inputCmp.showHelpMessageIfInvalid();
                return validSoFar && !inputCmp.get('v.validity').valueMissing;
            }, true);
            
            if(component.get("v.lookupvalue")==true){
                
                if (allValid) {
         component.set("v.position",{ 'sobjectType': 'Position__c',
                                                'Name': component.get("v.positionname"),
                                                'Closing_Date__c': component.get("v.closedate"),
                                                'Opening_Date__c': component.get("v.opendate"),
                                                'Hiring_Position__c': component.get("v.managerid"),
                                                'TestMulti__c': component.get("v.testmulti"),
                                                'Position_Status__c': component.get("v.status"),
                                                'States_Account__c': component.get("v.statename"),
                                                'Description__c': component.get("v.description") });
                    var validRecords = component.get("v.position"); 
                    
                    console.log("validRecords", JSON.stringify(validRecords));
                    
        
                }        
            }else{
                var err = component.find("errMsg");    
                $A.util.removeClass(err, 'slds-hide');
                $A.util.addClass(err, 'slds-show');
            }
            
        }*/
         
                    //var hirRec = component.get("v.selRecId");
               /*     var pos = component.get("v.position");
                    var action = component.get("c.insertData");
                    // set param to method  
                    action.setParams({
                        'posit' : pos
                    });
                    // set a callBack    
                    action.setCallback(this, function(response) {
                        var state = response.getState();
                        if (state === "SUCCESS") {
                            
                        }
                    });
                    $A.enqueueAction(action);*/
    },
})