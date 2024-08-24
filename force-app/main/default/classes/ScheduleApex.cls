Global class ScheduleApex implements System.Schedulable
{
   	Global void Execute(System.SchedulableContext SC)
    {
        NewBatch Nb = new NewBatch();
		Database.executeBatch(Nb, 5);
    }
}