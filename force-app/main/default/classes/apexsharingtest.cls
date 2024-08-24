public class apexsharingtest {

    public void insertSharerecord(Id recid, Id userId)
    {
        string objname = recid.getSObjectType().getDescribe().getName();
        string objshr = objname + 'Share';
 
        
    }
}