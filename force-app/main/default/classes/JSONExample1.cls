public class JSONExample1 {
    public String 	dateValue {set;get;}
    public String 	dateValue1 {set;get;}
    public string   stringValue {set;get;}
    public string   stringValue1 {set;get;}
    public String   objectValue {set;get;}
    public String   sobjectValue {set;get;}
    public string  arrayresult {get;set;}
    public Account acc1 {set;get;}
    public Account acc2 {set;get;}
    public string arrObject {set;get;}
    public string arrswrap {set;get;}
    
    public void show(){
        string[] a = new string[]{'hyd','chn','bng'}; 
        arrayresult = JSON.serialize(a);
        string name = 'udayakiran';
		stringValue = JSON.serialize(name);    
        stringValue1 = JSON.serializePretty(name);
        DateTime dt = System.now();
        dateValue = JSON.serialize(dt);
        dateValue1 = JSON.serializePretty(dt);
        Account acc = new Account(name='udayakiran',phone='8438298212');
        sobjectValue = JSON.serialize(acc);
        string cindo = '{"name":"udayakiran","Industry":"Agri"}';
        list<Account> lstAcc = new list<Account>{acc,acc,acc};
            arrObject = JSON.serialize(lstAcc);
        acc1 = (Account)JSON.deserialize(cindo,Account.class);
        acc2 = (Account)JSON.deserializeStrict(sobjectValue,Account.class);
        StudentWrapper stwrap = new StudentWrapper();
        stwrap.name = 'udaya kiran';
        stwrap.branch = 'chilakaluripet';
        stwrap.salary = 10000;
        list<StudentWrapper> lstWrap = new list<StudentWrapper>{stwrap,stwrap,stwrap};
            arrswrap = JSON.serialize(lstWrap);
    }
}