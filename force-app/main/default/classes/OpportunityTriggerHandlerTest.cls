/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class OpportunityTriggerHandlerTest {

    private static Account createAccount() {

        Account acc = new Account (Name='Sales Pipeline Test Account');

        insert acc;
        return acc;
    }

    private static Opportunity createOpportunity (Id accountId, String stageName, Decimal amount) {

        return new Opportunity(
            Name = 'Test Opportunity',
            AccountId = accountId,
            CloseDate = Date.today().addDays(30),
            Amount = amount,         
            StageName = stageName
        );

    }

    @isTest
    static void testValidOpportunityInsert() {
       
        Account acc = createAccount();

        Opportunity opp = createOpportunity(acc.Id, 'Qualification', 100000);

        Test.startTest();
        insert opp;
        Test.stopTest();

        Opportunity savedOpp = [SELECT Id, Amount, StageName FROM Opportunity WHERE Id = :opp.Id];

        System.assertEquals(100000, savedOpp.Amount);
        System.assertEquals('Qualification', savedOpp.StageName);
    }

    @isTest
    static void testNegativeAmountRejected(){

        Account acc = createAccount();

        Opportunity opp = createOpportunity(acc.Id, 'Qualification', -100);

        Test.startTest();
        Database.SaveResult result = Database.insert(opp, false);
        Test.stopTest();

        System.assertEquals(false, result.isSuccess());

        System.assert(result.getErrors()[0].getMessage().contains('Opportunity Amount cannot be negative.'));
    }

    @isTest
    static void testCloseedWonWithZeroAmountRejected() {

        Account acc = createAccount();

        Opportunity opp = createOpportunity(acc.Id, 'Closed Won', 0);

        Test.startTest();
        Database.SaveResult result = Database.insert(opp, false);
        Test.stopTest();

        System.assertEquals(false, result.isSuccess());
        System.assert(result.getErrors()[0].getMessage().contains('A Closed Won opportunity must have a positive Amount.'));
    }

    @isTest
    static void testValidClosedWonOpportunity () {

        Account acc = createAccount();

        Opportunity opp = createOpportunity(acc.Id, 'Closed Won', 150000);

        Test.startTest();
        insert opp;
        Test.stopTest();

        System.assertNotEquals(null, opp.Id);
    }

    @IsTest
    static void testNegativeAmountUpdateRejected() {

        Account acc = createAccount();

        Opportunity opp = createOpportunity(
            acc.Id,
            'Qualification',
            100000
        );

        insert opp;

        opp.Amount = -500;

        Test.startTest();

        Database.SaveResult result = Database.update(opp, false);

        Test.stopTest();

        System.assertEquals(false, result.isSuccess());

        System.assert(result.getErrors()[0].getMessage().contains('Opportunity Amount cannot be negative.'));
    }

    @IsTest
    static void testBulkOpportunityInsert() {

        Account acc = createAccount();

        List<Opportunity> opportunities = new List<Opportunity>();

        for (Integer i = 0; i < 200; i++) {

            opportunities.add(createOpportunity(acc.Id, 'Qualification',1000 + i));
        }

        Test.startTest();

        insert opportunities;

        Test.stopTest();

        System.assertEquals(200,
            [
                SELECT COUNT()
                FROM Opportunity
                WHERE AccountId = :acc.Id
            ]
        );
    }
}