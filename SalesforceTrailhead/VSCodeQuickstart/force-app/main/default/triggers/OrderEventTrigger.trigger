trigger OrderEventTrigger on Order_Event__e (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        List<Task> tasks = new List<Task>();
        for (Order_Event__e event : Trigger.new){
            if (event.Has_Shipped__c == true){
                Task t = new Task(Subject='Follow up on shipped order ' + event.Order_Number__c, Priority='Medium', OwnerId=event.CreatedById);
                tasks.add(t);
            }
        }

        if(tasks.size() > 0){
            insert tasks;
        }
    }
}