@isTest
public class FieldTrackingControllerTest {
    @isTest
    static void testGetTrackingData() {
        Field_Tracker__c tracker = new Field_Tracker__c(
            Object_Name__c = 'Opportunity',
            Field_Name__c = 'Amount',
            Old_Value__c = '235000.00',
            New_Value__c = '235.00',
            Change_Date__c = System.now(),
            Operation__c = 'Update',
            Identification__c = '006d200000DHV56AAH'
        );
        insert tracker;

        Test.startTest();
        List<Field_Tracker__c> results = FieldTrackingController.getTrackingData(tracker.Identification__c);
        Test.stopTest();

        System.assertEquals(1, results.size(), 'Should return one record');
    }
}
