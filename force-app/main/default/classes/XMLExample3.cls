public class XMLExample3 
{
    public string result {get;set;}
	public XMLExample3()
    {
        DOM.Document xmldoc = new DOM.Document();
        DOM.XmlNode root = xmldoc.createRootElement('response',null,null);
        list<Account> lstacc = [select id,name,(select lastname,firstname from Contacts) from Account LIMIT 5];
        for(Account A:lstacc)
        {
            DOM.XmlNode acchild = root.addChildElement('Account',null,null);
            acchild.setAttribute('ID',A.Id);
            acchild.setAttribute('Name',A.Name);
            for(Contact C:A.Contacts)
            {
            	    DOM.XmlNode conchild = acchild.addChildElement('Contact',null,null);
                	DOM.XmlNode lastn = conchild.addChildElement('lastname',null,null);
                	lastn.addTextNode(C.LastName);
                	DOM.XmlNode firstn = conchild.addChildElement('firstname',null,null);
                	firstn.addTextNode(C.FirstName);
            }
        }
        result = xmldoc.toXmlString();
    }
}