({
    doInit : function(component,event,helper){
        var err = component.find("errMsg");
        $A.util.addClass(err, 'slds-hide');
        var fields = component.get("v.pickListFields");
        
        var action = component.get("c.fetchPicklistValues");
        // set param to method  
        action.setParams({
            'ObjectName' : component.get("v.objectName"),
            'fieldNames' : fields
        });
        // set a callBack    
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                
                component.set('v.pickListValues',response.getReturnValue());
                var map = component.get('v.pickListValues');
                for(var i =0; i<fields.length;i++)
                {
                    
                    if(fields[i] === "States_Account__c"){
                        component.set('v.stateslist',map[fields[i]]);
                        var value = component.get('v.stateslist');
                        
                    }else if(fields[i] === "Position_Status__c"){
                        component.set('v.positionlist',map[fields[i]]);
                    }else if(fields[i] === "TestMulti__c"){
                        component.set('v.testmultilist',map[fields[i]]); 
                    }
                }
            }
        });
        // enqueue the Action  
        $A.enqueueAction(action);
        
    },
    saveData : function(component,event,helper){
        helper.commitData(component,event,helper);
    },
    onfocus : function(component,event,helper){
        $A.util.addClass(component.find("mySpinner"), "slds-show");
        var forOpen = component.find("searchRes");
        $A.util.addClass(forOpen, 'slds-is-open');
        $A.util.removeClass(forOpen, 'slds-is-close');
        // Get Default 5 Records order by createdDate DESC  
        var getInputkeyWord = '';
        helper.searchHelper(component,event,getInputkeyWord);
    },
    onblur : function(component,event,helper){       
        component.set("v.listOfSearchRecords", null );
        var forclose = component.find("searchRes");
        $A.util.addClass(forclose, 'slds-is-close');
        $A.util.removeClass(forclose, 'slds-is-open');
    },
    keyPressController : function(component, event, helper) {
        // get the search Input keyword   
        var getInputkeyWord = component.get("v.SearchKeyWord");
        // check if getInputKeyWord size id more then 0 then open the lookup result List and 
        // call the helper 
        // else close the lookup result List part.   
        if( getInputkeyWord.length > 0 ){
            var forOpen = component.find("searchRes");
            $A.util.addClass(forOpen, 'slds-is-open');
            $A.util.removeClass(forOpen, 'slds-is-close');
            helper.searchHelper(component,event,getInputkeyWord);
        }
        else{  
            component.set("v.listOfSearchRecords", null ); 
            var forclose = component.find("searchRes");
            $A.util.addClass(forclose, 'slds-is-close');
            $A.util.removeClass(forclose, 'slds-is-open');
        }
    },
    
    // function for clear the Record Selaction 
    clear :function(component,event,heplper){
        var pillTarget = component.find("lookup-pill");
        var lookUpTarget = component.find("lookupField"); 
        
        $A.util.addClass(pillTarget, 'slds-hide');
        $A.util.removeClass(pillTarget, 'slds-show');
        
        $A.util.addClass(lookUpTarget, 'slds-show');
        $A.util.removeClass(lookUpTarget, 'slds-hide');
        
        component.set("v.SearchKeyWord",null);
        component.set("v.listOfSearchRecords", null );
        component.set("v.lookupvalue",false);
        component.set("v.selectedRecord", {} );   
        var err = component.find("errMsg");    
        $A.util.removeClass(err, 'slds-hide');
        $A.util.addClass(err, 'slds-show');
    },
    
    // This function call when the end User Select any record from the result list.   
    handleComponentEvent : function(component, event, helper) {
        // get the selected Account record from the COMPONETN event 	 
        var selectedAccountGetFromEvent = event.getParam("recordByEvent");
        component.set("v.selectedRecord" , selectedAccountGetFromEvent);
        component.set("v.managerid",selectedAccountGetFromEvent['Id']);
        component.set("v.lookupvalue",true);
        helper.commitData(component,event,helper);
        
        var forclose = component.find("lookup-pill");
        $A.util.addClass(forclose, 'slds-show');
        $A.util.removeClass(forclose, 'slds-hide');
        
        var forclose = component.find("searchRes");
        $A.util.addClass(forclose, 'slds-is-close');
        $A.util.removeClass(forclose, 'slds-is-open');
        
        var lookUpTarget = component.find("lookupField");
        $A.util.addClass(lookUpTarget, 'slds-hide');
        $A.util.removeClass(lookUpTarget, 'slds-show');  

        var err = component.find("errMsg");
        $A.util.addClass(err, 'slds-hide');
        $A.util.removeClass(err, 'slds-show');
        
    },
})