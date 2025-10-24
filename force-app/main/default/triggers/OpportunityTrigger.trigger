trigger OpportunityTrigger on Opportunity (after insert, after update, after delete, after undelete) {
    if (Trigger.isInsert) {
        FieldTrackingHandler.trackChanges(null, Trigger.new, 'Insert');
    } else if (Trigger.isUpdate) {
        FieldTrackingHandler.trackChanges(Trigger.old, Trigger.new, 'Update');
    } else if (Trigger.isDelete) {
        FieldTrackingHandler.trackChanges(Trigger.old, null, 'Delete');
    } else if (Trigger.isUndelete) {
        FieldTrackingHandler.trackChanges(null, Trigger.new, 'Undelete');
    }
}
