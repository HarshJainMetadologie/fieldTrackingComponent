public with sharing class FieldTrackingController {
    @AuraEnabled(cacheable=true)
    public static List<Field_Tracker__c> getTrackingData(Id recordId) {
        return [
            SELECT Field_Name__c, Old_Value__c, New_Value__c, Change_By__r.Name,
                   Change_Date__c, Object_Name__c
            FROM Field_Tracker__c
            WHERE Identification__c = :recordId
            ORDER BY Change_Date__c DESC
        ];
    }
}
