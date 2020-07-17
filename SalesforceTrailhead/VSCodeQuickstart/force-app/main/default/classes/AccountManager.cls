@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount(){
        String aId = '';
        RestRequest request = RestContext.request;
        List<String> splitrequest = request.requestURI.split('/'); 
        aId = splitrequest.get(splitrequest.size()-2);
        System.debug(aId);
        Account result =  [SELECT Id,Name,(SELECT Id, Name FROM Contacts)
                        FROM Account
                        WHERE Id = :aId LIMIT 1];
        
        return result;
    }
}
