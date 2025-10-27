@isTest
public class FieldTrackingHandlerTest {
    @isTest
    static void testTrackChanges() {
        Account oldAcc = new Account(Name = 'Old Name');
        insert oldAcc;

        Account newAcc = new Account(Id = oldAcc.Id, Name = 'New Name');

        Test.startTest();
        FieldTrackingHandler.trackChanges(new List<SObject>{oldAcc}, new List<SObject>{newAcc}, 'Update');
        FieldTrackingHandler.trackChanges(null, new List<SObject>{newAcc}, 'Insert');
        FieldTrackingHandler.trackChanges(new List<SObject>{oldAcc}, null, 'Delete');
        Test.stopTest();

        List<Field_Tracker__c> trackers = [SELECT Id FROM Field_Tracker__c];
        System.assert(trackers.size() > 0);
    }
}
