public with sharing class FieldTrackingHandler {

    public static void trackChanges(List<SObject> oldList, List<SObject> newList, String operation) {
        if (newList == null && oldList == null) return;

        List<Field_Tracker__c> trackingList = new List<Field_Tracker__c>();
        String objectName = (newList != null && !newList.isEmpty())
            ? newList[0].getSObjectType().getDescribe().getName()
            : oldList[0].getSObjectType().getDescribe().getName();
        Map<String, List<String>> fieldsToTrack = FieldTrackingUtils.getTrackedFieldsMap();
        List<String> trackFields = fieldsToTrack.get(objectName);

        if (trackFields == null || trackFields.isEmpty()) return;

        Integer recordCount = (newList != null) ? newList.size() : oldList.size();

        for (Integer i = 0; i < recordCount; i++) {
            SObject newRec = (newList != null) ? newList[i] : null;
            SObject oldRec = (oldList != null) ? oldList[i] : null;

            for (String field : trackFields) {
                Object oldVal = (oldRec != null) ? oldRec.get(field) : null;
                Object newVal = (newRec != null) ? newRec.get(field) : null;

                Boolean hasChanged = false;

                if (operation == 'Update') {
                    hasChanged = (oldVal != newVal);
                } else if (operation == 'Insert' || operation == 'Delete') {
                    hasChanged = true;
                }

                if (hasChanged) {
                    trackingList.add(new Field_Tracker__c(
                        Object_Name__c = objectName,
                        Field_Name__c = field,
                        Old_Value__c = (oldVal != null) ? String.valueOf(oldVal) : null,
                        New_Value__c = (newVal != null) ? String.valueOf(newVal) : null,
                        Change_By__c = UserInfo.getUserId(),
                        Change_Date__c = System.now(),
                        Operation__c = operation,
                        Identification__c = (newRec != null) ? newRec.Id : oldRec.Id
                    ));
                }
            }
        }

        if (!trackingList.isEmpty()) {
            insert trackingList;
        }
    }
}
