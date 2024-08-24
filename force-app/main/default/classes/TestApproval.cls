public class TestApproval
 {
	    public static void submitAndProcessApprovalRequest(list<sObject> sobj) {	   
	 
            string uid = userinfo.getUserId();
	 		for(sObject so:sobj)
            {
                string soid = so.id;
	        // Create an approval request for the account
	        Approval.ProcessSubmitRequest req1 =
	            new Approval.ProcessSubmitRequest();
	        req1.setComments('Submitting request for approval.');
	        req1.setObjectId(soid);
	         
	        // Submit on behalf of a specific submitter
	        req1.setSubmitterId(uid);
	         
	        // Submit the record to specific process and skip the criteria evaluation
	        req1.setProcessDefinitionNameOrId('Account_Discount_Approval_Process');
	        req1.setSkipEntryCriteria(true);
	         
	        // Submit the approval request for the account
	        Approval.ProcessResult result = Approval.process(req1);
	         
	        // Verify the result
	        System.assert(result.isSuccess());
	         
	   /*     System.assertEquals(
	            'Pending', result.getInstanceStatus(),
			'Instance Status'+result.getInstanceStatus());  */
	  

            }}}