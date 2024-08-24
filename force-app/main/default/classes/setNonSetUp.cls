public class setNonSetUp 
{
	public void checkObject()
    {
        list<PermissionSet> permissionList = [select Id, Description from PermissionSet];
        list<Account> accList = [select id,name,industry from Account];
    }
}