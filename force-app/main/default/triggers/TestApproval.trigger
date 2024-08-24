trigger TestApproval on Account (after insert) 
{
	if(Trigger.isinsert && Trigger.isafter)
    {
        TestApproval.submitAndProcessApprovalRequest(Trigger.new);
    }
}