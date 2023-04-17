@isTest
public class ErrorLogRecordInsertTest {
    @isTest
    static void insertErrorLogTest(){
        Test.startTest();
        String processName = 'Process 1';
        String logDetails = 'Error occurred during processing';
        ErrorLogRecordInsert.insertErrorLog(logDetails, processName);
        List<Error_Log__c> logs = [SELECT Process_Name__c, Log__c, Log_Details__c FROM Error_Log__c WHERE Process_Name__c = :processName];
        System.assertEquals(1, logs.size());
        Error_Log__c log = logs[0];
        System.assertEquals(processName, log.Process_Name__c);
        System.assertEquals(logDetails, log.Log_Details__c);
        Test.stopTest();
    }

}