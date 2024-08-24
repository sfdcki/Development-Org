public class JSONDeser 
{
    public StudentWrapper studentw {set;get;}
    public map<string,object> stuObject {set;get;}
    public void show()
    {
        string temp = '{"name":"udaya kiran","branch":"guntur","salary":10000}';
        studentw = (StudentWrapper)JSON.deserialize(temp,StudentWrapper.class);
        stuObject = (map<string,object>)JSON.deserializeUntyped(temp);
    }
}