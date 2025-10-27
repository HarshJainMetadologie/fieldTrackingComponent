@isTest
public class contactTriggerTest1 {
    @isTest
    static void testContactTrigger() {
        Contact con = new Contact(FirstName = 'Test', LastName = 'User', Email = 'test@example.com');
        insert con;

        con.FirstName = 'Updated';
        update con;

        delete con;

        undelete con;

        List<Field_Tracker__c> trackers = [SELECT Id FROM Field_Tracker__c];
        System.assert(trackers.size() > 0);
    }
}
