@isTest
private class AccountManagerTest {
    @isTest
    static void testAccountManager(){
        Account a = new Account(Name='Test Account');
        insert a;
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://creative-unicorn-ts3psq-dev-ed.my.salesforce.com/services/apexrest/Accounts/'+ a.Id +'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account account = AccountManager.getAccount();
        // Verify results
        System.assert(account != null);
        System.assertEquals('Test Account', account.Name);
    }
}
