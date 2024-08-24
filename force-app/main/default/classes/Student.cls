public class Student
{ 
    public integer StudentID;
    public string StudentName;
    public string StudentAddress;
    
    public void Student()
    {
    StudentID = 1234;
    StudentName = 'Udaya';
    StudentAddress = 'hyderabad';
    }
    
    public void Display()
    {
    System.Debug('StudentID' + StudentID);
    System.Debug('StudentName' + StudentName);
    System.Debug('StudentAddress' + StudentAddress);
    }
}