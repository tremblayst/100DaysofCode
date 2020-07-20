public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    public class WarehouseCalloutServiceRecord{
        //public string _id;
        public Boolean replacement;
        public Integer quantity;
        public string name;
        public Integer maintenanceperiod;
        public Integer lifespan;
        public Integer cost;
        public string sku;
    }

//{"_id":"55d66226726b611100aaf741","replacement":false,"quantity":5,"name":"Generator 1000 kW","maintenanceperiod":365,"lifespan":120,"cost":5000,"sku":"100003"}

    @future(callout=true)
    public static void runWarehouseEquipmentSync() {
        List<Product2> equipmentToUpdate = new List<Product2>();
     
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            List<WarehouseCalloutServiceRecord> results = (List<WarehouseCalloutServiceRecord>) JSON.deserialize(response.getBody(),List<WarehouseCalloutServiceRecord>.class);
            for(WarehouseCalloutServiceRecord wcsr : results){
                Product2 equip = new Product2();
                equip.Replacement_Part__c = true;
                equip.Name = wcsr.name;
                equip.Cost__c = wcsr.cost;
                equip.Current_Inventory__c = wcsr.quantity;
                equip.Lifespan_Months__c = wcsr.lifespan;
                equip.Maintenance_Cycle__c = wcsr.maintenanceperiod;
                equip.Warehouse_SKU__c = wcsr.sku;
                equipmentToUpdate.add(equip);
            }
        }  
        
        if(equipmentToUpdate.size() > 0)
        {
            upsert equipmentToUpdate;
        }
    }
}
