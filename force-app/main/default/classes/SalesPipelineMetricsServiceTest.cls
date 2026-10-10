@IsTest
private class SalesPipelineMetricsServiceTest {

    @TestSetup
    static void setupData() {

        Account acc = new Account(Name = 'Pipeline Metrics Test Account');
        insert acc;

        List<Opportunity> opportunities = new List<Opportunity>{
                new Opportunity(
                    Name = 'Open Deal One',
                    AccountId = acc.Id,
                    StageName = 'Qualification',
                    CloseDate = Date.today().addDays(15),
                    Amount = 100000
                ),
                new Opportunity(
                    Name = 'Open Deal Two',
                    AccountId = acc.Id,
                    StageName = 'Qualification',
                    CloseDate = Date.today().addDays(30),
                    Amount = 200000
                ),
                new Opportunity(
                    Name = 'Won Deal',
                    AccountId = acc.Id,
                    StageName = 'Closed Won',
                    CloseDate = Date.today(),
                    Amount = 150000
                )
            };

        insert opportunities;
    }

    @IsTest
    static void testPipelineMetrics() {

        Test.startTest();

        SalesPipelineMetricsService.PipelineMetrics metrics =
            SalesPipelineMetricsService.getMetrics();

        Test.stopTest();

        System.assertEquals(
            Decimal.valueOf('300000'),
            metrics.openPipelineValue,
            'Open pipeline value should equal 300000.'
        );

        System.assertEquals(
            Decimal.valueOf('150000'),
            metrics.closedWonRevenue,
            'Closed-won revenue should equal 150000.'
        );

        System.assertEquals(
            2,
            metrics.openOpportunityCount,
            'There should be two open opportunities.'
        );

        System.assertEquals(
            1,
            metrics.closedWonOpportunityCount,
            'There should be one closed-won opportunity.'
        );
    }
}