global class WarehouseSyncSchedule implements Schedulable {
    global void execute(SchedulableContext context){
        WarehouseCalloutService.runWarehouseEquipmentSync();
    }
}