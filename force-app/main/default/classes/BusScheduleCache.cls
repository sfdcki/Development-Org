public class BusScheduleCache {
    private Cache.OrgPartition part;
    public BusScheduleCache()
    {
        Cache.OrgPartition newp = Cache.Org.getPartition('local.BusSchedule');
        part = newp;
    }
	public void putSchedule(String busLine, Time[] schedule)
    {
        	part.put('BSchedule', schedule);
    }
    public Time[] getSchedule(String busLine)
    {
        Time[] temp;
        temp = (Time[])part.get('BSchedule');
        if(!temp.IsEmpty())
        {
        	return temp;
        }
        else
        {
            time[] myTime;
            myTime[0] = Time.newInstance(8,0,0,0);
            myTime[1] = Time.newInstance(17,0,0,0);
            return myTime;
        }
    }
}