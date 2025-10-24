public with sharing class FieldTrackingUtils {

    public static Map<String, List<String>> getTrackedFieldsMap() {
        Map<String, List<String>> trackedFieldsMap = new Map<String, List<String>>();
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();

        for (String objectName : globalDescribe.keySet()) {
            try {
                Schema.DescribeSObjectResult describeResult = globalDescribe.get(objectName).getDescribe();
                if (!describeResult.isQueryable() || !describeResult.isCreateable() || describeResult.isCustomSetting()) {
                    continue;
                }

                Map<String, Schema.SObjectField> fieldsMap = describeResult.fields.getMap();
                List<String> fieldList = new List<String>();

                for (String fieldName : fieldsMap.keySet()) {
                    Schema.DescribeFieldResult fieldDescribe = fieldsMap.get(fieldName).getDescribe();
                    if (fieldDescribe.isUpdateable()) {
                        fieldList.add(fieldName);
                    }
                }

                if (!fieldList.isEmpty()) {
                    trackedFieldsMap.put(describeResult.getName(), fieldList);
                }

            } catch (Exception e) {
                System.debug('Skipping object: ' + objectName + ' → ' + e.getMessage());
            }
        }

        return trackedFieldsMap;
    }
}
