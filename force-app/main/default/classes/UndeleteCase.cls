public class UndeleteCase {
    public static void CaseUndelete()
    {
        list<case> Ca1 = [select Accountid,casenumber from case where isdeleted = true all rows];
        system.debug('size is :'+Ca1.size());
        if(!Ca1.isEmpty())
        {
            for(Case Ca:Ca1)
            {
                System.debug('deleted case record is:'+Ca);
            }
        }
    }

}