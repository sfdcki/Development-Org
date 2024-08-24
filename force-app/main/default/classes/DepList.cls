public class DepList 
{
    Public List<SelectOption> lstCity {get;set;}
    Public List<SelectOption> lstPlace {get;set;}
    public list<String> StrCity;
   
    public string[] city;
    public string[] place1,place2,place3;
    public string selectedCity {get;set;}
    public DepList()
    {
        lstCity = new List<SelectOption>(); 
        lstPlace = new List<SelectOption>();
        StrCity = new list<String>();
        City = new String[]{'Hyderabad','Bangalore','Chennai'};
        for(String Str:City)
        {
            lstCity.add(new SelectOption(Str,Str));
            StrCity.add(Str);
        }
        lstPlace.Add(new SelectOption('','--None--'));
    }
    
    public void CityPlace()
    { 
        lstPlace = new List<SelectOption>();
        place1 = new String[]{'Ameerpet','Panjagutta','lingampally','chanda nagar','cine town theater'};
        place2 = new String[]{'electronic city','marthahalli','Hebbballa','kr puram','chinna sandra'};
        place3 = new String[]{'Velachery','OMR road','thoraipakkam','navallur','siruseri'}; 
        
        if(selectedCity == StrCity.get(0))
        {
            
            for(String Str1:place1)
            {
                lstPlace.add(new SelectOption(Str1,Str1));
            }
        }
        else if(selectedCity == StrCity.get(1))
        {
            
            for(String Str1:place2)
            {
                lstPlace.add(new SelectOption(Str1,Str1));
            }
        }
        else if(selectedCity == StrCity.get(2))
        {
            
            for(String Str1:place3)
            {
                lstPlace.add(new SelectOption(Str1,Str1));
            }
        }   
       
    }
}