public class AccountHandler {
	public static Account insertNewAccount(String data)
    {
 		Account act = new Account();   
        if(data != ''){
            act.Name = data;
            insert act;
            return act;
            }
        else
        {
            return null;
        }
     
    }
}