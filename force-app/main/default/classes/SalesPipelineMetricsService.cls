public with sharing class SalesPipelineMetricsService {
    public SalesPipelineMetricsService() {

    }

    public class PipelineMetrics {

        @AuraEnabled
        public Decimal openPipelineValue {get; set;}

        @AuraEnabled
        public Decimal closedWonRevenue {get; set;}

        @AuraEnabled
        public Integer openOpportunityCount {get; set;}

        @AuraEnabled
        public Integer closedWonOpportunityCount {get; set;}
    }

    @AuraEnabled(cacheable=true)
    public static PipelineMetrics getMetrics(){

        
        try {

            PipelineMetrics metrics = new PipelineMetrics();
            // open pipeline metrics
            AggregateResult openResult = [ SELECT SUM(Amount) totalAmount, COUNT(Id) totalCount FROM Opportunity WHERE StageName NOT IN ('Closed Won', 'Closed Lost')];

            metrics.openPipelineValue = (Decimal) openResult.get('totalAmount');
            metrics.openOpportunityCount = (Integer) openResult.get('totalCount');

            // closed won metrics
            AggregateResult wonResult = [ SELECT SUM(Amount) totalAmount, COUNT(Id) totalCount FROM Opportunity WHERE StageName = 'Closed Won'];

            metrics.closedWonRevenue = (Decimal) wonResult.get('totalAmount');
            metrics.closedWonOpportunityCount = (Integer) wonResult.get('totalCount');

            if (metrics.openPipelineValue == null){
                metrics.openPipelineValue = 0;
            }
            if (metrics.closedWonRevenue == null) {
                metrics.closedWonRevenue = 0;
            }

            return metrics;            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}