trigger CandidateInfo on Candidate__c (before update) {
    insertController isrtc = new insertController();
    if(Trigger.isBefore){
        
   		isrtc.addErrror(Trigger.New);
        isrtc.updRec(Trigger.New);
    }
}