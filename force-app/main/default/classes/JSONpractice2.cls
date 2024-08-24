public class JSONpractice2 
{
    public string testGen {get;set;}
    
    public void show()
    {
        system.JSONGenerator js = json.createGenerator(false);
        js.writeStartObject();
        	js.writeFieldName('Employee Name');
        	js.writeString('udaya kiran');
        	js.writeStringField('Manager Name','athmakuri');
        	js.writeFieldName('Age');
        	js.writeNumber(20);
        
        js.writeEndObject();
        testGen = js.getAsString();
        
    }
}