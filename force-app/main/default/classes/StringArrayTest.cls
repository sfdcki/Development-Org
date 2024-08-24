public class StringArrayTest {
	public static List<String> generateStringArray(Integer n)
    {
        List<String> retStr = new List<String>();
        for(Integer i=0;i<n;i++)
        {
            String a = 'Test '+i;
            retStr.add(a);
            System.debug(a);
        }
        return retStr;
        
    }
}