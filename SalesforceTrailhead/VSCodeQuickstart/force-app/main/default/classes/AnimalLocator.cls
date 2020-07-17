public with sharing class AnimalLocator {
    public static String getAnimalNameById(Integer animalId){
        Http http = new Http();
        String aName = '';
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+animalId);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserializes the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'animals' key as a list
            Map<String, Object> animal = (Map<String, Object>) results.get('animal');
            aName = (String)animal.get('name');
        }
        return aName;
    }
}
