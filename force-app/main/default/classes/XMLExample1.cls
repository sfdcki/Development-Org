public class XMLExample1 
{
    public string result {set;get;}
	public XMLExample1()
    {
        DOM.Document xmldoc = new DOM.Document();
        DOM.XmlNode root = xmldoc.createRootElement('name',null,null);
        DOM.XmlNode Child1 = root.addChildElement('lastname',null,null);
        Child1.addTextNode('Athmakuri');
        DOM.XmlNode Child2 = root.addChildElement('firstname',null,null);
        Child2.addTextNode('Udaya Kiran');
        Child2.addCommentNode('Name of the first employee');
        result = xmldoc.toXmlString();
    }
}