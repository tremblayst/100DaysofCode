public with sharing class AccountUtils {
    public AccountUtils() {

    }

    public static List<Account> accountsByState(string state){
        return new List<Account>{[SELECT Id,Name FROM Account WHERE BillingState = :state]};
    }
}
