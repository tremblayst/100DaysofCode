@isTest
private class MaintenanceRequestTest {
    @isTest
    static void testMaintenanceRequest(){
        List<Product2> equipment = new List<Product2>();
        for(Integer i=0; i < 50; i++) {
            Product2 p = new Product2(Name='Equipment'+i,Replacement_Part__c=true,Maintenance_Cycle__c=i);
            equipment.add(p);
        }
        insert equipment;

        List<Case> cases = new List<Case>();
        for(Integer i=0; i < 200; i++) {
            Case c = new Case();
            cases.add(c);
        }
        insert cases;

        List<Work_Part__c> workparts = new List<Work_Part__c>();
        for(Integer i=0; i < 50; i++) {
            Work_Part__c wp = new Work_Part__c();
            wp.Equipment__c = equipment[i].Id;
            wp.Maintenance_Request__c = cases[i].Id;
            wp.Quantity__c = 1;
            workparts.add(wp);
        }
        insert workparts;

        for(Integer i=0; i < 50; i++) {
            cases[i].Status = 'Closed';
            cases[i].Type = 'Repair';
        }

        Test.startTest();
        update cases;
        Test.stopTest();

        List<Case> allCases = [SELECT Id FROM Case];

        System.assertEquals(250, allCases.size());
    }
}
