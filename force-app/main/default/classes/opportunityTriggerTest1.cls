@isTest
public class opportunityTriggerTest1 {
    @isTest
    static void testOpportunityTrigger() {
        Opportunity opp = new Opportunity(Name = 'Test Opportunity', StageName = 'Prospecting', CloseDate = System.today());
        insert opp;

        opp.StageName = 'Qualification';
        update opp;

        delete opp;

        undelete opp;

        List<Field_Tracker__c> trackers = [SELECT Id FROM Field_Tracker__c];
        System.assert(trackers.size() > 0);
    }
}
