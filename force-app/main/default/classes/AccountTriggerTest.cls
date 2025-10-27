@isTest
public class AccountTriggerTest {
    @isTest
    static void testAccountTrigger() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        acc.Name = 'Updated Account';
        update acc;

        delete acc;

        undelete acc;

        List<Field_Tracker__c> trackers = [SELECT Id, Operation__c FROM Field_Tracker__c];
        System.assert(trackers.size() > 0);
    }
}
