public class XMLExample2 
{
    public string result {set;get;}
	public XMLExample2()
    {
        DOM.Document xmldoc = new DOM.Document();
        DOM.XmlNode root = xmldoc.createRootElement('response',null,null);
        list<Account> lstacc = [select id,name from Account LIMIT 5];
        for(Account A:lstacc)
        {
            DOM.XmlNode accountnode = root.addChildElement('Account',null,null);
            accountnode.setAttribute('id',A.id);
            accountnode.setAttribute('name',A.Name);
        }
        result = xmldoc.toXmlString();
    }
}