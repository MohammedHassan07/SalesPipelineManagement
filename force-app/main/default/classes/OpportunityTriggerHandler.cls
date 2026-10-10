public with sharing class OpportunityTriggerHandler {
    public OpportunityTriggerHandler() {

    }

    public static void validateOpportunities(List<Opportunity> opportunities) {

        for (Opportunity opp : opportunities) {

            // amount cannot be negative
            if (opp.Amount != null && opp.Amount < 0) {
                opp.addError('Opportunity Amount cannot be negative.');
            }

            // closed requires a +ve value
            if (opp.stageName == 'Closed Won' && (opp.Amount == null || opp.Amount <= 0)) {

                opp.addError('A Closed Won opportunity must have a positive Amount.');
            }
        }
    }
}