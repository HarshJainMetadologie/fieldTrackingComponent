@IsTest
public class FieldTrackingUtilsTest {

    @IsTest
    static void testGetTrackedFieldsMap() {
        Map<String, List<String>> trackedFieldsMap = FieldTrackingUtils.getTrackedFieldsMap();
        
         System.assertNotEquals(null, trackedFieldsMap, 'Tracked fields map should not be null.');
        
        System.assert(trackedFieldsMap.containsKey('Account'), 'Tracked fields should include Account object.');
        
        List<String> accountFields = trackedFieldsMap.get('Account');
        System.assert(accountFields != null && !accountFields.isEmpty(), 'Account should have at least one updateable field.');
        
        System.debug('Tracked Fields Map: ' + trackedFieldsMap);
    }

    @IsTest
    static void testEmptyOrSkippedObjects() {
        Map<String, List<String>> trackedFieldsMap = FieldTrackingUtils.getTrackedFieldsMap();
        System.assertNotEquals(null, trackedFieldsMap, 'Method should handle skipped objects gracefully.');
    }
}
