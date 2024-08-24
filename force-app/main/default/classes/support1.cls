global class support1 {
 
    	public Id caseId {set;get;}
    @RemoteAction
    global static Id caseIsrt(string name, string email, string info)
    {
     	Case wCase;
        
        wCase = new Case();
        wCase.Name__c = name;
        wCase.Email__c = email;
        wCase.Description = info;
        wCase.Subject = 'Live Agent Data';
        insert wCase;
        //caseId = wCase.Id;
        return wCase.Id;
        
		//AssignmentRule AR = new AssignmentRule();
		//AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1];

		//Creating the DMLOptions for "Assign using active assignment rules" checkbox
		//Database.DMLOptions dmlOpts = new Database.DMLOptions();
		//dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;

		//Case newCase = new Case(Status = 'New') ;
		//Setting the DMLOption on Case instance
		//newCase.setOptions(dmlOpts);
		//insert newCase ;        
    }

}