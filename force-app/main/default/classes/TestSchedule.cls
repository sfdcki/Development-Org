public class TestSchedule
{
	public void show()
    {
        string Cron_Exp = '0 10 8 10 * ?';
        ScheduleApex MS = new ScheduleApex();
        system.schedule('NewBatch',Cron_Exp,MS);
    }
}