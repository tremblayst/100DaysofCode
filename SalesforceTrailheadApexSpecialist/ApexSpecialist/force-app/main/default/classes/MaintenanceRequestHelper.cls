public with sharing class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(List<Case> cases, Map<Id,Case> oldCases) {
        List<Case> newCases = new List<Case>();
        //List<Work_Part__c> parts = [Select Id, Maintenance_Request__c, Equipment__r.Maintenance_Cycle__c FROM Work_Part__c WHERE Maintenance_Request__c IN :oldCases.keys()];
        Set<Id> caseIds = oldCases.keySet();
        Map<Id, Decimal> workpartsbycase = new Map<Id, Decimal>();
        for (AggregateResult aggRes : [
              SELECT MIN(Equipment__r.Maintenance_Cycle__c) mincycle, Maintenance_Request__c caseId
              FROM Work_Part__c
              WHERE Maintenance_Request__c IN :caseIds
              GROUP BY Maintenance_Request__c]) {
            Id caseId = (Id) aggRes.get('caseId');
            Decimal mincycle = (Decimal) aggRes.get('mincycle');
            workpartsbycase.put(caseId, mincycle);
        }

        for(Case c : cases){
            Case c_old = oldCases.get(c.Id);
            if (c.Status == 'Closed' && c.Status != c_old.Status && (c.Type == 'Routine Maintenance' || c.Type == 'Repair')){
                Case newCase = new Case();

                newCase.Equipment__c = c.Equipment__c;
                newCase.Vehicle__c = c.Vehicle__c;
                newCase.Type = 'Routine Maintenance';
                newCase.Subject = 'Routine Maintenance';
                newCase.Date_Reported__c = Datetime.now().date();
                newCase.Date_Due__c = Datetime.now().date();
                if(workpartsbycase.containsKey(c.Id)){
                    newCase.Date_Due__c.addDays(workpartsbycase.get(c.Id).intValue());
                }
                newCases.add(newCase);
            }
        }

        if(newCases.size() > 0){
            insert newCases;
        }
        
    }        
    
}
