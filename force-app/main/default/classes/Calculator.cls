public class Calculator 
{
    public integer firstNumber{get;set;}
    public integer secondNumber{get;set;}
    public integer result{get;set;}
    
    public void sum()
    {
        result = firstNumber + secondNumber;
    }
    
    public void sub()
    {
        result = firstNumber - secondNumber;
    }
    
    public void mul()
    {
        result = firstNumber * secondNumber;
    }
    
    public void div()
    {
        if(firstNumber !=0 && secondNumber ==0  )
         {
             ApexPages.AddMessage(new ApexPages.Message(ApexPAges.Severity.Error, 'Division Operation Cannot be performed.'));
         }
         else
         {
            result = firstNumber / secondNumber;
         }
    }
}